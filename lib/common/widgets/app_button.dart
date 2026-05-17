import 'package:flutter/material.dart';

import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class AppButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonName;
  final Color? backgroundColor;
  final Color? buttonTextColor;
  final double? width;
  final double? height;

  AppButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      this.backgroundColor,
      this.buttonTextColor,
      this.height,
      this.width});

  final TextStyle _buttonTextStyle = TextStyle(
      fontSize: TextSize().small,
      fontWeight: FontWeight.w700,
      //letterSpacing: AppSizes().letterSpacingButton,
      height: AppSizes().letterHeight,
      fontFamily: FontFamily.fontFamily);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppSizes().defaultButtonHeight,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
            foregroundColor: buttonTextColor ?? Colors.white,
            backgroundColor: backgroundColor ?? AppColors.color_primary,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppSizes().butttonRoundedCorners),
            ),
            textStyle: _buttonTextStyle),
        child: Text(buttonName),
      ),
    );
  }
}

class AppBorderedButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonName;
  final Color? backgroundColor;
  final Color? buttonTextColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final bool? isAutoWrap;

  //passing props in react style
  AppBorderedButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      this.backgroundColor,
      this.buttonTextColor,
      this.borderColor,
      this.height,
      this.isAutoWrap = false,
      this.width});

  final TextStyle _buttonTextStyle = TextStyle(
      fontSize: TextSize().small,
      fontWeight: FontWeight.w500,
      //letterSpacing: AppSizes().letterSpacingButton,
      height: AppSizes().letterHeight,
      fontFamily: FontFamily.fontFamily);

  @override
  Widget build(BuildContext context) {
    return isAutoWrap!
        ? Wrap(
            children: [
              TextButton(
                onPressed: onPressed as void Function()?,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    foregroundColor: buttonTextColor ?? AppColors.color_primary,
                    backgroundColor:
                        backgroundColor ?? AppColors.derived_color_one,
                    minimumSize: const Size(22, 22),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppSizes().butttonRoundedCorners),
                        side: BorderSide(
                            color: borderColor ?? AppColors.color_primary,
                            width: AppSizes().buttonBorderWidth)),
                    textStyle: _buttonTextStyle),
                child: Text(buttonName),
              )
            ],
          )
        : SizedBox(
            height: height ?? AppSizes().defaultButtonHeight,
            width: width ?? MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: onPressed as void Function()?,
              style: ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor ?? AppColors.color_primary,
                  backgroundColor:
                      backgroundColor ?? AppColors.derived_color_one,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppSizes().butttonRoundedCorners),
                      side: BorderSide(
                          color: borderColor ?? AppColors.color_primary,
                          width: AppSizes().buttonBorderWidth)),
                  textStyle: _buttonTextStyle),
              child: Text(buttonName),
            ),
          );
  }
}

class AppCombinedActionButtons extends StatelessWidget {
  final Function? rightButtonOnPressed;
  final Function? leftButtonOnPressed;
  final String? rightButtonName;
  final String? leftButtonName;
  final Color? rightButtonBackgroundColor;
  final Color? leftButtonBackgroundColor;
  final Color? rightButtonTextColor;
  final Color? leftButtonTextColor;
  final Color? leftButtonBorderColor;
  final Color? rightButtonBorderColor;

  //passing props in react style
  AppCombinedActionButtons(
      {super.key,
      required this.rightButtonOnPressed,
      required this.leftButtonOnPressed,
      required this.rightButtonName,
      required this.leftButtonName,
      this.rightButtonBackgroundColor,
      this.leftButtonBackgroundColor,
      this.rightButtonTextColor,
      this.leftButtonTextColor,
      this.leftButtonBorderColor,
      this.rightButtonBorderColor});

  final TextStyle _leftButtonTextStyle = TextStyle(
      fontSize: TextSize().small,
      fontWeight: FontWeight.w500,
      //letterSpacing: AppSizes().letterSpacingButton,
      height: AppSizes().letterHeight,
      fontFamily: FontFamily.fontFamily);

  final TextStyle _rightButtonTextStyle = TextStyle(
      fontSize: TextSize().small,
      fontWeight: FontWeight.w500,
      //letterSpacing: AppSizes().letterSpacingButton,
      height: AppSizes().letterHeight,
      fontFamily: FontFamily.fontFamily);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: SizedBox(
              height: AppSizes().defaultButtonHeight,
              child: TextButton(
                onPressed: leftButtonOnPressed as void Function()?,
                style: ElevatedButton.styleFrom(
                    foregroundColor:
                        leftButtonTextColor ?? AppColors.color_primary,
                    backgroundColor: leftButtonBackgroundColor ??
                        AppColors.derived_color_one,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppSizes().butttonRoundedCorners),
                        side: BorderSide(
                            color: leftButtonBorderColor ??
                                AppColors.color_primary,
                            width: AppSizes().buttonBorderWidth)),
                    textStyle: _leftButtonTextStyle),
                child: Text(leftButtonName!),
              ),
            )),
        Spacing().smallHorizontal,
        Expanded(
          flex: 1,
          child: SizedBox(
            height: AppSizes().defaultButtonHeight,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: rightButtonOnPressed as void Function()?,
              style: ElevatedButton.styleFrom(
                  foregroundColor: rightButtonTextColor ?? Colors.white,
                  backgroundColor:
                      rightButtonBackgroundColor ?? AppColors.color_primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppSizes().butttonRoundedCorners),
                      side: rightButtonBorderColor != null
                          ? BorderSide(
                              color: rightButtonBorderColor!,
                              width: AppSizes().buttonBorderWidth)
                          : BorderSide.none),
                  textStyle: _rightButtonTextStyle),
              child: Text(rightButtonName!),
            ),
          ),
        )
      ],
    );
  }
}

class AppTextButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonName;
  final Color? buttonTextColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  //passing props in react style
  AppTextButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      this.buttonTextColor,
      this.backgroundColor,
      this.height,
      this.textStyle,
      this.padding,
      this.width});

  final TextStyle _buttonTextStyle = TextStyle(
      fontSize: TextSize().small,
      fontWeight: FontWeight.w500,
      //letterSpacing: AppSizes().letterSpacingButton,
      height: AppSizes().letterHeight,
      fontFamily: FontFamily.fontFamily);

  @override
  Widget build(BuildContext context) {
    return width == null
        ? SizedBox(
            height: height ?? AppSizes().defaultButtonHeight,
            width: width ?? MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: onPressed as void Function()?,
              style: ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor ?? AppColors.color_primary,
                  backgroundColor: backgroundColor ?? AppColors.white,
                  padding: padding ?? EdgeInsets.zero,
                  textStyle: _buttonTextStyle),
              child: Text(
                buttonName,
                style: textStyle,
              ),
            ),
          )
        : Wrap(
            children: [
              TextButton(
                onPressed: onPressed as void Function()?,
                style: ElevatedButton.styleFrom(
                    foregroundColor: buttonTextColor ?? AppColors.color_primary,
                    padding: padding ?? EdgeInsets.zero,
                    backgroundColor:
                        backgroundColor ?? AppColors.derived_color_one,
                    textStyle: _buttonTextStyle),
                child: Text(
                  buttonName,
                  style: textStyle,
                ),
              ),
            ],
          );
  }
}
