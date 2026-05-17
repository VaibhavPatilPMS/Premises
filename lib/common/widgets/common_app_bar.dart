import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/common/utils/app_constants.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/widgets/widgets.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final Color? backgroundColor;
  final Function? onBackPressed;
  final bool? zeroElevation;
  final bool? showBackIcon;
  final List<Widget>? actions;

  const CommonAppBar(
      {super.key,
      required this.title,
      this.subTitle,
      this.onBackPressed,
      this.actions,
      this.backgroundColor = AppColors.white,
      this.showBackIcon = true,
      this.zeroElevation = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: backgroundColor == AppColors.color_secondary
                  ? AppColors.color_secondary
                  : AppColors.white,
              statusBarIconBrightness:
                  backgroundColor == AppColors.color_secondary
                      ? Brightness.light
                      : Brightness.dark),
          elevation: zeroElevation! ? 0 : AppSizes().toolBarElevation,
          toolbarHeight: AppSizes().toolBarHeight,
          shadowColor: AppColors.toolbarShadowColor,
          backgroundColor: backgroundColor ?? AppColors.white,
          actions: actions,
          titleSpacing: -20,
          title: Container(
            padding: MarginPadding().mediumLeftRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: MarginPadding().xsmallLeftRight,
                  child: showBackIcon!
                      ? AppIcon(
                          icon: AppIcons().ic_arrow_back,
                          iconColor:
                              backgroundColor == AppColors.color_secondary
                                  ? AppColors.white
                                  : AppColors.color_secondary,
                          type: IconAssetType.SVG_ICON,
                          iconHeight: IconSize().toolbrBackArrowIconHeight,
                          onClick: onBackPressed != null
                              ? onBackPressed as void Function()?
                              : () {
                                  Navigator.of(context).pop(true);
                                })
                      : const SizedBox(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    backgroundColor == AppColors.color_secondary
                        ? AppText.xxlargeWhiteBold(title)
                        : AppText.xxlargeBrandSecondaryBold(title),
                    Spacing().xxsmallVertical,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: AppText.xsmallGreyG1Medium(
                          subTitle ??
                              (AppData().userCurrentSelectedProject != null
                                  ? AppData()
                                      .userCurrentSelectedProject!
                                      .projectName
                                  : ''),
                          textOverflow: TextOverflow.clip),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes().toolBarHeight);
}
