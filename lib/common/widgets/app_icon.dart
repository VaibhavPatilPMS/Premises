import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:premises/common/resources/app_colors.dart';
import 'package:premises/common/utils/utils.dart';

class AppIcon extends StatelessWidget {
  final icon;
  final Function? onClick;
  final Color iconColor;
  final num iconHeight;
  final num iconWidth;
  final int type;
  final EdgeInsets edgeInsets;

  const AppIcon(
      {super.key,
      this.icon,
      this.onClick,
      this.iconColor = AppColors.color_primary,
      iconHeight,
      iconWidth,
      padding,
      type})
      : iconHeight = iconHeight ?? 24.00,
        iconWidth = iconWidth ?? 24.00,
        edgeInsets = padding ?? const EdgeInsets.all(0),
        type = type ?? IconAssetType.SVG_ICON;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case IconAssetType.SVG_ICON:
        return InkWell(onTap: onClick as void Function()?, child: _svgIcon());

      case IconAssetType.ASSET_ICON:
        return InkWell(onTap: onClick as void Function()?, child: _assetIcon());
    }
    return Container();
  }

  Widget _svgIcon() {
    return Padding(
      padding: edgeInsets,
      child: iconColor == AppColors.color_primary
          ? SvgPicture.asset(
              icon,
              width: iconWidth.toDouble(),
              height: iconHeight.toDouble(),
            )
          : SvgPicture.asset(
              icon,
              color: iconColor,
              width: iconWidth.toDouble(),
              height: iconHeight.toDouble(),
            ),
    );
  }

  Widget _assetIcon() {
    return iconColor == AppColors.color_primary
        ? Image.asset(
            icon,
            width: iconWidth.toDouble(),
            height: iconHeight.toDouble(),
          )
        : Image.asset(
            icon,
            color: iconColor,
            width: iconWidth.toDouble(),
            height: iconHeight.toDouble(),
          );
  }
}
