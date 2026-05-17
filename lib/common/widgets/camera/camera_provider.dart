import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' hide context;
import 'package:path_provider/path_provider.dart';
import 'package:premises/common/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:premises/common/utils/image_picker_utils.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

class CameraProvider with ChangeNotifier {
  List<File>? files = [];
  List<Path> paths = [];
  Random random = Random();
  File? decodedimgfile;
  bool isEditEnabled = false;

  NativeDeviceOrientation? orientation = NativeDeviceOrientation.values.first;

  updateIsEditEnabled() {
    isEditEnabled = !isEditEnabled;
    notifyListeners();
  }

  removeFile({required File file}) {
    files!.remove(file);
    notifyListeners();
  }

  undoChanges() {
    paths.removeLast();
    notifyListeners();
  }

  updateFile(int index, File file) {
    var isIndexValid = files!.asMap().containsKey(index);
    if (isIndexValid) {
      files![index] = file;
    }
    notifyListeners();
  }

  // insertUpdatedFile({required int index, required File file}) {
  //   file = file;
  //   notifyListeners();
  // }

  onPanUpdate({
    required BuildContext context,
    required DragUpdateDetails details,
  }) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.globalToLocal(details.globalPosition);
    localPosition = localPosition.translate(
      0.0,
      -(AppBar().preferredSize.height + 20),
    );

    Path path = paths.last;
    path.lineTo(localPosition.dx, localPosition.dy);
    notifyListeners();
  }

  onPanStart({
    required BuildContext context,
    required DragStartDetails details,
  }) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.globalToLocal(details.globalPosition);
    localPosition = localPosition.translate(
      0.0,
      -(AppBar().preferredSize.height + 20),
    );
    Path path = Path();
    path.moveTo(localPosition.dx, localPosition.dy);
    paths = List.from(paths)..add(Path.from(path));
    notifyListeners();
  }

  Future<void> saveImageToGallery({
    required GlobalKey globalKey,
    required File file,
    required BuildContext context,
  }) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    int randomNumber = random.nextInt(100);
    ui.Image image = await boundary.toImage();

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    if (!(await Permission.storage.status.isGranted)) {
      await Permission.storage.request();
    }
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    decodedimgfile = await File(
      "$path/image$randomNumber.png",
    ).writeAsBytes(Uint8List.fromList(pngBytes));

    if (decodedimgfile != null) {
      file = decodedimgfile!;
      // removeFiles(index: index, isOtherPhotos: isOtherPhotos);
      // insertUpdatedFile(
      //     index: index, file: decodedimgfile!, isOtherPhotos: isOtherPhotos);
    }
    Navigator.pop(context, file);
  }

  void updateDeviceOrientation(NativeDeviceOrientation? deviceOrientation) {
    orientation = deviceOrientation;
    CustomLogger.logPrint('orientation ${orientation?.name}');
    //notifyListeners();
  }

  checkVideoFileExists() {
    return files != null &&
        files!
            .where(
              (element) =>
                  !ImagePickerUtils.checkFileIsImage(extension(element.path)),
            )
            .toList()
            .isEmpty;
  }
}
