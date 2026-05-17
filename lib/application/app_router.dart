import 'package:flutter/material.dart';
import 'package:premises/main_imports.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/features/dashboard/dashboard.dart';
import 'package:premises/features/device_test/device_test.dart';
import 'package:premises/features/offline_sync/offline_sync.dart';
import 'package:premises/features/user_management/user_management.dart';

class RouteName {
  static const getStartedScreen = "/getStarted";
  static const splashScreen = "/splashScreen";
  static const userLoginScreen = "/loginScreen";
  static const forgotPasswordScreen = "/forgotPasswordScreen";
  static const dashboardScreen = "/dashboardScreen";
  static const offlineSyncScreen = "/OfflineSyncScreen";
  static const emergencyContactScreen = "/emergencyContactScreen";
  static const successfullScreen = "/successfullScreen";
  static const notificationListScreen = "/notificationListScreen";
  static const customFilterScreen = "/customFilterScreen";
  static const zoomImageView = "/zoomImageView";
  static const userProfileScreen = "/userProfileScreen";
  static const changePasswordScreen = "/changePasswordScreen";
  static const newCustomCameraAndImagePicker = "/NewCustomCameraAndImagePicker";
  static const videoRecorderPreview = "/videoRecorderPreview";
  static const selfLoginScreen = "/selfLoginScreen";
  static const verifyMobileNumberScreen = "/verifyMobileNumberScreen";
  static const otpVerificationForm = "/OtpVerificationForm";
  static const credentialSentScreen = "/CredentialSent";
  static const signatureConfigurationsScreen = "/signatureConfigurationsScreen";
  static const signatureConfigurationsScreenForEvents =
      "/signatureConfigurationsScreenForEvents";
  static const bulkInductionTrainingSignatureConfigurationScreen =
      "/bulkInductionTrainingSignatureCOnfigurationScreen";

  //Device Health Check
  static const deviceHealthCheckScreen = "/DeviceHealthCheckScreenPage";
}

class AppRouter {
  bool isLoggedIn;

  AppRouter({required this.isLoggedIn});

