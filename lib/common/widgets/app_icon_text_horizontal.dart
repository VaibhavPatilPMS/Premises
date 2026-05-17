import 'widgets.dart';
import 'package:flutter/material.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/resources/resources.dart';

class AppIconWithTextHorizontal extends StatelessWidget {
  final String? icon;
  final Function? onClick;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final String? iconText;
  final double? iconTextSize;
  final SizedBox? iconTextSpacing;
  final EdgeInsetsGeometry? iconTextPadding;
  final bool? isBackgroundColorAvailable;
  final double? iconHeight;
  final double? iconWidth;

  const AppIconWithTextHorizontal(
      {super.key,
      this.icon,
      this.iconColor,
      this.iconBackgroundColor,
      this.iconText,
      this.iconTextSize,
      this.iconTextSpacing,
      this.iconTextPadding,
      this.iconHeight,
      this.iconWidth,
      this.onClick,
      this.isBackgroundColorAvailable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick as void Function()?,
      child: Container(
          alignment: Alignment.center,
          margin: MarginPadding().smallAll,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !isBackgroundColorAvailable!
                  ? Container(
                      height: AppSizes().large,
                      width: AppSizes().large,
                      alignment: Alignment.center,
                      padding: iconTextPadding ?? MarginPadding().xxxsmallAll,
                      decoration: BoxDecoration(
                        color:
                            iconBackgroundColor ?? AppColors.derived_color_one,
                        shape: BoxShape.circle,
                      ),
                      child: AppIcon(
                        type: IconAssetType.SVG_ICON,
                        icon: icon,
                        iconWidth: iconHeight ?? IconSize().xxxlarge,
                        iconHeight: iconWidth ?? IconSize().xxxlarge,
                        iconColor: iconColor ?? AppColors.color_primary,
                      ))
                  : AppIcon(
                      type: IconAssetType.SVG_ICON,
                      icon: icon,
                      iconHeight: iconHeight ?? IconSize().xxxlarge,
                      iconWidth: iconWidth ?? IconSize().xxxlarge,
                      iconColor: iconColor ?? AppColors.color_primary,
                    ),
              iconTextSpacing ?? Spacing().xsmallHorizontal,
              AppText.smallBrandSecondarySemiBold(
                iconText,
              ),
            ],
          )),
    );
  }
}
