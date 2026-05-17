import 'dart:io';
import 'dashboard.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:premises/app_config.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/network/error_builder.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';


class DashboardProvider extends BaseProvider {
  bool? isLoading;
  final SharedPreferencesUtils _sharedPreferencesUtils =
      SharedPreferencesUtils();
  final CommonRequestBuilder? _requestBuilder;
  final GeofencingRequestBuilder? _geofencingRequestBuilder;
  final ProjectEntitlementsUseCase? _projectEntitlementsUseCase;
  final DashboardPendingCountUseCase? _dashboardPendingCountUseCase;
  final GlobalConfigurationsUseCase? _globalConfigurationsUseCase;
  final GeofancingUseCase? _geofancingUseCase;
  final ProjectListUseCase? _projectListUseCase;
  AssignedProjectUiModel? projectUiModel = AssignedProjectUiModel(
    success: false,
  );
  EntitlementUiModel? entitlementUiModel = EntitlementUiModel(success: false);
  GlobalConfigurationsUiModel? globalConfigurationsUiModel =
      GlobalConfigurationsUiModel(success: false);
  ProjectDetailsUiModel? userSelectedProject = ProjectDetailsUiModel(
    projectName: '',
  );
  List<DashboardCarouselPendingCountsUIModel>? dashboardCarouselPendingCounts =
      [];

  List<OfflineSyncModel?>? offlineSyncStatusModelList = [];

  int selectedProjectIndex = 0;
  bool showError = false;
  String? errorMessage;
  bool? isSubscriptionExpired;
  String? userAssignedProjectsForProfile;
  String? legalEntityName;
  String? youTubeLinkMobile;

  List<EntitlementPermissionsUiModel>? entitlementPermissionsListDashboard = [];
  List<EntitlementPermissionsUiModel>? entitlementPermissionsListQuickActions =
      [];
  List<GlobalConfigurationsUiDataModel>? globalConfigurationsList = [];

  ShowSubscriptionEndBanner? showSubscriptionEndBanner;

