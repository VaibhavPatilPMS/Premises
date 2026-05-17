import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:premises/common/utils/app_constants.dart';
import 'package:premises/common/utils/extensions.dart';

class FileUtils {
  FileUtils._();

  static Future<String> getFileDirectoryPath() async {
    String storagePath = '';
    if (Platform.isIOS) {
      Directory storageDir = await getApplicationDocumentsDirectory();
      storagePath = storageDir.path;
    } else {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt.toInt() < 30) {
        storagePath = "${await _getPath()}/";
      } else {
        storagePath = "${await _createAppFolder()}/";
      }
    }
    return storagePath;
  }

  static Future<String> _getPath() async {
    Directory? directory = await getExternalStorageDirectory();

    return directory!.path;
  }

  static Future<String> _createAppFolder() async {
    final Directory? directory = await getExternalStorageDirectory();
    final dirPath = '${directory!.path}/safety_app';
    if (await Directory(dirPath).exists()) {
      return dirPath.toString();
    } else {
      await Directory(dirPath).create();
      return dirPath.toString();
    }
  }

  static getFileSize({File? file, dynamic size, required int decimals}) {
    try {
      if (file != null) {
        int bytes = file.lengthSync();
        if (bytes <= 0) return "0 B";
        const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
        var i = (log(bytes) / log(1024)).floor();
        return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
      } else if (size != null) {
        int bytes = int.parse(size.toString());
        if (bytes <= 0) return "0 B";
        const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
        var i = (log(bytes) / log(1024)).floor();
        return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static getFileName(String filePath) {
    String fileName;
    fileName = filePath.split('/').last;
    return fileName.toBeginningOfSentence();
  }

  static bool checkXFileSize({XFile? xfile}) {
    File? file = File(xfile!.path);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb <= FileSizeLimit.bulkFileSize) {
      return true;
    } else {
      return true;
    }
  }

  static File convertXfileToFile({XFile? xfile}) {
    return File(xfile!.path);
  }

  static bool checkFileSize({File? file}) {
    int sizeInBytes = file!.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb <= FileSizeLimit.bulkFileSize) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkXFileListSize({required List<XFile?>? fileList}) {
    double totalFileSize = 0;
    if (fileList?.length == 1) {
      if (totalFileSize <= FileSizeLimit.singleFileSize) {
        return true;
      } else {
        return false;
      }
    } else {
      for (var element in fileList!) {
        File? file = File(element!.path);
        int sizeInBytes = file.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        totalFileSize = (totalFileSize + sizeInMb);
      }
      if (totalFileSize <= FileSizeLimit.bulkFileSize) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool checkFileListSize({required List<File>? fileList}) {
    double totalFileSize = 0;
    if (fileList == 1) {
      if (totalFileSize <= FileSizeLimit.singleFileSize) {
        return true;
      } else {
        return false;
      }
    } else {
      for (var element in fileList!) {
        int sizeInBytes = element.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        totalFileSize = (totalFileSize + sizeInMb);
      }
      if (totalFileSize <= FileSizeLimit.bulkFileSize) {
        return true;
      } else {
        return false;
      }
    }
  }
}
