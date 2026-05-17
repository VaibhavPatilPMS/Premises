import 'dart:io';
import 'user_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/resources/app_strings.dart';
import 'package:premises/features/dashboard/dashboard.dart';
import 'package:premises/features/offline_sync/offline_sync.dart';

class UserManagementProvider extends BaseProvider {
  final UserLoginUseCase _userLoginUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UserManagementRequestBuilder _requestBuilder;
  UserLoginUiModel userLoginUiModel = UserLoginUiModel();

  //MixpanelService mixpanelService = MixpanelService();
  final SharedPreferencesUtils _sharedPreferencesUtils =
      SharedPreferencesUtils();
  bool? isLoading;
  bool? isLoadingLogout = false;
  bool? isTermsAndCondtionsRead;
  bool? isPrivacyAndPolicyRead;
  bool isTermsAndCondtionsAgree = false;
  bool isPrivacyAndPolicyAgree = false;
  bool? isPrivacyPolicyRead;
  String? contactEmailUpdate;
  String? usersPassword;
  String? usersName;
  List<File>? userProfilePic = [];

  //for login password
  bool? isPasswordVisible = false;

  //for change password
  bool? isCurrentPasswordVisible = false;
  bool? isNewPasswordVisible = false;
  bool? isConfirmPasswordVisible = false;
  bool? isEmergencyContactLoadMore = false;
  List<EmergencyContactDataUiModel>? emergencyContactList = [];
  EmergencyContactUiModel? emergencyContactUiModel = EmergencyContactUiModel(
    success: false,
  );
  int? totalEmergencyContacts;

  bool? isTrainingVideoLoadMore = false;
  List<TrainingVideosDataUiModel>? trainingVideoList = [];
  TrainingVideosUiModel? trainingVideoUiModel = TrainingVideosUiModel(
    success: false,
  );
  int? totalTrainingVideo;

