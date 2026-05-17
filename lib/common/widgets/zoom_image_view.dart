import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' hide context;
import 'package:photo_view/photo_view.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class ZoomImagePage extends StatefulWidget {
  final String title;
  final String fileUrl;
  final bool? isOffline;

  // receive data from the FirstScreen as a parameter
  const ZoomImagePage(
      {super.key,
      required this.title,
      required this.fileUrl,
      this.isOffline = false});

  @override
  State<ZoomImagePage> createState() => _ZoomImagePageState();
}

class _ZoomImagePageState extends State<ZoomImagePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();
    if (!ImagePickerUtils.checkFileIsImage(extension(widget.fileUrl))) {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.fileUrl),
      ));
    }
  }

  Widget _buildScreenWidget(BuildContext context) {
    return !ImagePickerUtils.checkFileIsImage(extension(widget.fileUrl)) &&
            !widget.isOffline!
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: FlickVideoPlayer(
                  flickManager: flickManager!,
                ),
              ),
            ],
          )
        : Container(
            padding: MarginPadding().largeBottom,
            child: widget.isOffline!
                ? PhotoView(
                    imageProvider: MemoryImage(
                        FileConversionUtility.dataFromBase64String(
                            widget.fileUrl)),
                    filterQuality: FilterQuality.high,
                    //customSize: Size(512, 512),
                  )
                : PhotoView(
                    imageProvider: CachedNetworkImageProvider(
                      widget.fileUrl,
                      headers: CachedNetworkImageHeader.headers,
                    ),
                    filterQuality: FilterQuality.high,
                    //customSize: Size(512, 512),
                  ));
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithAppbar(
        context: context,
        scaffoldKey: _scaffoldKey,
        appbarWidget: CommonAppBar(
            title: widget.title,
            subTitle: AppData().userCurrentSelectedProject!.projectName),
        buildScreenColor:
            !ImagePickerUtils.checkFileIsImage(extension(widget.fileUrl))
                ? Colors.black
                : AppColors.text_grey_g3,
        screenWidget: _buildScreenWidget(context));
  }

  @override
  void dispose() {
    super.dispose();
    if (flickManager != null &&
        !ImagePickerUtils.checkFileIsImage(extension(widget.fileUrl)) &&
        !widget.isOffline!) {
      flickManager?.dispose();
    }
  }
}
