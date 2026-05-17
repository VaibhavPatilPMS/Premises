import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/common/utils/utils.dart';

class DownloadPdf {
  DownloadPdf._();

  static Future<void> downloadAndOpenPdf({
    required String moduleName,
    required String url,
    String? fileName,
  }) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to download file');
    }

    MixpanelService().pdfDownloadEvent(
      username: AppData().userDetailsUiModel?.username,
      userrole: AppData().userDetailsUiModel?.designation,
      moduleName: moduleName,
      recordId: fileName,
      projectId: AppData().userCurrentSelectedProject?.projectName,
      platform: Platform.isIOS ? 'iOS' : 'Android',
    );

    final name = fileName ?? url.split('/').last;

    final savedPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: name,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      bytes: response.bodyBytes,
    );

    if (savedPath != null && savedPath.isNotEmpty) {
      String openPath = savedPath;

      // Android SAF can return non-filesystem document paths (e.g. /document/40551).
      // Write a temp file and open that when needed.
      if (savedPath.startsWith('/document/')) {
        final tempDir = await getTemporaryDirectory();
        final normalizedName =
            name.toLowerCase().endsWith('.pdf') ? name : '$name.pdf';
        final tempFile = File('${tempDir.path}/$normalizedName');
        await tempFile.writeAsBytes(response.bodyBytes, flush: true);
        openPath = tempFile.path;
      }

      await FileOpener.openFile(openPath);
    }
  }
}
