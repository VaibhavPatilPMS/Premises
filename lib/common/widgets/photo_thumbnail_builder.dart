import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path/path.dart' hide context;
import 'package:premises/application/app_router.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/resources/resources.dart';

class PhotoThumbnailBuilder extends StatelessWidget {
  final List<String> imageUrls;
  final String? imageBase64String;
  final bool? isOffline;
  final String? detailedPhotoPageTitle;

  const PhotoThumbnailBuilder(
      {super.key,
      required this.imageUrls,
      this.detailedPhotoPageTitle,
      this.imageBase64String,
      required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return imageUrls.isNotEmpty
        ? AlignedGridView.count(
            crossAxisCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  _navigateToZoomImageView(context, imageUrls[index]);
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppSizes().defaultCornerRadius),
                  child: isOffline!
                      ? Image.memory(
                          base64Decode(imageUrls[index]),
                          height: 65,
                          width: 50,
                          fit: BoxFit.fill,
                        )
                      : ImagePickerUtils.checkFileIsImage(
                              extension(imageUrls[index]))
                          ? CachedNetworkImage(
                              imageUrl: imageUrls[index],
                              httpHeaders: CachedNetworkImageHeader.headers,
                              height: 65,
                              width: 50,
                              fit: BoxFit.fill,
                            )
                          : VideoThumbnails(
                              iconSize: 35,
                              videoUrl: imageUrls[index],
                            ),
                ),
              );
            },
            //staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 1.2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )
        : InkWell(
            onTap: () {
              _navigateToZoomImageView(context, imageBase64String!);
            },
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppSizes().defaultCornerRadius),
              child: isOffline!
                  ? Image.memory(
                      base64Decode(imageBase64String!),
                      height: 65,
                      width: 50,
                      fit: BoxFit.fill,
                    )
                  : ImagePickerUtils.checkFileIsImage(
                          extension(imageBase64String!))
                      ? CachedNetworkImage(
                          imageUrl: imageBase64String!,
                          httpHeaders: CachedNetworkImageHeader.headers,
                          height: 65,
                          width: 50,
                          fit: BoxFit.fill,
                        )
                      : VideoThumbnails(
                          iconSize: 35,
                          videoUrl: imageBase64String!,
                        ),
            ),
          );
  }

  _navigateToZoomImageView(BuildContext context, String imageUrl) {
    Navigator.pushNamed(context, RouteName.zoomImageView,
        arguments: ZoomImageScreenArguments(
            title: detailedPhotoPageTitle,
            imageUrl: imageUrl,
            isOffline: isOffline));
  }
}

class ZoomImageScreenArguments {
  String? title;
  String? imageUrl;
  bool? isOffline;

  ZoomImageScreenArguments(
      {this.title, this.imageUrl, required this.isOffline});
}
