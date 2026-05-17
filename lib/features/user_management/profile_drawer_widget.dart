import 'dart:io' show Platform;
import 'user_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/features/dashboard/dashboard.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileDrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ShowSubscriptionEndBanner? showSubscriptionEndBanner;
  const ProfileDrawerWidget(
      {super.key, this.showSubscriptionEndBanner, required this.scaffoldKey});

  @override
  State<ProfileDrawerWidget> createState() => _ProfileDrawerWidgetState();
}

class _ProfileDrawerWidgetState extends State<ProfileDrawerWidget> {
  late UserManagementProvider _userManagementProvider;

  @override
  void initState() {
    super.initState();
    _userManagementProvider =
        Provider.of<UserManagementProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                _buildDrawerProfile(context),
                Spacing().xxxsmallVertical,
                IgnorePointer(
                    ignoring:
                        !context.watch<DashboardProvider>().isNetworkConnected,
                    child: _buildDrawerItems(context)),
                const HorizontalDivider(
                  dividerColor: AppColors.text_grey_g2,
                ),
                AppIconWithTextHorizontal(
                  icon: AppIcons().ic_sync_project_data,
                  iconHeight: TextSize().xxlarge,
                  onClick: () {
                    Navigator.of(context).pop();

                    Navigator.pushNamed(context, RouteName.dashboardScreen);
                  },
                  iconText: AppStrings().syncProjectData,
                  isBackgroundColorAvailable: true,
                ),
              ]),
            )),
            IgnorePointer(
                ignoring:
                    !context.watch<DashboardProvider>().isNetworkConnected,
                child: _buildDrawerBtn(context)),
            Spacing().xxsmallVertical,
          ],
        ),
        _progressBar(context),
      ],
    ));
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.watch<UserManagementProvider>().isLoadingLogout,
    );
  }

  Widget _buildDrawerProfile(context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: AppColors.color_secondary,
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(AppSizes().drawerProfileCardRoundCorners),
        //   bottomRight: Radius.circular(AppSizes().drawerProfileCardRoundCorners),
        // ),
      ),
      child: Row(
        children: [
          _buildBackBtn(),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, RouteName.userProfileScreen);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacing().smallVertical,
                  SizedBox(
                      height: ProfileSize().height,
                      width: ProfileSize().width,
                      child: ClipOval(
                        child: AppData().userDetailsUiModel!.profilePic != null
                            ? CachedNetworkImage(
                                imageUrl: AppData()
                                    .userDetailsUiModel!
                                    .profilePic
                                    .toString(),
                                httpHeaders: CachedNetworkImageHeader.headers,
                                fit: BoxFit.fill,
                              )
                            : AppIcon(
                                icon: AppIcons().ic_user_default_image,
                              ),
                      )),
                  Spacing().smallVertical,
                  AppText.smallWhiteSemiBold(
                    '${AppData().userDetailsUiModel!.firstName.toString().toBeginningOfSentence()} ${AppData().userDetailsUiModel!.lastName.toString().toBeginningOfSentence()}',
                    isCenter: true,
                  ),
                  Spacing().xxsmallVertical,
                  AppText.xsmallWhiteRegular(
                    AppData()
                        .userDetailsUiModel!
                        .designation
                        .toString()
                        .toBeginningOfSentence(),
                    isCenter: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItems(context) {
    return Padding(
      padding: EdgeInsets.all(MarginPadding().xxsmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AppIconWithTextHorizontal(
          //   icon: AppIcons().ic_drawer_bell,
          //   iconHeight: TextSize().xxlarge,
          //   onClick: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(context, RouteName.notificationListScreen);
          //   },
          //   iconText: AppStrings().Notifications,
          //   isBackgroundColorAvailable: true,
          // ),
          // Spacing().xxsmallVertical,
          AppIconWithTextHorizontal(
            icon: AppIcons().ic_drawer_emergency_contact,
            iconHeight: TextSize().xxlarge,
            onClick: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RouteName.emergencyContactScreen);
            },
            iconText: AppStrings().emergency_contact,
            isBackgroundColorAvailable: true,
          ),
          Spacing().xxsmallVertical,
          //   AppIconWithTextHorizontal(
          //   icon: AppIcons().ic_drawer_emergency_contact,
          //   iconHeight: TextSize().xxlarge,
          //   onClick: () {
          //     Navigator.of(context).pop();
          //     Navigator.pushNamed(context, RouteName.trainingVideoScreen);
          //   },
          //   iconText: AppStrings().user_guide,
          //   isBackgroundColorAvailable: true,
          // ),
          // Spacing().xxsmallVertical,
          AppIconWithTextHorizontal(
            icon: AppIcons().ic_drawer_change_password,
            iconHeight: TextSize().xxlarge,
            onClick: () {
              Navigator.of(context).pop();
              _userManagementProvider.isCurrentPasswordVisible = false;
              _userManagementProvider.isNewPasswordVisible = false;
              _userManagementProvider.isConfirmPasswordVisible = false;
              Navigator.pushNamed(context, RouteName.changePasswordScreen);
            },
            iconText: AppStrings().change_password,
            isBackgroundColorAvailable: true,
          ),
          const HorizontalDivider(
            dividerColor: AppColors.text_grey_g2,
          ),
          if (Platform.isAndroid)
            AppIconWithTextHorizontal(
              onClick: () {
                Navigator.pushNamed(context, RouteName.deviceHealthCheckScreen);
              },
              icon: AppIcons().ic_device_test,
              iconHeight: TextSize().xxlarge,
              iconText: AppStrings().device_test,
              isBackgroundColorAvailable: true,
            ),
          // HorizontalDivider(
          //   dividerColor: AppColors.text_grey_g2,
          // ),
          AppIconWithTextHorizontal(
            onClick: () {
              MixpanelService().safetyAppSupportClickEvent();
              LaunchURL.launchBrowser(AppStrings().support_url);
            },
            icon: AppIcons().ic_drawer_solid_support,
            iconHeight: TextSize().xxlarge,
            iconText: AppStrings().support,
            isBackgroundColorAvailable: true,
          ),
          if (AppData().youTubeLinkMobile != null &&
              AppData().youTubeLinkMobile!.isNotEmpty) ...{
            const HorizontalDivider(
              dividerColor: AppColors.text_grey_g2,
            ),
            AppIconWithTextHorizontal(
              onClick: () {
                LaunchURL.launchBrowser(AppData().youTubeLinkMobile);
              },
              icon: AppIcons().ic_drawer_training_videos,
              iconHeight: TextSize().xxlarge,
              iconText: AppStrings().training_videos,
              isBackgroundColorAvailable: true,
            ),
          }
        ],
      ),
    );
  }

  Widget _buildDrawerBtn(context) {
    return Padding(
      padding: EdgeInsets.all(MarginPadding().xlarge),
      child: AppButton(
          buttonName: AppStrings().logout,
          onPressed: () {
            widget.showSubscriptionEndBanner?.hideSubscriptionMaterialBanner();
            _userManagementProvider.userLogout(context, isForceLogout: false);
          },
          backgroundColor: AppColors.color_secondary),
    );
  }

  Widget _buildBackBtn() {
    return Container(
      child: AppIcon(
        iconColor: AppColors.white,
        icon: AppIcons().ic_left_back_arrow,
        onClick: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