  UserManagementProvider(
    this._userLoginUseCase,
    this._requestBuilder,
    this._forgetPasswordUseCase,
    this._changePasswordUseCase,
    this._updateProfileUseCase,
  ) : super() {
    isLoading = false;
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setTermsAndConditionRead(bool isTermsAndCondtionsRead) {
    this.isTermsAndCondtionsRead = isTermsAndCondtionsRead;
    notifyListeners();
  }

  void setPrivacyAndPolicyRead(bool isPrivacyAndPolicyRead) {
    this.isPrivacyAndPolicyRead = isPrivacyAndPolicyRead;
    notifyListeners();
  }

  void setTermsAndConditionAgree(bool isTermsAndCondtionsAgree) {
    this.isTermsAndCondtionsAgree = isTermsAndCondtionsAgree;
    notifyListeners();
  }

  void setPrivacyAndPolicyAgree(bool isPrivacyAndPolicyAgree) {
    this.isPrivacyAndPolicyAgree = isPrivacyAndPolicyAgree;
    notifyListeners();
  }

  void updateUserProfilePic({List<File>? imageFile}) {
    userProfilePic = imageFile;
    notifyListeners();
  }

  void userLogin({
    String? userName,
    String? password,
    BuildContext? context,
  }) async {
    setLoading(true);
    notifyListeners();

    final requestModel = _requestBuilder.getLoginRequestModel(
      userName: userName,
      password: password,
    );

    try {
      ResponseModel<UserLoginUiModel> response = await _userLoginUseCase
          .execute(request: RequestModel(requestModel));
      if (response.isSuccess!) {
        userLoginUiModel.success = true;
        userLoginUiModel.isUserLoginSupported =
            response.data?.isUserLoginSupported;
        userLoginUiModel.isActive = response.data?.isActive;

        if (userLoginUiModel.isUserLoginSupported!) {
          if (userLoginUiModel.isActive!) {
            userLoginUiModel.data = response.data?.data;
            usersPassword = password;
            usersName = userName;
            _clearLogoutData(context!);
            await _sharedPreferencesUtils.clearSharedPref();

            if (userLoginUiModel.data?.isMobileOtpVerified == false) {
              await _sharedPreferencesUtils.setAuthToken(
                userLoginUiModel.data!.accessToken!,
              );
              await _sharedPreferencesUtils.setUserName(
                userLoginUiModel.data!.username!,
              );
              Navigator.pushNamed(
                context,
                RouteName.verifyMobileNumberScreen,
                arguments: userLoginUiModel,
              );
            } else {
              await _sharedPreferencesUtils.setAuthToken(
                userLoginUiModel.data!.accessToken!,
              );
              // Provider.of<FreemiumUserProvider>(
              //   context,
              //   listen: false,
              // ).resetProviderData(isNotify: true);
              if (userLoginUiModel.data!.refreshToken != null) {
                await _sharedPreferencesUtils.setRefreshToken(
                  userLoginUiModel.data!.refreshToken!,
                );
              }
              await _sharedPreferencesUtils.setUserId(
                userLoginUiModel.data!.id!,
              );
              await _sharedPreferencesUtils.setUserName(
                userLoginUiModel.data!.username!,
              );
              await _sharedPreferencesUtils.setUserDetails(
                userLoginUiModel.data!,
              );
              await _sharedPreferencesUtils.setUserContactNumber(
                userLoginUiModel.data!.phoneNumber!,
              );
              //temp changes for projects drop down
              AssignedProjectUiModel assignedProjectUiModel =
                  AssignedProjectUiModel(
                    success: true,
                    projects: userLoginUiModel.data!.assignedProjects,
                  );
              await _sharedPreferencesUtils.setProjectDetails(
                assignedProjectUiModel,
              );
              if (userLoginUiModel.data != null &&
                  userLoginUiModel.data!.assignedProjects != null &&
                  userLoginUiModel.data!.assignedProjects!.isNotEmpty) {
                await _sharedPreferencesUtils.setSelectedProjectDetails(
                  userLoginUiModel.data!.assignedProjects![0],
                );
              }
              await _getAndSetFCMToken(isLogout: false);
              await _sharedPreferencesUtils.setUserLogin(true);
              MixpanelService().registerSuperProperties({
                "Static First Name": userLoginUiModel.data!.firstName!,
                "Static Last Name": userLoginUiModel.data!.lastName!,
                "Static Email": userLoginUiModel.data!.email!,
                "Static Mobile Number": userLoginUiModel.data!.phoneNumber!
                    .toString(),
                // "Static User Hash": userLoginUiModel.data!.id!,
                "Static Username": userLoginUiModel.data!.username!,
              });
              MixpanelService().registerPeopleProperties(
                firstname: userLoginUiModel.data!.firstName!,
                lastname: userLoginUiModel.data!.lastName!,
                email: userLoginUiModel.data!.email!,
                mobilenumber: userLoginUiModel.data!.phoneNumber!.toString(),
                user_id: userLoginUiModel.data!.id!,
                userhash: userLoginUiModel.data!.id!,
                username: userLoginUiModel.data!.username!,
              );
              MixpanelService().loginSuccessEvent();
              MixpanelService().trackEvent(eventName: AppStrings().activeUser);
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.dashboardScreen,
                (route) => false,
              );
            }
          } else {
            AppStrings().deactivate_user.showAsToast(
              context: context!,
              type: ToastType.TOAST_ERROR,
            );
          }
        } else {
          AppStrings().error_invalid_platform.showAsToast(
            context: context!,
            type: ToastType.TOAST_ERROR,
          );
        }
      } else {
        userLoginUiModel.success = false;
        userLoginUiModel.statusCode = response.statusCode;
        userLoginUiModel.message = response.message;
        userLoginUiModel.isUserLoginSupported =
            response.data?.isUserLoginSupported;

        userLoginUiModel.message != null
            ? userLoginUiModel.message?.showAsToast(
                context: context!,
                type: ToastType.TOAST_ERROR,
              )
            : _getLoginErrorMessage(userLoginUiModel.statusCode)
                  .toString()
                  .showAsToast(context: context!, type: ToastType.TOAST_ERROR);
      }
    } catch (e) {
      CustomLogger.logPrint('exceptions ${e.toString()}');
      userLoginUiModel.success = false;
      userLoginUiModel.message != null
          ? userLoginUiModel.message?.showAsToast(
              context: context!,
              type: ToastType.TOAST_ERROR,
            )
          : _getLoginErrorMessage(userLoginUiModel.statusCode)
                .toString()
                .showAsToast(context: context!, type: ToastType.TOAST_ERROR);
      setLoading(false);
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
  }

  void forgetPassword({
    String? userName,
    BuildContext? context,
    String? appVersion,
  }) async {
    setLoading(true);
    notifyListeners();

    final requestModel = _requestBuilder.getForgetRequestModel(
      userName: userName,
    );

    ResponseModel<CommonResponseUiModel> response = await _forgetPasswordUseCase
        .execute(request: RequestModel(requestModel));
    if (response.isSuccess!) {
      Navigator.pushNamed(
        context!,
        RouteName.successfullScreen,
        arguments: SuccessfullScreenArgs(
          title: response.message!,
          onPressed: null,
          routeName: RouteName.userLoginScreen,
          screenArguments: LoginScreenArguments(appVersion: appVersion),
        ),
      );
    } else {
      _getForgotPasswordErrorMessage(
        response.statusCode,
      ).toString().showAsToast(context: context!, type: ToastType.TOAST_ERROR);
    }
    setLoading(false);
    notifyListeners();
  }

  void changePassword({
    String? currentpassword,
    String? newpassword,
    String? confirmedpassword,
    BuildContext? context,
    String? appVersion,
  }) async {
    setLoading(true);
    notifyListeners();

    RequestModel<ChangePasswordRequestModel> requestModel =
        await _requestBuilder.getChangePasswordRequestModel(
          currentpassword: currentpassword,
          confirmedpassword: confirmedpassword,
          newpassword: newpassword,
        );

    ResponseModel<CommonResponseUiModel> response = await _changePasswordUseCase
        .execute(request: requestModel);

    if (response.isSuccess!) {
      Navigator.pushNamed(
        context!,
        RouteName.successfullScreen,
        arguments: SuccessfullScreenArgs(
          title: response.message!,
          onPressed: () {
            userLogout(context, isForceLogout: false);
          },
          routeName: RouteName.userLoginScreen,
          screenArguments: LoginScreenArguments(appVersion: appVersion),
        ),
      );
    } else {
      _getChangePasswordErrorMessage(
        response.statusCode,
      ).toString().showAsToast(context: context!, type: ToastType.TOAST_ERROR);
    }
    setLoading(false);
    notifyListeners();
  }

  void updateUserProfile({
    String? contactEmail,
    File? userProfilePic,
    BuildContext? context,
  }) async {
    setLoading(true);
    notifyListeners();

    RequestModel<UpdateProfileRequestModel> requestModel = await _requestBuilder
        .getUpdateProfileRequestModel(
          contactEmailId: contactEmail,
          profilePicFile: userProfilePic,
        );

    ResponseModel<UserLoginUiModel> response = await _updateProfileUseCase
        .execute(request: requestModel);

    if (response.isSuccess!) {
      await _sharedPreferencesUtils.setUserDetails(response.data!.data!);
      this.userProfilePic!.clear();
      Navigator.pushNamed(
        context!,
        RouteName.successfullScreen,
        arguments: SuccessfullScreenArgs(
          title: contactEmail != null
              ? AppStrings().email_id_update
              : AppStrings().profile_picture_update,
          onPressed: null,
          routeName: RouteName.userProfileScreen,
          screenArguments: LoginScreenArguments(appVersion: null),
        ),
      );
    } else {
      _getUpdateProfileErrorMessage(
        response.statusCode,
      ).toString().showAsToast(context: context!, type: ToastType.TOAST_ERROR);
    }
    setLoading(false);
    notifyListeners();
  }

  void userLogout(BuildContext context, {required bool? isForceLogout}) async {
    isLoadingLogout = true;
    notifyListeners();
    //setLoading(true);
    //notifyListeners();
    String? appVersion = await AppVersionDetails.getAppVersion();
    try {
      bool isLoggedIn = await _sharedPreferencesUtils.getUserLoginStatus();
      bool isOfflineSyncPendingData = await _checkPendingOfflineSyncPendingData(
        isLoggedIn,
      );
      if (isOfflineSyncPendingData) {
        // HiveSafetyObservationService.clearAllBoxes();
        String? appVersion = await AppVersionDetails.getAppVersion();
        if (isLoggedIn) {
          //_clearLogoutData(context);
          //await _sharedPreferencesUtils.clearSharedPref();
          await _getAndSetFCMToken(isLogout: true);
          await _sharedPreferencesUtils.setUserLogin(false);
          MixpanelService().logoutSuccessEvent();
          MixpanelService().mixpanelReset();
          isLoadingLogout = false;
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.userLoginScreen,
            (route) => false,
            arguments: LoginScreenArguments(appVersion: appVersion),
          );
        }
      } else {
        if (isForceLogout!) {
          await _getAndSetFCMToken(isLogout: true);
          if (isLoggedIn) {
            //_clearLogoutData(context);
            //await _sharedPreferencesUtils.clearSharedPref();
            await _sharedPreferencesUtils.setUserLogin(false);
            MixpanelService().logoutSuccessEvent();
            MixpanelService().mixpanelReset();
            isLoadingLogout = false;
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.userLoginScreen,
              (route) => false,
              arguments: LoginScreenArguments(appVersion: appVersion),
            );
          }
        } else {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      await _getAndSetFCMToken(isLogout: true);
      //_clearLogoutData(context);
      //await _sharedPreferencesUtils.clearSharedPref();
      await _sharedPreferencesUtils.setUserLogin(false);
      MixpanelService().logoutSuccessEvent();
      MixpanelService().mixpanelReset();
      isLoadingLogout = false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.userLoginScreen,
        (route) => false,
        arguments: LoginScreenArguments(appVersion: appVersion),
      );
    }
    isLoadingLogout = false;
  }

