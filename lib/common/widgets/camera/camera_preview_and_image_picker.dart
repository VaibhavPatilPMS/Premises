import 'dart:io';
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' hide context;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:premises/common/utils/utils.dart';
import 'package:video_compress/video_compress.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

class CameraPreviewAndImagePicker extends StatefulWidget {
  final CustomCameraAndImagePickerArgs? args;

  const CameraPreviewAndImagePicker({super.key, this.args});

  @override
  _CameraPreviewAndImagePickerState createState() =>
      _CameraPreviewAndImagePickerState();
}

class _CameraPreviewAndImagePickerState
    extends State<CameraPreviewAndImagePicker> {
  late CameraProvider _cameraStateManageProvider;

  CameraController? _cameraController;
  int _cameraIndex = 0;
  bool _cameraNotAvailable = false;

  //bool flashOn = false;
  final ImagePicker imagePicker = ImagePicker();
  FlashState _flashState = FlashState.auto;

  bool showFocusCircle = false;
  double x = 0;
  double y = 0;
  bool _isVideoRecorder = false;
  bool _isRecordingStarted = false;

  Timer? _timer;
  int _secondsElapsed = 0;

  @override
  void initState() {
    if (AppData().availableCameraList == null ||
        AppData().availableCameraList!.isEmpty) {
      _cameraNotAvailable = true;
    }
    _cameraStateManageProvider = Provider.of<CameraProvider>(
      context,
      listen: false,
    );
    _cameraStateManageProvider.files = widget.args?.files ?? [];

    super.initState();
    //_initializeCamera();
    _initCamera(_cameraIndex);
  }

  void _showToast(String message) {
    message.showAsToast(context: context, type: ToastType.TOAST_ERROR);
  }

  Future<void> _initCamera(int index) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
    final camera = AppData().availableCameraList![index];
    _cameraController = CameraController(
      AppData().availableCameraList![index],
      ResolutionPreset.medium,
    );

    //_cameraController?.unlockCaptureOrientation();

    _cameraController!.addListener(() {
      if (_cameraController!.value.hasError) {
        _showToast('Camera error ${_cameraController!.value.errorDescription}');
      }
    });

    try {
      await _cameraController!.initialize();
      await _cameraController!.lockCaptureOrientation(
        DeviceOrientation.portraitUp,
      );
      await _cameraController!.setFlashMode(FlashMode.auto);
      await _cameraController!.setFocusMode(FocusMode.auto);
      await _cameraController!.setExposureMode(ExposureMode.auto);
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {
        _cameraIndex = index;
      });
    }
  }

  bool isProgress = false;

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(isLoading: isProgress);
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
        if (_secondsElapsed >= 15) {
          _stopRecording(_cameraStateManageProvider.orientation!);
        }
      });
    });
  }

  _recordVideo() async {
    if (_isRecordingStarted) {
      _stopRecording(_cameraStateManageProvider.orientation!);
    } else {
      await _cameraController?.prepareForVideoRecording();
      await _cameraController?.startVideoRecording();
      setState(() {
        _isRecordingStarted = true;
        _startTimer(); // Start timer when recording starts
      });
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _onTakePictureButtonPress() {
    (_cameraStateManageProvider.files!.length < widget.args!.imageCount ||
            widget.args!.isProfilePhoto)
        ? FileUtils.checkFileListSize(
                fileList: _cameraStateManageProvider.files,
              )
              ? _processCameraCapturedFile(
                  _cameraStateManageProvider.orientation!,
                )
              : "Maximum ${FileSizeLimit.singleFileSize.toString()} MB size images are allowed"
                    .showAsToast(context: context, type: ToastType.TOAST_ERROR)
        : "Maximum ${widget.args!.imageCount} images are allowed".showAsToast(
            context: context,
            type: ToastType.TOAST_ERROR,
          );
  }

  Future _processCameraCapturedFile(NativeDeviceOrientation orientation) async {
    if (!_cameraController!.value.isInitialized ||
        _cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      FlashMode flashMode;
      switch (_flashState) {
        case FlashState.auto:
          flashMode = FlashMode.auto;
          break;
        case FlashState.on:
          flashMode = FlashMode.torch;
          break;
        case FlashState.off:
          flashMode = FlashMode.off;
          break;
      }
      await _cameraController!.setFlashMode(flashMode);
      XFile filePath = await _cameraController!.takePicture();
      if (widget.args!.isProfilePhoto) {
        _cameraStateManageProvider.files!.clear();
      }

      final fixedImageBytes = await FlutterImageCompress.compressWithFile(
        filePath.path,
        rotate: _getAngleForRotation(orientation),
        quality: 60,
        keepExif: true,
        autoCorrectionAngle: true,
        //format: CompressFormat.jpeg,
      );
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      String fileName = randomAlphaNumeric(10).toString();
      File? decodedimgfile = await File(
        "$path/image$fileName.png",
      ).writeAsBytes(Uint8List.fromList(fixedImageBytes!));
      _cameraStateManageProvider.files!.add(decodedimgfile);

      // File? rotationCorrectedFile= await _fixExifRotation(File(filePath.path).path);
      // _cameraStateManageProvider.files!.add(rotationCorrectedFile);
      setState(() {});
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future _stopRecording(NativeDeviceOrientation orientation) async {
    // if (!_cameraController!.value.isInitialized ||
    //     _cameraController!.value.isRecordingVideo) {
    //   return null;
    // }
    if (_cameraStateManageProvider.checkVideoFileExists()) {
      if (_isRecordingStarted) {
        try {
          final file = await _cameraController!.stopVideoRecording();
          //XFile newVideoFile = new XFile(file.path.replaceAll('.temp', '.mp4'));
          _timer?.cancel();
          setState(() {
            _isVideoRecorder = false;
            _isRecordingStarted = false;
            _secondsElapsed = 0; // Reset timer
            isProgress = true;
          });

          if (widget.args!.isProfilePhoto) {
            _cameraStateManageProvider.files!.clear();
          }

          final videoFile = File(file.path);

          if (await videoFile.length() < 5 * 1024 * 1024) {
            // < 5MB → skip compression
            _cameraStateManageProvider.files!.add(videoFile);
            return;
          }

          final MediaInfo? compressedVideoInfo =
              await VideoCompress.compressVideo(
                file.path,
                quality: VideoQuality.LowQuality,
                deleteOrigin:
                    false, // If true, the original file will be deleted
              );
          if (compressedVideoInfo == null || compressedVideoInfo.path == null) {
            isProgress = false;
            setState(() {});
            _showToast("Video compression failed");
            return;
          }

          XFile compressedVideoFile = XFile(compressedVideoInfo.path!);
          _cameraStateManageProvider.files!.add(
            FileUtils.convertXfileToFile(xfile: compressedVideoFile),
          );

          setState(() {
            isProgress = false;
          });
        } on CameraException catch (e) {
          _showCameraException(e);
          return null;
        }
      }
    } else {
      final file = await _cameraController!.stopVideoRecording();
      _timer?.cancel();
      "Only 1 Video Recording is allowed.".showAsToast(
        context: context,
        type: ToastType.TOAST_ERROR,
      );
      setState(() {
        _isRecordingStarted = false;
        _secondsElapsed = 0;
      });
    }
  }

  _getAngleForRotation(NativeDeviceOrientation orientation) {
    if (orientation.deviceOrientation == DeviceOrientation.portraitUp) {
      return 0;
    } else if (orientation.deviceOrientation ==
        DeviceOrientation.portraitDown) {
      return -180;
    } else if (orientation.deviceOrientation ==
        DeviceOrientation.landscapeLeft) {
      return 270;
    } else if (orientation.deviceOrientation ==
        DeviceOrientation.landscapeRight) {
      return -270;
    }
  }

  Future selectImagesFromGallery() async {
    if (_cameraStateManageProvider.files!.length < widget.args!.imageCount) {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage(
        imageQuality: 50,
      );

      if (widget.args!.imageCount - _cameraStateManageProvider.files!.length >=
          selectedImages.length) {
        if (selectedImages.isNotEmpty) {
          if (FileUtils.checkXFileListSize(fileList: selectedImages)) {
            for (XFile image in selectedImages) {
              // File? rotationCorrectedFile= await _fixExifRotation(image.path);
              // _cameraStateManageProvider.files!.add(File(rotationCorrectedFile.path));
              _cameraStateManageProvider.files?.add(File(image.path));
            }
            setState(() {});
          } else {
            "Maximum ${FileSizeLimit.singleFileSize.toString()} MB size images are allowed"
                .showAsToast(context: context, type: ToastType.TOAST_ERROR);
          }
        }
      } else {
        "Maximum ${widget.args!.imageCount} images are allowed".showAsToast(
          context: context,
          type: ToastType.TOAST_ERROR,
        );
      }
    } else {
      "Maximum ${widget.args!.imageCount} images are allowed".showAsToast(
        context: context,
        type: ToastType.TOAST_ERROR,
      );
    }
  }

  void _showCameraException(CameraException e) {
    CustomLogger.printKV(e.code, e.description!);
    _showToast('Error: ${e.code}\n${e.description}');
  }

  Widget _buildGalleryBar() {
    double barHeight = 95.0;
    double vertPadding = 10.0;
    return Consumer<CameraProvider>(
      builder: (context, cameraProvider, child) {
        return SizedBox(
          height: barHeight,
          //alignment: Alignment.centerLeft,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: vertPadding),
            scrollDirection: Axis.horizontal,
            itemCount: cameraProvider.files!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomizeImage(
                        file: cameraProvider.files![index],
                        isEdit: ImagePickerUtils.checkFileIsImage(
                          extension(cameraProvider.files![index].path),
                        ),
                        appBarTitle:
                            ImagePickerUtils.checkFileIsImage(
                              extension(cameraProvider.files![index].path),
                            )
                            ? null
                            : 'Preview',
                        isDoOperations: true,
                      ),
                    ),
                  );
                  if (result is File) {
                    cameraProvider.updateFile(index, result);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSizes().defaultCornerRadius,
                    ),
                    child: SizedBox(
                      width: 75.0,
                      height: barHeight - vertPadding * 2,
                      child:
                          ImagePickerUtils.checkFileIsImage(
                            extension(cameraProvider.files![index].path),
                          )
                          ? Image(
                              image: randomImageUrl(
                                cameraProvider.files![index],
                              ),
                              fit: BoxFit.cover,
                            )
                          : VideoThumbnails(
                              iconSize: 40,
                              videoFile: cameraProvider.files![index],
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildControlBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        widget.args!.isProfilePhoto || !widget.args!.isPickFromGallery
            ? Container(width: 30)
            : IconButton(
                color: Colors.white,
                icon: const Icon(Icons.photo, size: 30),
                onPressed: () {
                  selectImagesFromGallery();
                },
              ),
        InkWell(
          onTap: () {
            !_isVideoRecorder && !_isRecordingStarted
                ? _onTakePictureButtonPress()
                : !_isRecordingStarted
                ? _recordVideo()
                : _stopRecording(_cameraStateManageProvider.orientation!);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5.0),
            ),
            child: _isVideoRecorder
                ? Icon(
                    _isVideoRecorder
                        ? _isRecordingStarted
                              ? Icons.stop_circle_sharp
                              : Icons.fiber_manual_record_sharp
                        : Icons.circle,
                    color: _isVideoRecorder ? Colors.red : Colors.white,
                    size: 65,
                  )
                : Container(),
          ),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(_getFlashIcon()),
          onPressed: _cycleFlashMode,
        ),
      ],
    );
  }

  IconData _getFlashIcon() {
    switch (_flashState) {
      case FlashState.auto:
        return Icons.flash_auto;
      case FlashState.on:
        return Icons.flash_on;
      case FlashState.off:
        return Icons.flash_off;
    }
  }

  void _cycleFlashMode() {
    setState(() {
      switch (_flashState) {
        case FlashState.auto:
          _flashState = FlashState.on;
          _cameraController!.setFlashMode(FlashMode.torch);
          break;
        case FlashState.on:
          _flashState = FlashState.off;
          _cameraController!.setFlashMode(FlashMode.off);
          break;
        case FlashState.off:
          _flashState = FlashState.auto;
          _cameraController!.setFlashMode(FlashMode.auto);
          break;
      }
    });
  }

  Widget _buildBottomCameraAndVideoButtons() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: MediaQuery.of(context).padding.bottom + 18,
      right: _isVideoRecorder
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width * 0.3,
      child: Container(
        width: 170,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVideoRecorder = false;
                  _stopRecording(_cameraStateManageProvider.orientation!);
                });
              },
              child: Text(
                'Camera',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: !_isVideoRecorder ? Colors.white : Colors.grey,
                ),
              ),
            ),
            if (widget.args!.isVideoRecordingRequired) ...{
              GestureDetector(
                onTap: () {
                  if (_cameraStateManageProvider.checkVideoFileExists()) {
                    setState(() {
                      _isVideoRecorder = true;
                    });
                  } else {
                    "Only 1 Video Recording is allowed.".showAsToast(
                      context: context,
                      type: ToastType.TOAST_ERROR,
                    );
                    setState(() {
                      _isVideoRecorder = false;
                      _isRecordingStarted = false;
                      _secondsElapsed = 0;
                    });
                  }
                },
                child: Text(
                  'Video',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _isVideoRecorder ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }

  double? getScale() {
    double scale =
        1 /
        (_cameraController!.value.aspectRatio *
            MediaQuery.of(context).size.aspectRatio);
    return scale;
  }

  @override
  void dispose() {
    CustomLogger.logPrint('camera dispose base state');
    _cameraController!.setFlashMode(FlashMode.off);
    _flashState = FlashState.auto;

    try {
      if (_cameraController != null) {
        _cameraController!.dispose();
        CustomLogger.logPrint('camera dispose base under state');
      }
    } catch (exception, stackTrace) {
      CustomLogger.logPrint(exception.toString());
    } finally {
      super.dispose();
    }
    //super.dispose();
  }

  Widget? _buildAppBarActions() {
    return Container(
      margin: MarginPadding().xsmallAll,
      padding: MarginPadding().xsmallAll,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.color_primary,
        shape: BoxShape.circle,
      ),
      child: Badge(
        position: BadgePosition.topEnd(top: -8, end: 0),
        badgeAnimation: const BadgeAnimation.slide(
          animationDuration: Duration(milliseconds: 300),
        ),
        badgeStyle: const BadgeStyle(badgeColor: Colors.white, elevation: 3.0),
        badgeContent: Text(
          widget.args!.isProfilePhoto
              ? ''
              : context.watch<CameraProvider>().files!.length.toString(),
          style: TextStyle(color: Colors.black, fontSize: TextSize().xsmall),
        ),
        child: AppIcon(
          icon: AppIcons().ic_arrow,
          iconColor: Colors.white,
          iconHeight: 40.0,
          iconWidth: 40.0,
        ),
      ),
    );
  }

  Future<void> _onTap(TapUpDetails details) async {
    if (_cameraController!.value.isInitialized) {
      showFocusCircle = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * _cameraController!.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      // Ensure the values are between 0 and 1
      xp = xp.clamp(0.0, 1.0);
      yp = yp.clamp(0.0, 1.0);

      Offset point = Offset(xp, yp);

      // Manually focus
      try {
        await _cameraController!.setFocusPoint(point);
      } catch (e) {
        CustomLogger.logPrint('Error setting focus point: $e');
      }

      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          showFocusCircle = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraNotAvailable) {
      const center = Center(child: Text('Camera not available'));
      return Scaffold(appBar: AppBar(), body: center);
    }
    return GestureDetector(
      onTapUp: (details) {
        _onTap(details);
      },
      child: Scaffold(
        body: NativeDeviceOrientationReader(
          builder: (context) {
            return Stack(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  child: _cameraController!.value.isInitialized
                      ? NativeDeviceOrientationReader(
                          useSensor: true,
                          builder: (context) {
                            NativeDeviceOrientation orientation =
                                NativeDeviceOrientationReader.orientation(
                                  context,
                                );
                            _cameraStateManageProvider.updateDeviceOrientation(
                              orientation,
                            );
                            return Transform.scale(
                              scale: getScale(),
                              alignment: Alignment.topCenter,
                              child: AspectRatio(
                                aspectRatio:
                                    1 / _cameraController!.value.aspectRatio,
                                child: CameraPreview(_cameraController!),
                              ),
                            );
                          },
                          //child:
                        )
                      // child:
                      : const Text('Loading camera...'),
                ),
                if (widget.args?.isFaceFrameAvailable ?? false)
                  Positioned.fill(
                    child: IgnorePointer(
                      child:
                          (_cameraController != null &&
                              _cameraController!.value.isInitialized)
                          ? FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: SvgPicture.asset(AppIcons().ic_face_net),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                if (showFocusCircle)
                  CustomPaint(
                    size: Size.infinite,
                    painter: FocusCirclePainter(x, y),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _buildGalleryBar(),
                    _buildControlBar(),
                    Visibility(
                      visible: _isVideoRecorder,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          _formatDuration(_secondsElapsed),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 62,
                    ),
                  ],
                ),
                _progressBar(context),
                _buildBottomCameraAndVideoButtons(),
              ],
            );
          },
        ),
        floatingActionButton: Align(
          alignment: const Alignment(1.0, 0.5),
          child: _cameraStateManageProvider.files!.isEmpty
              ? const SizedBox()
              : FloatingActionButton(
                  backgroundColor: AppColors.color_primary,
                  onPressed: () {
                    Navigator.pop(context, _cameraStateManageProvider.files!);
                  },
                  child: _buildAppBarActions(),
                ),
        ),
      ),
    );
  }
}

class FocusCirclePainter extends CustomPainter {
  final double x;
  final double y;

  FocusCirclePainter(this.x, this.y);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(x, y), 50, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomCameraAndImagePickerArgs {
  final int imageCount;
  final List<File>? files;
  final bool isProfilePhoto;
  final bool isPickFromGallery;
  final bool isVideoRecordingRequired;
  final bool isFaceFrameAvailable;

  CustomCameraAndImagePickerArgs({
    this.imageCount = 5,
    this.files,
    this.isProfilePhoto = false,
    this.isPickFromGallery = true,
    this.isVideoRecordingRequired = false,
    this.isFaceFrameAvailable = false,
  });
}

enum FlashState { auto, on, off }
