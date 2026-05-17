import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/features/user_management/user_management.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';

class AlertDialogCheckbox extends StatelessWidget {
  final Function onPressed;
  final Function? onPressedClosedIcon;
  final String dialogTitle;
  final String dialogButtonName;
  final bool showSubmitButton;
  final bool showCloseButton;
  final MixpanelService? mixpanelService;
  final UserManagementProvider userManagementProvider;

  const AlertDialogCheckbox({
    super.key,
    required this.onPressed,
    required this.dialogTitle,
    required this.dialogButtonName,
    required this.userManagementProvider,
    this.onPressedClosedIcon,
    this.mixpanelService,
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
            AppText.smallBrandSecondaryBold(AppStrings().explore_app),
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
              AppStrings().highlight_feature1,
            ),
            Spacing().xsmallVertical,
            AppText.xsmallGreyG1Regular(
              AppStrings().highlight_feature2,
            ),
            Spacing().xsmallVertical,
            AppText.xsmallGreyG1Regular(
              AppStrings().highlight_feature3,
            ),
            Spacing().xsmallVertical,
            AppText.xsmallGreyG1Regular(
              AppStrings().highlight_feature4,
            ),
            Spacing().xsmallVertical,
            Consumer<UserManagementProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                            visualDensity: VisualDensity.compact,
                            side: WidgetStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: AppColors.color_primary),
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            activeColor: AppColors.white,
                            checkColor: AppColors.color_primary,
                            value: provider.isTermsAndCondtionsAgree,
                            onChanged: (value) {
                              provider.setTermsAndConditionAgree(value!);
                            }),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings().agree_with,
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      mixpanelService!
                                          .termsAndConditionViewedEvent();
                                      LaunchURL.launchBrowser(
                                          AppStrings().terms_condtion_url);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          visualDensity: VisualDensity.compact,
                          side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(
                                width: 1.0, color: AppColors.color_primary),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          activeColor: AppColors.white,
                          checkColor: AppColors.color_primary,
                          value: provider.isPrivacyAndPolicyAgree,
                          onChanged: (value) {
                            provider.setPrivacyAndPolicyAgree(value!);
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings().agree_with,
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppStrings().privacy_policy,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      mixpanelService!
                                          .privacyPolicyViewedEvent();
                                      LaunchURL.launchBrowser(
                                          AppStrings().privacy_policy_url);
                                      // provider.setPrivacyAndPolicyRead(true);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Spacing().smallVertical,
            Visibility(
              visible: true,
              child: AppButton(
                  buttonName: dialogButtonName,
                  onPressed: context
                                  .watch<UserManagementProvider>()
                                  .isTermsAndCondtionsAgree ==
                              true &&
                          context
                                  .watch<UserManagementProvider>()
                                  .isPrivacyAndPolicyAgree ==
                              true
                      ? onPressed as void Function()
                      : null),
            ),
            Spacing().smallVertical,
          ],
        ),
      ),
    );
  }
}
