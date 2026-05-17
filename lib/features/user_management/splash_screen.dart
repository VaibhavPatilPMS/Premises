import 'dart:async';

import 'package:flutter/material.dart';
import 'package:premises/application/application.dart';

import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';
import 'user_management.dart';

class SplashScreen extends StatefulWidget {
  final bool? isUserLoggedIn;

  const SplashScreen({super.key, this.isUserLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  String? _appVersion;

  @override
  void initState() {
    super.initState();
    if (widget.isUserLoggedIn!) { 
      MixpanelService().trackEvent(eventName: AppStrings().activeUser);
    }
    _initAppVersion();
  }

  Future<void> _initAppVersion() async {
    _appVersion = await AppVersionDetails.getAppVersion();
    AppData().appVersion = _appVersion;
    _startTimer();
  }

  Widget _buildScreenWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcon(
            icon: AppIcons().ic_app_logo,
            type: IconAssetType.SVG_ICON,
            iconHeight: IconSize().xxxlarge,
            iconWidth: IconSize().xxxlarge,
          ),
          Spacing().smallHorizontal,
          AppText.xxxlargeGreySemiBold(AppStrings().splash_title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithBackgroundImage(
      context: context,
      screenWidget: _buildScreenWidget(),
      imagePath: AppImages().bg_splash,
    );
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: SplashScreenTime.DEFAULT_TIME), () {
      if (widget.isUserLoggedIn!) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.userLoginScreen,
          (route) => false,
          arguments: LoginScreenArguments(appVersion: _appVersion),
        );
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }
}


