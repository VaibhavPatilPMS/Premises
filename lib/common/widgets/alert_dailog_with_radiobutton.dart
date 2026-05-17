import 'widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/resources/app_colors.dart';
import 'package:premises/common/resources/app_dimens.dart';
import 'package:premises/common/resources/app_icons.dart';
import 'package:premises/common/utils/app_constants.dart';
import 'package:premises/common/resources/resources.dart';

class AlertDialogRadioButton extends StatelessWidget {
  final Function onPressed;
  final Function? onPressedClosedIcon;
  final String dialogTitle;
  final String dialogButtonName;
  final bool showSubmitButton;
  final bool showCloseButton;
  // final AttendanceProvider attendanceProvider;
  const AlertDialogRadioButton({
    super.key,
    // required this.attendanceProvider,
    required this.onPressed,
    required this.dialogTitle,
    required this.dialogButtonName,
    this.onPressedClosedIcon,
    this.showSubmitButton = true,
    this.showCloseButton = true,
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
            AppText.smallBrandSecondaryBold(AppStrings().selectAttendance),
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
      child: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            AppText.xsmallGreyG1Regular(
              AppStrings().selectAttendanceStatement,
            ),
            Spacing().xsmallVertical,
            // Consumer<AttendanceProvider>(
            //   builder: (context, provider, child) {
            //     return ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: provider.moduleStatusList.length,
            //       itemBuilder: (context, index) {
            //         return RadioButtonListTileWidget(
            //           contentPadding: MarginPadding().smallAll,
            //           isCheck: provider.moduleStatusList[index].isCheck,
            //           isBackgroundWhite: true,
            //           subtitle: AppText.xsmallGreyG1Regular(
            //               provider.moduleStatusList[index].subTitle),
            //           listTileControlAffinity: ListTileControlAffinity.leading,
            //           title: AppText.smallGreyMedium(
            //               provider.moduleStatusList[index].title),
            //           index: index,
                      
            //           selectedIndex: provider.selectedModuleIndex,
            //           onChanged: (val) {
            //             provider.setSelectedModule(
            //                 val: val as int, index: index);
            //           },
            //         );
            //       },
            //     );
            //   },
            // ),
            Spacing().smallVertical,
            // Visibility(
            //   visible: true,
            //   child: Consumer<AttendanceProvider>(
            //       builder: (context, provider, child) {
            //     return AppButton(
            //         buttonName: dialogButtonName,
            //         onPressed: provider.selectedModuleIndex == -1
            //             ? null
            //             : () async {
            //                await provider.setOnlineModuleSelected();
            //                 // attendanceProvider.setOnlineModuleSelected();
            //                 Navigator.of(context).pop();
            //               });
            //   }),
            // ),
            Spacing().smallVertical,
          ],
        ),
      ),
    );
  }
}