  _clearLogoutData(BuildContext context) {
    //for change password
    isPasswordVisible = false;
    isCurrentPasswordVisible = false;
    isNewPasswordVisible = false;
    isConfirmPasswordVisible = false;
    AppData().userDetailsUiModel = null;
    AppData().userLocationDetails = null;
    AppData().userid = null;
    AppData().userName = null;
    AppData().projectid = null;
    AppData().projectName = null;
    AppData().assignedProjects = null;
    AppData().userCurrentSelectedProject = null;
    AppData().currentUserSelectedProjectIndex = null;
    AppData().isOfflineUsageDialogShow = false;

    Provider.of<DashboardProvider>(
      context,
      listen: false,
    ).entitlementPermissionsListDashboard!.clear();
    Provider.of<DashboardProvider>(
      context,
      listen: false,
    ).entitlementPermissionsListQuickActions!.clear();
    if (Provider.of<DashboardProvider>(
          context,
          listen: false,
        ).projectUiModel?.projects !=
        null) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).projectUiModel?.projects!.clear();
    }
  }

  _getLoginErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 401:
        return AppStrings().error_login_failed;
      default:
        return AppStrings().error_some_thing_went_wrong;
    }
  }

  _getForgotPasswordErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 401:
        return AppStrings().error_login_failed;
      case 404:
        return AppStrings().error_forget_password_failed;
      default:
        return AppStrings().error_some_thing_went_wrong;
    }
  }

  _getChangePasswordErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 401:
        return AppStrings().error_login_failed;
      case 404:
        return AppStrings().error_forget_password_failed;
      default:
        return AppStrings().enter_correct_password;
    }
  }

  _getUpdateProfileErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 401:
        return AppStrings().error_updating_user_profile;
      case 404:
        return AppStrings().error_updating_user_profile;
      default:
        return AppStrings().error_updating_user_profile;
    }
  }

  void setPasswordVisibility() {
    isPasswordVisible = isPasswordVisible! ? false : true;
    notifyListeners();
  }

  // for change password
  void setCurrentPasswordVisibility() {
    isCurrentPasswordVisible = isCurrentPasswordVisible! ? false : true;
    notifyListeners();
  }

  void setNewPasswordVisibility() {
    isNewPasswordVisible = isNewPasswordVisible! ? false : true;
    notifyListeners();
  }

  void setConfirmPasswordVisibility() {
    isConfirmPasswordVisible = isConfirmPasswordVisible! ? false : true;
    notifyListeners();
  }

  _getAndSetFCMToken({bool? isLogout}) async {
    //Set FCM Token
    try {
      //String? token = await FirebaseMessaging.instance.getToken();
      String? token = await FirebaseNotifications().getFirebaseMessagingToken();
      AppData().firebaseToken = token;
      //CustomLogger.printAll('firebase token ${AppData().firebaseToken}');

      RequestModel<UpdateProfileRequestModel> requestModel =
          await _requestBuilder.updateAndSetFCMToken(
            fcmToken: isLogout!
                ? ""
                : AppData().firebaseToken.toString().trim(),
          );

      ResponseModel<UserLoginUiModel> response = await _updateProfileUseCase
          .execute(request: requestModel);
      if (response.isSuccess!) {
        CustomLogger.printAll('Firebase Notification Set Successfully');
      }
    } catch (e) {
      CustomLogger.logPrint('firebase exceptions ${e.toString()}');
    }
  }

  onEmailChange(String? email) {
    contactEmailUpdate = email;
    notifyListeners();
  }



  _checkPendingOfflineSyncPendingData(bool? isLoggedIn) async {
    if (isLoggedIn! &&
        AppData().userCurrentSelectedProject != null &&
        AppData().assignedProjects != null) {

      // Just for reference
      // List<CreateInductionTrainingModel>? offlineInductionTrainingList =
      //     await HiveInductionService.getOfflineInductionTrainings(
      //       AppData().userCurrentSelectedProject!.projectCode,
      //     );

      // List<CreateWorkPermitRequestModel>? offlineWorkPermitList =
      //     await HiveWorkPermitService.getOfflineWorkPermits(
      //       AppData().userCurrentSelectedProject!.projectCode,
      //     );

      // List<AttendanceCaptureRequestModel>? offlineScannedAttendanceList =
      //     await HiveAttendanceCaptureService.getAttendanceRecords(
      //       AppData().userCurrentSelectedProject!.projectCode,
      //     );

      // if (offlineToolboxTrainingList != null &&
      //     offlineToolboxTrainingList.isNotEmpty) {
      //   return false;
      // } else if (offlineInductionTrainingList != null &&
      //     offlineInductionTrainingList.isNotEmpty) {
      //   return false;
      // } else if (offlineWorkPermitList != null &&
      //     offlineWorkPermitList.isNotEmpty) {
      //   return false;
      // } else if (offlineScannedAttendanceList != null &&
      //     offlineScannedAttendanceList.isNotEmpty) {
      //   return false;
      // } else if (offlineChecklistDetailRequestModelList!.isNotEmpty) {
      //   return false;
      // } else if (offlineSafetyObservationList!.isNotEmpty) {
      //   return false;
      // } else {
      //   return true;
      // }
    } else {
      return true;
    }
  }

  checkStoragePermission(BuildContext? context) async {
    AppData().storagePermission = await PermissionUtils()
        .handleStoragePermission(context);
  }

  getOTPVerifiedStatus({required BuildContext context}) async {
    setLoading(true);
    notifyListeners();
    bool isVisitorOTPVerified = await _sharedPreferencesUtils
        .getVisitorOTPVerifiedStatus();
    String? visitorEmailId = await _sharedPreferencesUtils.getVisitorEmailId();
    if (isVisitorOTPVerified) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteName.dashboardScreen,
        (route) => false,
        arguments: visitorEmailId,
      );
    } else {
      Navigator.of(context).pushNamed(RouteName.dashboardScreen);
    }
    setLoading(false);
    notifyListeners();
  }
}
