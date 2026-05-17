import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:premises/common/utils/utils.dart';

class VideoThumbnails extends StatefulWidget {
  final double? iconSize;
  final File? videoFile;
  final String? videoUrl;

  const VideoThumbnails(
      {Key? key, this.iconSize, this.videoFile, this.videoUrl})
      : super(key: key);

  @override
  _VideoThumbnailsState createState() => _VideoThumbnailsState();
}

class _VideoThumbnailsState extends State<VideoThumbnails> {
  File? _downloadedVideoFile;
  String? _thumbnailPath;
  bool _isDownloading = false;
  bool _isGeneratingThumbnail = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (widget.videoFile == null && widget.videoUrl != null) {
      await _downloadVideo(widget.videoUrl!);
    } else if (widget.videoFile != null) {
      _downloadedVideoFile = widget.videoFile;
    }

    if (_downloadedVideoFile != null) {
      await _generateThumbnail(_downloadedVideoFile!.path);
    }
  }

  Future<void> _downloadVideo(String url) async {
    setState(() {
      _isDownloading = true;
    });
    try {
      final response = await http.get(Uri.parse(url));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = '${documentDirectory.path}/video.mp4';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        _downloadedVideoFile = file;
      });
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  Future<void> _generateThumbnail(String videoPath) async {
    setState(() {
      _isGeneratingThumbnail = true;
    });
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 64,
        quality: 75,
      );
      setState(() {
        _thumbnailPath =
            FileUtils.convertXfileToFile(xfile: thumbnailPath).path;
      });
    } finally {
      setState(() {
        _isGeneratingThumbnail = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDownloading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_isGeneratingThumbnail) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_thumbnailPath == null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.black,
          ),
          Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: widget.iconSize ?? 50.0,
          ),
        ],
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.file(File(_thumbnailPath!)),
        Icon(
          Icons.play_circle_fill,
          color: Colors.white,
          size: widget.iconSize ?? 50.0,
        ),
      ],
    );
  }
}
