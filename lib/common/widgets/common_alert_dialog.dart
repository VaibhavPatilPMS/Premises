import 'package:flutter/material.dart';
import 'package:premises/common/resources/app_colors.dart';
import 'package:premises/common/resources/app_dimens.dart';
import 'package:premises/common/resources/app_icons.dart';
import 'package:premises/common/utils/app_constants.dart';
import 'package:premises/common/resources/app_strings.dart';
import 'package:premises/common/widgets/widgets.dart';

class CommonAlertDialog extends StatelessWidget {
  final Function? onPressed;
  final Function? onPressedClosedIcon;
  final String dialogTitle;
  final String dialogMessage;
  final String dialogButtonName;
  final bool showSubmitButton;
  final bool showCloseButton;
  final bool? showCheckBox;
  final bool? showTwoButtons;
  final ValueChanged<bool?>? onChanged;
  final bool? isCheck;
  final String? textSpanText;
  final String? textSpanHeading;
  final Widget? labourActivationDetails;
  final Widget? dialogBody;

  const CommonAlertDialog(
      {super.key,
      required this.onPressed,
      required this.dialogTitle,
      required this.dialogMessage,
      required this.dialogButtonName,
      this.onPressedClosedIcon,
      this.showTwoButtons,
      this.onChanged,
      this.showCheckBox = false,
      this.isCheck,
      this.textSpanText,
      this.textSpanHeading,
      this.showSubmitButton = true,
      this.showCloseButton = true,
      this.labourActivationDetails,
      this.dialogBody});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes().dialogRoundCorners),
          ),
          elevation: AppSizes().dialogElevations,
          backgroundColor: Colors.transparent,
          child: Wrap(children: [
            _dialogBuilder(context),
          ]),
        ),
      ],
    );
  }

  Widget _dialogBuilder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes().dialogRoundCorners),
          boxShadow: const [
            BoxShadow(
                color: AppColors.color_secondary,
                offset: Offset(0, 10),
                blurRadius: 30),
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacing().smallVertical,
            _dialogTitle(context),
            const HorizontalDivider(dividerMargin: EdgeInsets.zero),
            _dialogContent(context),
          ]),
    );
  }

  Widget _dialogTitle(BuildContext context) {
    return Container(
      padding: MarginPadding().smallAll,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.smallBrandSecondaryBold(dialogTitle),
            Visibility(
              visible: showCloseButton,
              child: AppIcon(
                icon: AppIcons().ic_close_icon,
                type: IconAssetType.SVG_ICON,
                onClick: () {
                  if (onPressedClosedIcon != null) {
                    onPressedClosedIcon!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ]),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      padding: MarginPadding().smallAll,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppText.smallGreyG1Regular(dialogMessage, isCenter: true),
        if (showCheckBox!)
          Column(
            children: [
              Spacing().xsmallVertical,
              _checkBox(),
            ],
          ),
        Spacing().mediumVertical,
        if (labourActivationDetails != null)
          labourActivationDetails!
        else
          SizedBox.shrink(),
        if (dialogBody != null) ...{dialogBody!},
        Visibility(
          visible: showSubmitButton,
          child: _dialogButton(context, showTwoButtons ?? false),
        ),
        Spacing().smallVertical,
      ]),
    );
  }

  Widget _dialogButton(BuildContext context, bool showTwoButtons) {
    if (showTwoButtons == true) {
      return Container(
        color: AppColors.white,
        padding: MarginPadding().xxsmallAll,
        child: AppCombinedActionButtons(
          leftButtonName: AppStrings().cancel.toUpperCase(),
          leftButtonBackgroundColor: AppColors.white,
          rightButtonOnPressed: () {
            // _goToNextScreen();
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.of(context).pop();
            }
          },
          leftButtonOnPressed: () {
            Navigator.of(context).pop();
          },
          rightButtonName: AppStrings().proceed.toUpperCase(),
        ),
      );
    } else {
      return AppButton(
          buttonName: dialogButtonName,
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.of(context).pop();
            }
          });
    }
  }

  Widget _checkBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
            visualDensity: VisualDensity.compact,
            side: WidgetStateBorderSide.resolveWith(
              (states) =>
                  const BorderSide(width: 1.0, color: AppColors.color_primary),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            activeColor: AppColors.white,
            checkColor: AppColors.color_primary,
            value: isCheck ?? false,
            onChanged: onChanged ?? (value) {}),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: textSpanHeading,
              style: TextStyle(
                  color: AppColors.text_grey,
                  fontSize: TextSize().small,
                  fontFamily: FontFamily.fontFamily),
              children: <TextSpan>[
                TextSpan(
                  text: textSpanText,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontFamily.fontFamily,
                      fontSize: TextSize().small,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
