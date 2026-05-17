import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' hide context;
import 'package:provider/provider.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/widgets/widgets.dart';

class CustomizeImage extends StatefulWidget {
  final File file;
  final bool isProfilePic;
  final bool isEdit;
  final bool isDoOperations;
  final bool hideDeleteOperation;
  final String? appBarTitle;

  const CustomizeImage({
    super.key,
    required this.file,
    this.isProfilePic = false,
    this.isEdit = false,
    this.hideDeleteOperation = false,
    this.isDoOperations = false,
    this.appBarTitle,
  });

  @override
  State<CustomizeImage> createState() => _CustomizeImageState();
}

class _CustomizeImageState extends State<CustomizeImage> {
  GlobalKey globalKey = GlobalKey();
  late CameraProvider _cameraStateManageProvider;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _cameraStateManageProvider = Provider.of<CameraProvider>(
      context,
      listen: false,
    );
    _cameraStateManageProvider.isEditEnabled = widget.isEdit;
    _cameraStateManageProvider.paths.clear();
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.file.path));
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.setLooping(true);
    await _videoPlayerController!.play();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (context, cameraProvider, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            cameraProvider.paths.clear();
            Navigator.of(context).pop();
          },
          child: Scaffold(
            appBar: CommonAppBar(
              title:
                  !ImagePickerUtils.checkFileIsImage(
                    extension(widget.file.path),
                  )
                  ? 'Preview'
                  : widget.appBarTitle ?? AppStrings().edit_image,
              actions: widget.isDoOperations
                  ? [
                      cameraProvider.isEditEnabled == false
                          ? IconButton(
                              icon: const Icon(
                                Icons.save_alt_outlined,
                                color: AppColors.color_secondary,
                              ),
                              onPressed: () {
                                context
                                    .read<CameraProvider>()
                                    .saveImageToGallery(
                                      context: context,
                                      globalKey: globalKey,
                                      file: widget.file,
                                    );
                              },
                            )
                          : const SizedBox(),
                      cameraProvider.isEditEnabled == false
                          ? IconButton(
                              icon: const Icon(
                                Icons.undo_outlined,
                                color: AppColors.color_secondary,
                              ),
                              onPressed: () {
                                context.read<CameraProvider>().undoChanges();
                              },
                            )
                          : widget.hideDeleteOperation == true
                          ? Container()
                          : IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.color_secondary,
                              ),
                              onPressed: () {
                                _cameraStateManageProvider.removeFile(
                                  file: widget.file,
                                );
                                Navigator.pop(context, true);
                              },
                            ),
                      if (ImagePickerUtils.checkFileIsImage(
                        extension(widget.file.path),
                      )) ...{
                        IconButton(
                          icon: cameraProvider.isEditEnabled == false
                              ? const Icon(
                                  Icons.edit_off_sharp,
                                  color: AppColors.color_secondary,
                                )
                              : const Icon(
                                  Icons.edit,
                                  color: AppColors.color_secondary,
                                ),
                          onPressed: () {
                            cameraProvider.updateIsEditEnabled();
                          },
                        ),
                      },
                    ]
                  : null,
              subTitle: AppData().userCurrentSelectedProject != null
                  ? AppData().userCurrentSelectedProject!.projectName
                  : '',
            ),
            body: ImagePickerUtils.checkFileIsImage(extension(widget.file.path))
                ? GestureDetector(
                    onPanUpdate: cameraProvider.isEditEnabled == false
                        ? (details) {
                            context.read<CameraProvider>().onPanUpdate(
                              context: context,
                              details: details,
                            );
                          }
                        : (details) => {},
                    onPanStart: cameraProvider.isEditEnabled == false
                        ? (details) {
                            context.read<CameraProvider>().onPanStart(
                              context: context,
                              details: details,
                            );
                          }
                        : (details) => {},
                    onPanEnd: (details) {},
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black,
                            child: Center(child: Image.file(widget.file)),
                          ),
                          CustomPaint(
                            size: Size.infinite,
                            painter: MyPainter(
                              paths: context.watch<CameraProvider>().paths,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: _initVideoPlayer(),
                    builder: (context, state) {
                      if (state.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1,
                            child: AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!),
                            ),
                          ),
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }
}
