import 'package:open_app_file/open_app_file.dart';

class FileOpener {
  FileOpener._(); // private constructor to prevent instantiation

  static Future<void> openFile(String filePath) async {
    await OpenAppFile.open(filePath);
  }
}