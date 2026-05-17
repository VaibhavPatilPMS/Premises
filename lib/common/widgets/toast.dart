import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';
import 'widgets.dart';

extension Toast on String {
  static late FToast fToast;
  static late Widget? toast;
  static BuildContext? context;
  static const int TOAST_DURATION = 4;

  Future<void> showAsToast(
      {String? leftImageName,
      int? type,
      Color? textColor,
      ToastGravity? gravity,
      PositionedToastBuilder? positionedToastBuilder,
      int? toastDuration,
      required BuildContext context}) async {
    fToast = FToast();
    fToast.init(context);
    Widget toast = Card(
        elevation: 5,
        color: type == ToastType.TOAST_SUCCESS
            ? AppColors.app_color_green.withValues(alpha: 0.8)
            : type == ToastType.TOAST_ERROR
                ? AppColors.toast_color_error.withValues(alpha: 0.8)
                : type == ToastType.TOAST_WARNING
                    ? AppColors.color_secondary.withValues(alpha: 0.8)
                    : AppColors.color_secondary
          ..withValues(alpha: 0.8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: MarginPadding().toastDefaultPadding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: type == ToastType.TOAST_SUCCESS
                  ? AppColors.app_color_green.withValues(alpha: 0.8)
                  : type == ToastType.TOAST_ERROR
                      ? AppColors.toast_color_error.withValues(alpha: 0.8)
                      : type == ToastType.TOAST_WARNING
                          ? AppColors.color_secondary.withValues(alpha: 0.8)
                          : AppColors.color_secondary
                ..withValues(alpha: 0.8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppIcon(
                icon: type == ToastType.TOAST_SUCCESS
                    ? AppIcons().ic_success
                    : type == ToastType.TOAST_WARNING
                        ? AppIcons().ic_warning
                        : type == ToastType.TOAST_ERROR
                            ? AppIcons().ic_error
                            : AppIcons().ic_toast_general,
                iconColor: AppColors.white,
                iconHeight: IconSize().medium,
                iconWidth: IconSize().medium,
                type: IconAssetType.SVG_ICON,
              ),
              Container(
                padding: MarginPadding().xsmallLeft,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  this,
                  style: TextStyle(
                    fontFamily: FontFamily.fontFamily,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? Colors.white,
                    fontSize: TextSize().xsmall,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ));
    fToast.showToast(
      child: toast,
      gravity: gravity ?? ToastGravity.TOP,
      positionedToastBuilder: positionedToastBuilder,
      toastDuration: Duration(seconds: toastDuration ?? TOAST_DURATION),
    );
  }
}