  DashboardProvider(
    this._requestBuilder,
    this._geofencingRequestBuilder,
    this._projectEntitlementsUseCase,
    this._globalConfigurationsUseCase,
    this._dashboardPendingCountUseCase,
    this._geofancingUseCase,
    this._projectListUseCase,
  ) : super() {
    isLoading = true;
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setSubscription(ShowSubscriptionEndBanner subscriptionEndBanner) {
    showSubscriptionEndBanner = subscriptionEndBanner;
  }

  void checkLocationPermission() async {
    if (Platform.isIOS) return;
    UserLocationDetails? userLocationDetails = await LocationUtils()
        .getLocationDetails();
    if (userLocationDetails != null) {
    } else {
      return;
    }
  }

  void getUserAssignedProjects({
    BuildContext? context,
    required int? userSelectedProjectIndex,
  }) async {
    setLoading(true);
    if (projectUiModel!.projects == null || projectUiModel!.projects!.isEmpty) {
      RequestModel<CommonRequestModel> requestModel = await _requestBuilder!
          .getCommonRequestModel();

      ResponseModel<List<ProjectDetailsUiModel>> response =
          await _projectListUseCase!.execute(request: requestModel);

      if (response.isSuccess!) {
        projectUiModel!.success = true;
        projectUiModel!.projects = response.data;
        MixpanelService().registerSuperProperties({
          "Static First Name": AppData().userDetailsUiModel?.firstName ?? '',
          "Static Last Name": AppData().userDetailsUiModel?.lastName ?? '',
          "Static Email": AppData().userDetailsUiModel?.email ?? '',
          "Static Mobile Number":
              AppData().userDetailsUiModel?.phoneNumber ?? '',
          // "Static User Hash": AppData().userDetailsUiModel?.id  ?? '',
          "Static Username": AppData().userDetailsUiModel?.username ?? '',
        });
        if (projectUiModel!.projects != null &&
            projectUiModel!.projects!.isNotEmpty) {
          selectedProjectIndex = userSelectedProjectIndex ?? 0;
          userSelectedProject = projectUiModel!.projects![selectedProjectIndex];
          isSubscriptionExpired = userSelectedProject?.isSubscriptionActive;
          legalEntityName = userSelectedProject?.legalEntityName;
          //isSubscriptionExpired = true;
          // selectedProjectIndex = 0;
          if (isSubscriptionExpired ?? false) {
            showSubscriptionEndBanner!.showSubscriptionMaterialBanner();
          } else {
            showSubscriptionEndBanner!.hideSubscriptionMaterialBanner();
          }

          AppData().userAssignedProjectsForProfile =
              getUserAssignedProjectsString(projectUiModel!.projects);

          await _sharedPreferencesUtils.setProjectDetails(projectUiModel!);
          await _sharedPreferencesUtils.setSelectedProjectDetails(
            projectUiModel!.projects![selectedProjectIndex],
          );

          getProjectEntitlements(context: context);
          notifyListeners();
        } else {
          //CustomLogger.logPrint('inside else');
          setLoading(false);
          showError = true;
          notifyListeners();
        }
      } else {
        setLoading(false);
        showError = true;
        if (response.dioException != null) {
          errorMessage = DioErrorMessages.getUserFriendlyErrorMessage(
            response.dioException,
          );
        }
        notifyListeners();
      }
    } else {
      getProjectEntitlements(context: context);
    }
    //setLoading(false);
    //notifyListeners();
  }

  void getProjectEntitlements({BuildContext? context}) async {
    if ((entitlementPermissionsListDashboard!.isEmpty &&
            entitlementPermissionsListQuickActions!.isEmpty) ||
        AppData().isForceRefreshData) {
      CustomLogger.logPrint('inside getProjectEntitlements');
      if (entitlementPermissionsListDashboard!.isNotEmpty &&
          entitlementPermissionsListQuickActions!.isNotEmpty) {
        entitlementPermissionsListDashboard?.clear();
        entitlementPermissionsListQuickActions?.clear();
        dashboardCarouselPendingCounts?.clear();
        setLoading(true);
        //notifyListeners();
      }
      RequestModel<CommonRequestModel> requestModel = await _requestBuilder!
          .getCommonRequestModel();
      ResponseModel<EntitlementUiModel> response =
          await _projectEntitlementsUseCase!.execute(request: requestModel);

      if (response.isSuccess!) {
        entitlementUiModel!.success = true;
        entitlementUiModel = response.data;

        entitlementUiModel!.data = response.data!.data;

        if (userSelectedProject?.roleCode == FreemiumUserRoles.MOBILE_ADMIN ||
            userSelectedProject?.roleCode == FreemiumUserRoles.MOBILE_USER) {
          entitlementPermissionsListDashboard =
              entitlementUiModel!.data!.entitlementPermissionsDashboardMenuList;
        } else {
          entitlementPermissionsListDashboard = entitlementUiModel!
              .data!
              .entitlementPermissionsDashboardMenuList!
              .where((element) => element.isVisible!)
              .toList();
        }

        //Update Project Image Here
        userSelectedProject!.projectImageToDisplay =
            entitlementUiModel!.data!.projectImagePath;

        // CustomLogger.logPrint('userSelectedProject ${userSelectedProject?.projectCode}');
        // CustomLogger.logPrint('userSelectedProject ${userSelectedProject!.projectImageToDisplay}');
        // CustomLogger.logPrint('userSelectedProject ${AppData().userCurrentSelectedProject!.projectCode}');

        projectUiModel!.projects![selectedProjectIndex].projectImageToDisplay =
            entitlementUiModel!.data!.projectImagePath;

        if (userSelectedProject?.roleCode == FreemiumUserRoles.MOBILE_ADMIN ||
            userSelectedProject?.roleCode == FreemiumUserRoles.MOBILE_USER) {
          entitlementPermissionsListQuickActions =
              entitlementUiModel!.data!.entitlementPermissionsQuickActionsList;
        } else {
          entitlementPermissionsListQuickActions = entitlementUiModel!
              .data!
              .entitlementPermissionsQuickActionsList!
              .where((element) => element.isVisible!)
              .toList();
        }

        if (entitlementPermissionsListDashboard!.isEmpty &&
            entitlementPermissionsListQuickActions!.isEmpty) {
          showError = true;
        } else {
          showError = false;
          errorMessage = null;
          //Fetch Offline Data and Store
          // if (globalConfigurationsList!.isEmpty ||
          //     AppData().isForceRefreshData) {
          //   await getGlobalConfigurations();
          // }
          // getDashboardPendingCounts();

          await Future.wait([
            if (globalConfigurationsList!.isEmpty ||
                AppData().isForceRefreshData) ...{
              getGlobalConfigurations(),
            },
            getDashboardPendingCounts(),
          ]).then((List<dynamic> allResults) {
            //CustomLogger.logPrint('all results length ${allResults.length}');
          });
          // await getAllOfflineModulesData(
          //     context: context, projectCode: userSelectedProject!.projectCode);
        }
        setLoading(false);
        notifyListeners();
        //CustomLogger.logPrint('entitlement list  length ${entitlementPermissionsListDashboard!.length}');
      } else {
        setLoading(false);
        notifyListeners();
        entitlementUiModel?.success = false;
        showError = true;
        if (response.dioException != null) {
          errorMessage = DioErrorMessages.getUserFriendlyErrorMessage(
            response.dioException,
          );
        }
      }
    } else {
      if (entitlementPermissionsListDashboard!.isEmpty &&
          entitlementPermissionsListQuickActions!.isEmpty) {
        showError = true;
      } else {
        showError = false;
        errorMessage = null;
        //Fetch Offline Data and Store
        // if (globalConfigurationsList!.isEmpty || AppData().isForceRefreshData) {
        //   await getGlobalConfigurations();
        // }
        // getDashboardPendingCounts();
        await Future.wait([
          if (globalConfigurationsList!.isEmpty ||
              AppData().isForceRefreshData) ...{
            getGlobalConfigurations(),
          },
          getDashboardPendingCounts(),
        ]).then((List<dynamic> allResults) {
          //CustomLogger.logPrint('all results length ${allResults.length}');
        });
        // await getAllOfflineModulesData(
        //     context: context, projectCode: userSelectedProject!.projectCode);
      }
      setLoading(false);
      notifyListeners();
    }
    //setLoading(false);
    //notifyListeners();
  }

  Future getDashboardPendingCounts() async {
    RequestModel<CommonRequestModel> requestModel = await _requestBuilder!
        .getCommonRequestModel();
    ResponseModel<PendingTasksUIModel> response =
        await _dashboardPendingCountUseCase!.execute(request: requestModel);

    if (response.isSuccess!) {
      dashboardCarouselPendingCounts =
          response.data!.data![0].dashboardCarouselPendingCounts;
    } else {
      dashboardCarouselPendingCounts = [];
    }

    //setLoading(false);
    notifyListeners();
  }

  Future<bool> checkIsInGeofencingArea(
    BuildContext context,
    String? moduleName,
  ) async {
    setLoading(true);
    notifyListeners();
    UserLocationDetails? userLocationDetails = await LocationUtils()
        .getLocationDetails(moduleName: moduleName);
    if (userLocationDetails == null) {
      setLoading(false);
      notifyListeners();
      LocationUtils()
          .getModulewiseLocationAndGPSPermissionMessage(moduleName)
          .showAsToast(context: context, type: ToastType.TOAST_ERROR);
      return false;
    }
    RequestModel<GeofencingRequestModel> requestModel =
        await _geofencingRequestBuilder!.getCommonRequestModel(
          userLocationDetails,
          moduleName,
        );
    ResponseModel<GeofencingUiModel> response = await _geofancingUseCase!
        .execute(request: requestModel);

    if (response.isSuccess!) {
      setLoading(false);
      notifyListeners();
      if (response.data != null &&
          response.data!.isWithinGeofence != null &&
          response.data!.isWithinGeofence!) {
        return true;
      } else {
        response.data!.message!.showAsToast(
          context: context,
          type: ToastType.TOAST_ERROR,
        );
        return false;
      }
    } else {
      setLoading(false);
      notifyListeners();
      response.data!.message!.showAsToast(
        context: context,
        type: ToastType.TOAST_ERROR,
      );
      return false;
    }
  }

  Future<bool>? checkProjectIsSyncOrNot(
    ProjectDetailsUiModel? selectedProject,
  ) async {
    setLoading(true);
    notifyListeners();
    OfflineSyncModel? offlineSyncStatusModel =
        await HiveDashboardService.getOfflineSyncStatusProjectWise(
          selectedProject!.projectCode,
        );

    if (!isNetworkConnected && offlineSyncStatusModel == null) {
      setLoading(false);
      notifyListeners();
      return false;
    } else if (!isNetworkConnected &&
        !offlineSyncStatusModel!.isEntitlementsDataSync!) {
      setLoading(false);
      notifyListeners();
      return false;
    } else {
      setLoading(false);
      notifyListeners();
      return true;
    }
  }

  Future<bool>? checkProjectOfflineModuleDataIsSyncOrNot(
    ProjectDetailsUiModel? selectedProject,
  ) async {
    setLoading(true);
    notifyListeners();
    OfflineSyncModel? offlineSyncStatusModel =
        await HiveDashboardService.getOfflineSyncStatusProjectWise(
          selectedProject!.projectCode,
        );

    if (!isNetworkConnected && offlineSyncStatusModel == null) {
      setLoading(false);
      notifyListeners();
      return false;
    } else if (!isNetworkConnected &&
        !offlineSyncStatusModel!.isOfflineModuleDataSync!) {
      setLoading(false);
      notifyListeners();
      return false;
    } else {
      setLoading(false);
      notifyListeners();
      return true;
    }
  }

  checkAllProjectsSyncStatus({bool? isNotify = false}) async {
    setLoading(true);
    if (isNotify!) {
      notifyListeners();
    }

    offlineSyncStatusModelList = [];
    if (projectUiModel!.projects != null &&
        projectUiModel!.projects!.isNotEmpty) {
      for (var element in projectUiModel!.projects!) {
        OfflineSyncModel? offlineSyncStatusModel = OfflineSyncModel();
        offlineSyncStatusModel =
            await HiveDashboardService.getOfflineSyncStatusProjectWise(
              element.projectCode,
            );
        if (offlineSyncStatusModel == null ||
            offlineSyncStatusModel.projectCode == null) {
          offlineSyncStatusModel = OfflineSyncModel(
            projectName: element.projectName,
            projectCode: element.projectCode,
            isEntitlementsDataSync: false,
            isOfflineModuleDataSync: false,
          );
        } else if (offlineSyncStatusModel.projectCode != null &&
            offlineSyncStatusModel.projectName == null) {
          offlineSyncStatusModel.projectName = element.projectName;
        }
        offlineSyncStatusModelList!.add(offlineSyncStatusModel);
      }
    }
    setLoading(false);
    notifyListeners();
  }

  Future getGlobalConfigurations() async {
    try {
      globalConfigurationsList!.clear();
      RequestModel<CommonRequestModel> requestModel = await _requestBuilder!
          .getCommonRequestModel();
      ResponseModel<GlobalConfigurationsUiModel> response =
          await _globalConfigurationsUseCase!.execute(request: requestModel);

      if (response.isSuccess!) {
        globalConfigurationsUiModel!.success = true;
        globalConfigurationsUiModel = response.data;
        globalConfigurationsUiModel!.data = response.data!.data;
        globalConfigurationsList = response.data!.data;

        AppData().isTraineeSignatureMandatory =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.TBT_CONFIGURATIONS,
                )
                ?.isActive ??
            false;

        AppData().isWorkPermitMandatory =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.WORK_PERMIT_CONFIGURATIONS,
                )
                ?.isActive ??
            false;

        AppData().isTBTGroupPhotoGalleryAllowed =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.TBT_GROUP_PHOTO,
                )
                ?.isActive ??
            false;

        //CustomLogger.logPrint('AppData().isTBTGroupPhotoGalleryAllowed ${AppData().isTBTGroupPhotoGalleryAllowed}');

        AppData().isInductionProfileGalleryAllowed =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.INDUCTION_PROFILE_PHOTO,
                )
                ?.isActive ??
            false;

