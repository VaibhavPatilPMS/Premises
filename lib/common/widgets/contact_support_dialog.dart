import 'package:flutter/material.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/app_colors.dart';
import 'package:premises/common/resources/app_dimens.dart';
import 'package:premises/common/resources/app_icons.dart';
import 'package:premises/common/utils/app_constants.dart';

class FreemiumAlertDialog extends StatelessWidget {
  final Function onPressed;
  final Function? onPressedClosedIcon;
  final String dialogTitle;
  final String dialogMessage;
  final String dialogButtonName;
  final bool showSubmitButton;
  final bool showCloseButton;
  final bool showSupportContent;

  const FreemiumAlertDialog({
    super.key,
    required this.onPressed,
    required this.dialogTitle,
    required this.dialogMessage,
    required this.dialogButtonName,
    this.onPressedClosedIcon,
    this.showSubmitButton = true,
    this.showCloseButton = true,
    this.showSupportContent = false,
  });

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
                blurRadius: 10),
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacing().smallVertical,
            _dialogTitle(context),
            const HorizontalDivider(dividerMargin: EdgeInsets.zero),
            _dialogContent(context),
            if (showSupportContent) const ContactSupportWidget(),
            Padding(
              padding: MarginPadding().smallAll,
              child: Visibility(
                visible: showSubmitButton,
                child: AppButton(
                    buttonName: dialogButtonName,
                    onPressed: onPressed as void Function()),
              ),
            ),
            Spacing().smallVertical,
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
      ]),
    );
  }
}