  Route? router(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _goToInitialPage(isLoggedIn);

      case RouteName.userLoginScreen:
        return _goToLoginScreen(settings.arguments as LoginScreenArguments?);

      case RouteName.forgotPasswordScreen:
        return _goToForgotPasswordScreen(
          settings.arguments as LoginScreenArguments?,
        );

      case RouteName.dashboardScreen:
        return _gotoDashboardScreen();

      // case RouteName.offlineSyncScreen:
      //   return _goToOfflineSyncScreen(
      //     settings.arguments as OfflineSyncScreenArguments?,
      //   );

      // case RouteName.notificationListScreen:
      //   return _goToNotificationScreen();

      case RouteName.newCustomCameraAndImagePicker:
        return _goToNewCustomCameraAndImagePicker(
          settings.arguments != null
              ? settings.arguments as CustomCameraAndImagePickerArgs
              : null,
        );

      case RouteName.customFilterScreen:
        return _goToCustomFilterScreen(
          settings.arguments != null
              ? settings.arguments as CustomFilterArgs
              : null,
        );

      case RouteName.zoomImageView:
        return _goToZoomImageViewScreen(
          settings.arguments != null
              ? settings.arguments as ZoomImageScreenArguments
              : null,
        );
      case RouteName.userProfileScreen:
        return _goToUserProfileScreen();

      case RouteName.changePasswordScreen:
        return _goToChangePasswordScreen();

      case RouteName.deviceHealthCheckScreen:
        return _goToDeviceHealthScreen();

      // case RouteName.selfLoginScreen:
      //   return _goToSelfSignUpScreen();

      // case RouteName.verifyMobileNumberScreen:
      //   return _goToVerifyMobileScreen(
      //     userLoginUiModel: settings.arguments as UserLoginUiModel,
      //   );

      // case RouteName.otpVerificationForm:
      //   return _otpVerificationForm(
      //     mobileOTPModel: settings.arguments as MobileOTPModel,
      //   );

      // case RouteName.successfullScreen:
      //   return _goToSuccessfullScreen(
      //     settings.arguments as SuccessfullScreenArgs,
      //   );

      // case RouteName.credentialSentScreen:
      //   return _credentialSentScreen();

      // case RouteName.signatureConfigurationsScreen:
      //   return _goToSignatureConfigurationScreen();

      // case RouteName.signatureConfigurationsScreenForEvents:
      //   return _goToEventSignatureConfigurationScreen();

      default:
        return _goToInitialPage(isLoggedIn);
    }
  }

  MaterialPageRoute _goToInitialPage(bool loginStatus) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return SplashScreen(isUserLoggedIn: loginStatus);
      },
    );
  }

  MaterialPageRoute _goToLoginScreen(
    LoginScreenArguments? loginScreenArguments,
  ) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return LoginScreen(appVersion: loginScreenArguments?.appVersion);
      },
    );
  }

  MaterialPageRoute _goToForgotPasswordScreen(
    LoginScreenArguments? loginScreenArguments,
  ) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return ForgetPasswordScreen(
          appVersion: loginScreenArguments?.appVersion,
        );
      },
    );
  }

  MaterialPageRoute _gotoDashboardScreen() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return const DashboardScreen();
      },
    );
  }

  // MaterialPageRoute _goToOfflineSyncScreen(
  //   OfflineSyncScreenArguments? offlineSyncScreenArguments,
  // ) {
  //   AppData().customOfflineSyncModule = offlineSyncScreenArguments;
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return OfflineSyncScreen(
  //         offlineSyncScreenArguments: offlineSyncScreenArguments,
  //       );
  //     },
  //   );
  // }

  // MaterialPageRoute _goToSuccessfullScreen(SuccessfullScreenArgs args) {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return SuccessfulScreen(args: args);
  //     },
  //   );
  // }

  MaterialPageRoute _goToNewCustomCameraAndImagePicker(
    CustomCameraAndImagePickerArgs? args,
  ) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return CameraPreviewAndImagePicker(args: args);
      },
    );
  }

  // MaterialPageRoute _goToNotificationScreen() {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return const NotificationScreen();
  //     },
  //   );
  // }

  MaterialPageRoute _goToUserProfileScreen() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return const UserProfilePage();
      },
    );
  }

  MaterialPageRoute _goToChangePasswordScreen() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return const ChangePasswordPage();
      },
    );
  }

  PageRouteBuilder _goToCustomFilterScreen(CustomFilterArgs? args) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CustomFilterScreen(args: args),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  PageRouteBuilder _goToZoomImageViewScreen(
    ZoomImageScreenArguments? zoomImageScreenArguments,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ZoomImagePage(
        fileUrl: zoomImageScreenArguments!.imageUrl!,
        title: zoomImageScreenArguments.title!,
        isOffline: zoomImageScreenArguments.isOffline,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  MaterialPageRoute _goToDeviceHealthScreen() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return const DeviceTestScreenPage();
      },
    );
  }

  // MaterialPageRoute _goToSelfSignUpScreen() {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return const SelfLoginFormPage();
  //     },
  //   );
  // }

  // MaterialPageRoute _goToVerifyMobileScreen({
  //   required UserLoginUiModel? userLoginUiModel,
  // }) {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return VerifyMobileNumberScreen(userLoginUiModel: userLoginUiModel);
  //     },
  //   );
  // }

  // MaterialPageRoute _otpVerificationForm({
  //   required MobileOTPModel mobileOTPModel,
  // }) {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return OtpVerificationForm(mobileOtpModel: mobileOTPModel);
  //     },
  //   );
  // }

  // MaterialPageRoute _credentialSentScreen() {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return CredentialSentScreen();
  //     },
  //   );
  // }

  // PageRouteBuilder _goToSignatureConfigurationScreen() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         const SignatureConfigurationsScreen(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return child;
  //     },
  //   );
  // }

  // PageRouteBuilder _goToEventSignatureConfigurationScreen() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         const EventsSignatureConfigurationsScreen(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return child;
  //     },
  //   );
  // }

}