        AppData().isSafetyObservationRaiseGalleryAllowed =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.SAFETY_OBSERVATION_RAISE_PHOTO,
                )
                ?.isActive ??
            false;

        AppData().isSafetyObservationResolveGalleryAllowed =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.SAFETY_OBSERVATION_RESOLVE_PHOTO,
                )
                ?.isActive ??
            false;

        AppData().isSafetyObservationCloseGalleryAllowed =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.SAFETY_OBSERVATION_CLOSE_PHOTO,
                )
                ?.isActive ??
            false;

        AppData().ocrAccessKey =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.ocrAccessKey == true ||
                      element.ocrAccessKey == false,
                )
                ?.ocrAccessKey ??
            false;

        // AppData().allowToFetchSignatureFromInductionForTBTTrainee =
        //     globalConfigurationsList!
        //             .firstWhereOrNull((element) =>
        //                 element.configurationTypeCode ==
        //                 GlobalConfigurationsCode
        //                     .TBT_ALLOW_FETCH_SIGNATURE_FROM_INDUCTION)
        //             ?.isActive ??
        //         false;

        // AppData().allowToFetchSignatureFromInductionForEventAttendees =
        //     globalConfigurationsList!
        //             .firstWhereOrNull((element) =>
        //                 element.configurationTypeCode ==
        //                 GlobalConfigurationsCode
        //                     .EVENTS_ALLOW_FETCH_SIGNATURE_IN_EVENTS_FROM_INDUCTION)
        //             ?.isActive ??
        //         false;

        AppData().isTBTReviewerMandatory =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.TBT_REVIEWER_CONFIGURATION,
                )
                ?.isActive ??
            false;

        AppData().isSelectAllAllowed =
            globalConfigurationsList!
                .firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode.SELECT_ALL_CONFIG,
                )
                ?.isActive ??
            false;

        CustomLogger.logPrint(
          'AppData().isSelectAllAllowed ${AppData().isSelectAllAllowed}',
        );

        AppData().makerStr =
            globalConfigurationsList!
                .firstWhereOrNull((element) => element.maker != null)
                ?.maker ??
            AppStrings().tbt_maker;

        AppData().checkerStr =
            globalConfigurationsList!
                .firstWhereOrNull((element) => element.checker != null)
                ?.checker ??
            AppStrings().tab_checker;

        AppData().checkerInitials = AppData().checkerStr!.isNotEmpty
            ? AppData().checkerStr![0].toUpperCase()
            : '';

        AppData().hoursLimit =
            int.tryParse(
              globalConfigurationsList!
                  .firstWhereOrNull((element) => element.hoursLimit != null)!
                  .hoursLimit
                  .toString(),
            ) ??
            24;

        CustomLogger.logPrint('AppData hoursLimit ${AppData().hoursLimit}');

        buildSignatureConfigurationsToolBoxTrainings();
        buildSignatureConfigurationsEventsAndTrainings();

        //CustomLogger.logPrint('AppData().isSelectAllAllowed ${AppData().isSelectAllAllowed}');
        //CustomLogger.logPrint('AppData().isTBTReviewerMandatory ${AppData().isTBTReviewerMandatory}');
      } else {
        globalConfigurationsUiModel?.success = false;
        AppData().isTraineeSignatureMandatory = false;
      }
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
    //setLoading(false);
    notifyListeners();
  }

  void buildSignatureConfigurationsToolBoxTrainings() {
    AppData().tbtSignatureConfigurations = [];
    if (globalConfigurationsList != null &&
        globalConfigurationsList!.isNotEmpty) {
      AppData().allowToFetchSignatureFromInductionForTBTTrainee =
          globalConfigurationsList
              ?.firstWhereOrNull(
                (element) =>
                    element.configurationTypeCode ==
                    GlobalConfigurationsCode
                        .TBT_ALLOW_FETCH_SIGNATURE_FROM_INDUCTION,
              )
              ?.isActive ??
          false;
      if (AppData().allowToFetchSignatureFromInductionForTBTTrainee ?? false) {
        AppData().tbtSignatureConfigurations.add(
          SignatureConfigurationUIModel(
            label: globalConfigurationsList
                ?.firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode
                          .TBT_ALLOW_FETCH_SIGNATURE_FROM_INDUCTION,
                )
                ?.configuration!
                .lable,
            signatureOf: TBTSignatureType.TRAINEE.name,
            value: true,
            typeCode: GlobalConfigurationsCode
                .TBT_ALLOW_FETCH_SIGNATURE_FROM_INDUCTION,
          ),
        );
      }
      for (var element in globalConfigurationsList!) {
        if ((element.isActive ?? false) &&
            element.configurationTypeCode ==
                GlobalConfigurationsCode
                    .TBT_SIGNATURE_BY_INDIVIDUAL_TRAINEE_MAKER) {
          AppData().tbtSignatureConfigurations.add(
            SignatureConfigurationUIModel(
              label: element.configuration!.lable,
              signatureOf: TBTSignatureType.TRAINEE.name,
              value: true,
              typeCode: GlobalConfigurationsCode
                  .TBT_SIGNATURE_BY_INDIVIDUAL_TRAINEE_MAKER,
            ),
          );
        } else if ((element.isActive ?? false) &&
            element.configurationTypeCode ==
                GlobalConfigurationsCode
                    .TBT_ALLOW_CONTRACTOR_SIGNATURE_BEHALF_TRAINEE) {
          AppData().tbtSignatureConfigurations.add(
            SignatureConfigurationUIModel(
              label: element.configuration!.lable,
              signatureOf: TBTSignatureType.CONTRACTOR.name,
              value: true,
              typeCode: GlobalConfigurationsCode
                  .TBT_ALLOW_CONTRACTOR_SIGNATURE_BEHALF_TRAINEE,
            ),
          );
        } else if ((element.isActive ?? false) &&
            element.configurationTypeCode ==
                GlobalConfigurationsCode
                    .TBT_ALLOW_MAKER_SIGNATURE_BEHALF_TRAINEE) {
          AppData().tbtSignatureConfigurations.add(
            SignatureConfigurationUIModel(
              label: element.configuration!.lable,
              signatureOf: TBTSignatureType.MAKER.name,
              value: true,
              typeCode: GlobalConfigurationsCode
                  .TBT_ALLOW_MAKER_SIGNATURE_BEHALF_TRAINEE,
            ),
          );
        }
      }
    }
  }

  void buildSignatureConfigurationsEventsAndTrainings() {
    AppData().eventSignatureConfigurations = [];
    if (globalConfigurationsList != null &&
        globalConfigurationsList!.isNotEmpty) {
      AppData().allowToFetchSignatureFromInductionForEventAttendees =
          globalConfigurationsList
              ?.firstWhereOrNull(
                (element) =>
                    element.configurationTypeCode ==
                    GlobalConfigurationsCode
                        .EVENTS_ALLOW_FETCH_SIGNATURE_IN_EVENTS_FROM_INDUCTION,
              )
              ?.isActive ??
          false;
      if (AppData().allowToFetchSignatureFromInductionForEventAttendees ??
          false) {
        AppData().eventSignatureConfigurations.add(
          SignatureConfigurationUIModel(
            label: globalConfigurationsList
                ?.firstWhereOrNull(
                  (element) =>
                      element.configurationTypeCode ==
                      GlobalConfigurationsCode
                          .EVENTS_ALLOW_FETCH_SIGNATURE_IN_EVENTS_FROM_INDUCTION,
                )
                ?.configuration!
                .lable,
            signatureOf: TBTSignatureType.TRAINEE.name,
            value: true,
            typeCode: GlobalConfigurationsCode
                .EVENTS_ALLOW_FETCH_SIGNATURE_IN_EVENTS_FROM_INDUCTION,
          ),
        );
      }
      for (var element in globalConfigurationsList!) {
        if ((element.isActive ?? false) &&
            element.configurationTypeCode ==
                GlobalConfigurationsCode.EVENTS_SIGNED_BY_ATTENDEE) {
          AppData().eventSignatureConfigurations.add(
            SignatureConfigurationUIModel(
              label: element.configuration!.lable,
              signatureOf: TBTSignatureType.ATTENDEES.name,
              value: true,
              typeCode: GlobalConfigurationsCode
                  .TBT_SIGNATURE_BY_INDIVIDUAL_TRAINEE_MAKER,
            ),
          );
        }
      }
    }
  }

  void setSelectedProjectDetails(
    ProjectDetailsUiModel? selectedProject,
    int selectedIndex,
    BuildContext? context,
  ) async {
    setLoading(true);
    resetDashboardCachedData(context: context);
    notifyListeners();
    userSelectedProject = selectedProject;
    selectedProjectIndex = selectedIndex;
    AppData().currentUserSelectedProjectIndex = selectedIndex;
    isSubscriptionExpired = userSelectedProject?.isSubscriptionActive;
    legalEntityName = userSelectedProject?.legalEntityName;
    // selectedProjectIndex = 0;
    if (isSubscriptionExpired!) {
      showSubscriptionEndBanner!.showSubscriptionMaterialBanner();
    } else {
      showSubscriptionEndBanner!.hideSubscriptionMaterialBanner();
    }
    await _sharedPreferencesUtils.setSelectedProjectDetails(selectedProject!);
    getProjectEntitlements(context: context);
    // getGlobalConfigurations();
    // getDashboardPendingCounts();
    notifyListeners();
  }

  void navigateToAddLabour(BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();
      Provider.of<InductionTrainingProvider>(
        context,
        listen: false,
      ).resetProviderData();

      await Provider.of<InductionTrainingProvider>(
        context,
        listen: false,
      ).getInducteeCategories(false);

      // await Provider.of<InductionTrainingProvider>(context, listen: false)
      //     .getAllInductionTrainingData(null);

      UserLocationDetails? userLocationDetails =
          await Provider.of<InductionTrainingProvider>(
            context,
            listen: false,
          ).checkLocationPermission(context: context);
      if (Provider.of<InductionTrainingProvider>(
        context,
        listen: false,
      ).inducteeCategoryList!.isNotEmpty) {
        InductionTrainingFormScreenArgs args = InductionTrainingFormScreenArgs(
          formName: AppStrings().addLabour,
          inducteeCategoriesUiDataModel:
              Provider.of<InductionTrainingProvider>(
                context,
                listen: false,
              ).inducteeCategoryList!.firstWhereOrNull(
                (element) =>
                    element.categoryCode == InducteeCategories.CATEGORY_LABOUR,
              )!,
        );
        if (userLocationDetails != null) {
          Navigator.pushNamed(
            context,
            RouteName.inductionTrainingFormScreen,
            arguments: args,
          );
        }
      } else {
        await Provider.of<InductionTrainingProvider>(
          context,
          listen: false,
        ).getInducteeCategories(false);
        InductionTrainingFormScreenArgs args = InductionTrainingFormScreenArgs(
          formName: AppStrings().addLabour,
          inducteeCategoriesUiDataModel:
              Provider.of<InductionTrainingProvider>(
                context,
                listen: false,
              ).inducteeCategoryList!.firstWhereOrNull(
                (element) =>
                    element.categoryCode == InducteeCategories.CATEGORY_LABOUR,
              )!,
        );
        if (userLocationDetails != null) {
          Navigator.pushNamed(
            context,
            RouteName.inductionTrainingFormScreen,
            arguments: args,
          );
        }
      }
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  void navigateToCreateTBT(BuildContext context) async {
    setLoading(true);
    notifyListeners();

    await Provider.of<ToolboxTrainingProvider>(
      context,
      listen: false,
    ).getTBTRequiredData(true);

    UserLocationDetails? userLocationDetails =
        await Provider.of<ToolboxTrainingProvider>(
          context,
          listen: false,
        ).checkLocationPermission(context: context);

    Provider.of<ToolboxTrainingProvider>(
      context,
      listen: false,
    ).resetProviderData();

    if (userLocationDetails != null) {
      Navigator.of(context).pushNamed(RouteName.toolboxTrainingFormPage);
    }
    setLoading(false);
    notifyListeners();
  }

  void navigateToIncidentReport(BuildContext context) async {
    setLoading(true);
    notifyListeners();
    Provider.of<IncidentReportProvider>(context, listen: false).clearData();

    UserLocationDetails? userLocationDetails =
        await Provider.of<IncidentReportProvider>(
          context,
          listen: false,
        ).checkLocationPermission(context: context);

    CustomCameraAndImagePickerArgs args = CustomCameraAndImagePickerArgs(
      imageCount: 5,
      files: Provider.of<IncidentReportProvider>(
        context,
        listen: false,
      ).incidentPhotos,
    );
    if (userLocationDetails != null) {
      dynamic result = await Navigator.pushNamed(
        context,
        RouteName.newCustomCameraAndImagePicker,
        arguments: args,
      );
      if (result != null) {
        List<File> resultFiles = result as List<File>;
        Provider.of<IncidentReportProvider>(
          context,
          listen: false,
        ).replaceIncidentPhotoList(resultFiles);
        Navigator.pushNamed(context, RouteName.incidentReportFormScreen);
      }
    }
    setLoading(false);
    notifyListeners();
  }

  void navigateToSafetyActionable(BuildContext context) async {
    setLoading(true);
    notifyListeners();

    Provider.of<SafetyObservationProvider>(
      context,
      listen: false,
    ).resetProviderData();

    await Provider.of<SafetyObservationProvider>(
      context,
      listen: false,
    ).getSafetyObservationData();

    UserLocationDetails? userLocationDetails =
        await Provider.of<SafetyObservationProvider>(
          context,
          listen: false,
        ).checkLocationPermission(context: context);

    CustomCameraAndImagePickerArgs args = CustomCameraAndImagePickerArgs(
      imageCount: 5,
      isVideoRecordingRequired: true,
      files: Provider.of<SafetyObservationProvider>(
        context,
        listen: false,
      ).safetyObservationPhotos,
    );
    // await Provider.of<SafetyObservationProvider>(context, listen: false)
    //     .checkLocationPermission(context: context);

    if (userLocationDetails != null) {
      dynamic result = await Navigator.pushNamed(
        context,
        RouteName.newCustomCameraAndImagePicker,
        arguments: args,
      );
      if (result != null) {
        List<File> resultFiles = result as List<File>;
        Provider.of<SafetyObservationProvider>(
          context,
          listen: false,
        ).replaceIncidentPhotoList(resultFiles);
        Navigator.pushNamed(context, RouteName.safetyObservationFormPage);
      }
    }
    setLoading(false);
    notifyListeners();
  }

  void navigateToCreateWorkPermit(BuildContext context) async {
    setLoading(true);
    notifyListeners();

    UserLocationDetails? userLocationDetails =
        await Provider.of<WorkPermitProvider>(
          context,
          listen: false,
        ).checkLocationPermission(context: context);

    Provider.of<WorkPermitProvider>(context, listen: false).resetProviderData();

    // await Provider.of<WorkPermitProvider>(context, listen: false)
    //     .checkLocationPermission(context: context);

    if (userLocationDetails != null) {
      Navigator.of(context).pushNamed(RouteName.workPermitForm);
    }
    setLoading(false);
    notifyListeners();
  }

  getAllOfflineModulesData({
    BuildContext? context,
    String? projectCode,
    String? projectName,
  }) async {
    setLoading(true);
    notifyListeners();
    try {
      if (entitlementPermissionsListDashboard != null &&
          entitlementPermissionsListDashboard!.isNotEmpty) {
        Future.wait<dynamic>([
          Provider.of<ToolboxTrainingProvider>(
            context!,
            listen: false,
          ).getTBTRequiredData(false),
          Provider.of<InductionTrainingProvider>(
            context,
            listen: false,
          ).getAllInductionTrainingData(null),
          Provider.of<InductionTrainingProvider>(
            context,
            listen: false,
          ).getInducteeCategories(false),
          Provider.of<WorkPermitProvider>(
            context,
            listen: false,
          ).getWorkPermitFormsInitialData(null),
          Provider.of<CheckListProvider>(
            context,
            listen: false,
          ).checklistTaskModuleData(),
          Provider.of<SafetyObservationProvider>(
            context,
            listen: false,
          ).getSafetyObservationData(),
        ]).then((List<dynamic> allResults) {
          //CustomLogger.logPrint('all results length ${allResults.length}');
          "Project Offline Sync Completed".showAsToast(
            context: context,
            type: ToastType.TOAST_SUCCESS,
          );
          HiveDashboardService.putOfflineSyncStatusProjectWise(
            projectCode,
            OfflineSyncModel(
              projectName: projectName,
              projectCode: projectCode,
              isOfflineModuleDataSync: true,
              isEntitlementsDataSync: true,
            ),
          );
          checkAllProjectsSyncStatus(isNotify: true);
        });
        await Future.delayed(const Duration(seconds: 10)).whenComplete(() {
          setLoading(false);
          notifyListeners();
        });
      }
    } catch (e) {
      CustomLogger.logPrint('Error in getAllOfflineModulesData: $e');
      setLoading(false);
      notifyListeners();
    }
  }

  checkStoragePermission(BuildContext? context) async {
    AppData().storagePermission = await PermissionUtils()
        .handleStoragePermission(context);
  }

  checkNotificationPermission(BuildContext? context) async {
    AppData().storagePermission = await PermissionUtils()
        .handleNotificationPermission(context);
  }

  checkMicrophonePermission(BuildContext? context) async {
    AppData().microphonePermission = await PermissionUtils()
        .handleMicrophonePermission(context);
  }

  checkForAppUpdate() async {
    try {
      if (Platform.isAndroid &&
          isNetworkConnected &&
          Environment.IS_FORCE_UPDATE_ALLOW == 'YES') {
        await InAppUpdate.checkForUpdate().then((updateInfo) {
          if (updateInfo.updateAvailability ==
              UpdateAvailability.updateAvailable) {
            //Logic to perform an update
            // InAppUpdate.performImmediateUpdate()
            //     .catchError((e) {
            //   if (updateInfo.immediateUpdateAllowed) {
            //     // Perform immediate update
            //     InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            //       if (appUpdateResult == AppUpdateResult.success) {
            //         //App Update successful
            //       }
            //     });
            //   } else if (updateInfo.flexibleUpdateAllowed) {
            //     //Perform flexible update
            //     InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            //       if (appUpdateResult == AppUpdateResult.success) {
            //         //App Update successful
            //         InAppUpdate.completeFlexibleUpdate();
            //       }
            //     });
            //   }
            // });
            if (updateInfo.immediateUpdateAllowed) {
              // Perform immediate update
              InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
                if (appUpdateResult == AppUpdateResult.success) {
                  //await HiveConfigurations.deleteAllBoxes();
                  //await HiveConfigurations.clearAllData();
                  //App Update successful
                } else if (appUpdateResult ==
                    AppUpdateResult.userDeniedUpdate) {
                  checkForAppUpdate();
                }
              });
            } else if (updateInfo.flexibleUpdateAllowed) {
              //Perform flexible update
              InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
                if (appUpdateResult == AppUpdateResult.success) {
                  //App Update successful
                  //await HiveConfigurations.deleteAllBoxes();
                  //await HiveConfigurations.clearAllData();
                  InAppUpdate.completeFlexibleUpdate();
                } else if (appUpdateResult ==
                    AppUpdateResult.userDeniedUpdate) {
                  checkForAppUpdate();
                }
              });
            }
          }
        });
      }
    } catch (e) {
      //CustomLogger.logPrint('App Update Check Failed ${e.toString()}');
    }
  }

  String getUserAssignedProjectsString(List<ProjectDetailsUiModel>? projects) {
    List<ProjectDetailsUiModel>? activeProjectsList = projects!
        .where((element) => element.isActive!)
        .toList();

    activeProjectsList.sort((a, b) => a.projectName!.compareTo(b.projectName!));
    String assignedProjects;
    StringBuffer buffer = StringBuffer();
    if (activeProjectsList.length == 1) {
      return projects.first.projectName!;
    } else {
      for (var element in activeProjectsList) {
        if (element.projectName != null && element.projectName!.isNotEmpty) {
          buffer.write(
            '${element.projectName!.toString().toBeginningOfSentence()},',
          );
        }
      }
    }
    assignedProjects = buffer.toString();
    return assignedProjects;
  }

  resetDashboardCachedData({required BuildContext? context}) {
    entitlementPermissionsListDashboard = [];
    entitlementPermissionsListQuickActions = [];
    dashboardCarouselPendingCounts = [];
    globalConfigurationsList = [];
    //projectUiModel!.projects=[];

    //Reset Other Modules Data
    Provider.of<ToolboxTrainingProvider>(
      context!,
      listen: false,
    ).resetCachedTBTData();

    Provider.of<InductionTrainingProvider>(
      context,
      listen: false,
    ).resetInductionTrainingCachedData();

    Provider.of<WorkPermitProvider>(
      context,
      listen: false,
    ).resetWorkPermitCachedData();

    Provider.of<CheckListProvider>(
      context,
      listen: false,
    ).resetCheckListCachedData();
  }

  setOfflineUsageDialog() async {
    setLoading(true);
    notifyListeners();
    await _sharedPreferencesUtils.setOfflineUsageDialog(true);
    setLoading(false);
    notifyListeners();
  }
}
