import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/app_strings.dart';
import 'package:premises/common/utils/permission_utils.dart';
import 'package:premises/common/utils/utils.dart';

class ImagePickerUtils {
  ImagePickerUtils._();

  static File? file;

  static Future<PermissionStatus> requestFilePermission() async {
    PermissionStatus result;
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }
    return result;
  }

  static Future<List<File>?> checkPermissionsAndPick(
    BuildContext context, {
    List<String>? allowedFileExtensionsList,
    bool? isMultipleSelect = false,
    bool? isTwelveMBAllowed,
  }) async {
    bool? hasFilePermission = false;
    List<File> returnFileList = [];
    List<String>? allowedFileExtensions;
    bool? isallowMultiple = isMultipleSelect ?? false;
    bool? isTwelveMB = isTwelveMBAllowed ?? false;
    allowedFileExtensions =
        allowedFileExtensionsList ??
        ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'txt', 'xls', 'xlsx'];
    // final bool? result =
    //     await PermissionUtils().handleStoragePermission(context);

    // if (result!) {
    //   hasFilePermission = true;
    // } else {
    //   hasFilePermission =
    //       await PermissionUtils().handleStoragePermission(context);
    // }

    hasFilePermission = true;

    if (hasFilePermission!) {
      try {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: isallowMultiple,
          allowCompression: true,
          allowedExtensions: allowedFileExtensions,
        );

        if (result != null && result.files.isNotEmpty) {
          if (result.files.length <= 5 && isMultipleSelect == true) {
            for (var element in result.files) {
              File file = File(element.path!);
              if (checkFileSizeInMb(
                file: file,
                dynamicFileSizeInMB: isTwelveMB ? 12 : 5,
              )) {
                if (ImagePickerUtils.checkFileIsDocument(
                      extension(file.path),
                    ) ||
                    ImagePickerUtils.checkFileIsImage(extension(file.path))) {
                  returnFileList.add(file);
                } else {
                  "File Type Not Supported".showAsToast(
                    context: context,
                    type: ToastType.TOAST_ERROR,
                  );
                  //return;
                }
              } else {
                isTwelveMB
                    ? "Please select file less than 12 MB".showAsToast(
                        context: context,
                        type: ToastType.TOAST_ERROR,
                      )
                    : "Please select file less than 5 MB".showAsToast(
                        context: context,
                        type: ToastType.TOAST_ERROR,
                      );
                //return;
              }
            }
          } else if (isMultipleSelect == false) {
            for (var element in result.files) {
              File file = File(element.path!);
              if (checkFileSizeInMb(
                file: file,
                dynamicFileSizeInMB: isTwelveMB ? 12 : 5,
              )) {
                if (ImagePickerUtils.checkFileIsDocument(
                      extension(file.path),
                    ) ||
                    ImagePickerUtils.checkFileIsImage(extension(file.path))) {
                  returnFileList.add(file);
                } else {
                  "File Type Not Supported".showAsToast(
                    context: context,
                    type: ToastType.TOAST_ERROR,
                  );
                  //return;
                }
              } else {
                isTwelveMB
                    ? "Please select file less than 12 MB".showAsToast(
                        context: context,
                        type: ToastType.TOAST_ERROR,
                      )
                    : "Please select file less than 5 MB".showAsToast(
                        context: context,
                        type: ToastType.TOAST_ERROR,
                      );
                //return;
              }
            }
          } else {
            AppStrings().max_five_attachment_allowed.showAsToast(
              context: context,
              type: ToastType.TOAST_ERROR,
            );
          }
          //file = File(result.files.single.path!);
          return returnFileList;
        }
      } on Exception catch (e) {
        debugPrint('Error when picking a file: $e');
        return null;
      }
    }
    return null;
  }

  static bool checkFileIsImage(String? extensions) {
    if (extensions?.toLowerCase() == '.jpg' ||
        extensions?.toLowerCase() == '.jpeg' ||
        extensions?.toLowerCase() == '.png') {
      return true;
    } else {
      return false;
    }
  }

  static bool checkFileIsDocument(String? extensions) {
    if (extensions?.toLowerCase() == '.pdf' ||
        extensions?.toLowerCase() == '.doc' ||
        extensions?.toLowerCase() == '.doc' ||
        extensions?.toLowerCase() == '.docx' ||
        extensions?.toLowerCase() == '.txt' ||
        extensions?.toLowerCase() == '.xls' ||
        extensions?.toLowerCase() == '.xlsx') {
      return true;
    } else {
      return false;
    }
  }

  static checkFileSizeInMb({
    required File? file,
    required int dynamicFileSizeInMB,
  }) {
    final sizeInBytes = file!.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb <= dynamicFileSizeInMB) {
      return true;
    } else {
      return false;
    }
  }
}
