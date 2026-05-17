import 'package:flutter/material.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class ContactSupportWidget extends StatelessWidget {
  const ContactSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MarginPadding().smallAll,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const ContactSupportWidgetContent(),
    );
  }
}

class ContactSupportWidgetContent extends StatelessWidget {
  const ContactSupportWidgetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  LaunchURL.launchEmail(AppStrings().support_email);
                },
                child: AppIcon(icon: AppIcons().ic_support_email)),
            Spacing().xsmallHorizontal,
            InkWell(
              onTap: () {
                LaunchURL.launchEmail(AppStrings().support_email);
              },
              child: AppText.xsmallCustomRegular(
                isCenter: true,
                color: AppColors.supportCardTextColor,
                textDecoration: TextDecoration.underline,
                AppStrings().support_email,
              ),
            ),
          ],
        ),
        Spacing().smallVertical,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  LaunchURL.launchPhone(AppStrings().support_phone);
                },
                child: AppIcon(
                  icon: AppIcons().ic_call_support,
                )),
            CustomVerticalDivider(
              height: AppSizes().small,
            ),
            InkWell(
              onTap: () {
                LaunchURL.launchwhatsapp(AppStrings().support_phone);
              },
              child: AppIcon(
                icon: AppIcons().ic_whats_app,
                type: IconAssetType.ASSET_ICON,
              ),
            ),
            Spacing().xsmallHorizontal,
            InkWell(
              onTap: () {
                LaunchURL.launchPhone(AppStrings().support_phone);
              },
              child: AppText.xsmallCustomRegular(
                isCenter: true,
                color: AppColors.supportCardTextColor,
                AppStrings().support_phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
