import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/base/base_state_class.dart';
import 'package:premises/features/user_management/user_management.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseStateClass<DashboardScreen>
    implements ShowSubscriptionEndBanner {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DashboardProvider _dashboardProvider;

  late PageController _pageController;

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _dashboardProvider.setSubscription(this);
    //_dashboardProvider.checkDateSync(context);
    _dashboardProvider.checkForAppUpdate();
    _dashboardProvider.checkLocationPermission();
    _dashboardProvider.checkStoragePermission(context);
    _dashboardProvider.checkNotificationPermission(context);
    _dashboardProvider.checkMicrophonePermission(context);
    // if (_dashboardProvider.entitlementPermissionsListDashboard!.isEmpty) {
    _dashboardProvider.getUserAssignedProjects(
        context: context,
        userSelectedProjectIndex: AppData().currentUserSelectedProjectIndex);
    //}

    if (AppData().isOfflineUsageDialogShow != null &&
        !AppData().isOfflineUsageDialogShow!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAppUsageOfflineMode(context);
      });
    }
  }

  Future<Null> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    _dashboardProvider.resetDashboardCachedData(context: context);
    _dashboardProvider.getUserAssignedProjects(
        context: context,
        userSelectedProjectIndex: _dashboardProvider.selectedProjectIndex);

    _dashboardProvider.checkForAppUpdate();
    //_dashboardProvider.checkLocationPermission();
    //_dashboardProvider.checkStoragePermission(context);
    //_dashboardProvider.checkNotificationPermission(context);
  }

  Widget _buildScreenWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !context.watch<DashboardProvider>().showError
                ? Expanded(
                    child: AppRefreshIndicator(
                      onRefresh: refreshData,
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      backgroundColor: AppColors.progressBarBackground,
                      color: AppColors.progressBarForeground,
                      child: context
                                      .watch<DashboardProvider>()
                                      .isSubscriptionExpired !=
                                  null &&
                              context
                                  .watch<DashboardProvider>()
                                  .isSubscriptionExpired!
                          ? ColorFiltered(
                              //black
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.saturation,
                              ),
                              //opacity: context.watch<DashboardProvider>().isSubscriptionActive! ? 1.0:0.3,
                              child: _screenContent(),
                            )
                          : _screenContent(),
                    ),
                  )
                : Expanded(
                    child: AppRefreshIndicator(
                        onRefresh: refreshData,
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        backgroundColor: AppColors.progressBarBackground,
                        color: AppColors.progressBarForeground,
                        child: _buildError(
                            context.read<DashboardProvider>().errorMessage))),
          ],
        ),
        _progressBar(context),
      ],
    );
  }

  Widget _screenContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: IgnorePointer(
        ignoring:
            context.watch<DashboardProvider>().isSubscriptionExpired != null &&
                context.watch<DashboardProvider>().isSubscriptionExpired!,
        child: Column(
          children: [
            Spacing().largeMediumVertical,
            context.watch<DashboardProvider>().dashboardCarouselPendingCounts !=
                        null &&
                    context
                        .watch<DashboardProvider>()
                        .dashboardCarouselPendingCounts!
                        .isNotEmpty
                ? _buildPendingTasks()
                : Container(),
            Spacing().mediumVertical,
            context.watch<DashboardProvider>().entitlementUiModel!.success! &&
                    context
                        .watch<DashboardProvider>()
                        .entitlementPermissionsListDashboard!
                        .isNotEmpty
                ? _buildModules()
                : Container(),
            Spacing().mediumVertical,
            context.watch<DashboardProvider>().entitlementUiModel!.success! &&
                    context
                        .watch<DashboardProvider>()
                        .entitlementPermissionsListQuickActions!
                        .isNotEmpty
                ? _buildQuickActions()
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.xsmallGreyG1Regular(
          AppStrings().pending_task,
          isUpperCase: true,
        ),
        Spacing().smallVertical,
        context.watch<DashboardProvider>().dashboardCarouselPendingCounts !=
                    null &&
                context
                    .watch<DashboardProvider>()
                    .dashboardCarouselPendingCounts!
                    .isNotEmpty
            ? Skeletonizer(
                enabled: context.watch<DashboardProvider>().isLoading!,
                enableSwitchAnimation: true,
                child: _buildPageView())
            : Container(),
        indicators(3, 1),
      ],
    );
  }

  Widget _buildModules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.xsmallGreyG1Regular(
          AppStrings().modules,
          isUpperCase: true,
        ),
        Spacing().smallVertical,
        Skeletonizer(
          enabled: context.watch<DashboardProvider>().isLoading!,
          enableSwitchAnimation: true,
          child: DashboardMenuWidget(
            mainContext: context,
            roleCode: context
                .watch<DashboardProvider>()
                .userSelectedProject
                ?.roleCode,
            entitlementPermissionsList: context
                .watch<DashboardProvider>()
                .entitlementPermissionsListDashboard!,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.xsmallGreyG1Regular(
          AppStrings().quick_actions,
          isUpperCase: true,
        ),
        Spacing().smallVertical,
        Skeletonizer(
          enabled: context.watch<DashboardProvider>().isLoading!,
          enableSwitchAnimation: true,
          child: QuickActionsMenuWidget(
            mainContext: context,
            roleCode: context
                .watch<DashboardProvider>()
                .userSelectedProject
                ?.roleCode,
            entitlementPermissionsList: context
                .watch<DashboardProvider>()
                .entitlementPermissionsListQuickActions!,
          ),
        ),
      ],
    );
  }

  Widget _buildPageView() {
    List<List<DashboardCarouselPendingCountsUIModel>>? pendingTasksList = [];
    int chunkSize = 3;
    for (var i = 0;
        i < _dashboardProvider.dashboardCarouselPendingCounts!.length;
        i += chunkSize) {
      pendingTasksList.add(_dashboardProvider.dashboardCarouselPendingCounts!
          .sublist(
              i,
              i + chunkSize >
                      _dashboardProvider.dashboardCarouselPendingCounts!.length
                  ? _dashboardProvider.dashboardCarouselPendingCounts!.length
                  : i + chunkSize));
    }

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: PageView.builder(
          itemCount: pendingTasksList.length,
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              activePage = page;
            });
          },
          itemBuilder: (context, pagePosition) {
            return PendingTaskWidget(
                pendingTasksList: pendingTasksList[pagePosition],
                actionCountChecklist: AppStrings().dash,
                actionCountSafetyObervations: AppStrings().dash,
                actionCountWorkPermits: AppStrings().dash,
                entitlementPermissionsListQuickActions:
                    _dashboardProvider.entitlementPermissionsListQuickActions,
                entitlementPermissionsListDashboard:
                    _dashboardProvider.entitlementPermissionsListDashboard);
          }),
    );
  }

  Widget indicators(imagesLength, currentIndex) {
    List<List<DashboardCarouselPendingCountsUIModel>>? pendingTasksList = [];
    // var chunks = [];
    int chunkSize = 3;

    for (var i = 0;
        i < _dashboardProvider.dashboardCarouselPendingCounts!.length;
        i += chunkSize) {
      pendingTasksList.add(_dashboardProvider.dashboardCarouselPendingCounts!
          .sublist(
              i,
              i + chunkSize >
                      _dashboardProvider.dashboardCarouselPendingCounts!.length
                  ? _dashboardProvider.dashboardCarouselPendingCounts!.length
                  : i + chunkSize));
    }

    return pendingTasksList.length > 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(pendingTasksList.length, (index) {
              return Container(
                margin: const EdgeInsets.all(3),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: activePage == index ? Colors.black : Colors.black26,
                    shape: BoxShape.circle),
              );
            }))
        : Container();
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.watch<DashboardProvider>().isLoading,
    );
  }

  Widget _buildError(String? errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppData().userDetailsUiModel != null
            ? CommonErrorWidget(
                errorMessage: errorMessage ??
                    'Hi, ${'${AppData().userDetailsUiModel!.firstName.toString().toBeginningOfSentence()} ${AppData().userDetailsUiModel!.lastName.toString().toBeginningOfSentence()}'} '
                        '\n ${AppStrings().error_not_assigned_project} ${AppData().userCurrentSelectedProject != null ? AppStrings().for_project + AppData().userCurrentSelectedProject!.projectName! : ''}',
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithAppbar(
        context: context,
        scaffoldKey: _scaffoldKey,
        appbarWidget: CustomDashboardAppBar(
          isDialogVisibled: false,
          scaffoldKey: _scaffoldKey,
        ),
        buildScreenColor: AppColors.app_background_color_secondary,
        endDrawerWidget: ProfileDrawerWidget(
          showSubscriptionEndBanner: this,
          scaffoldKey: _scaffoldKey,
        ),
        screenWidget: _buildScreenWidget(context));
  }

  @override
  void connectivityChanged(bool isDeviceConnected, String? source) {
    if (!isDeviceConnected) {
      if (mounted) {
        CustomMaterialBanner.showNoInternetConnectionBanner(context: context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        //_dashboardProvider.checkDateSync(context)
      }
    }
  }

  @override
  void isConnectedToLowNetwork(bool isLowNetwork) {
    if (isLowNetwork) {
      CustomMaterialBanner.showLowInternetConnectionBanner(context: context);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
      }
    }
  }

  @override
  void hideSubscriptionMaterialBanner() {
    if (mounted) {
      ScaffoldMessenger.of(context).clearMaterialBanners();
    }
  }

  @override
  void showSubscriptionMaterialBanner() {
    CustomMaterialBanner.showMaterialBannerSubscriptionExpiry(
        context: context,
        message: AppData().userCurrentSelectedProject?.roleCode ==
                FreemiumUserRoles.MOBILE_USER
            ? AppStrings().subscription_ended_error_non_admin
            : AppStrings().subscription_ended_error);
  }

  void _showAppUsageOfflineMode(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return OfflineSyncDialog(
          onSyncButtonPressed: () {
            Navigator.of(dialogContext).pop();
            _dashboardProvider.setOfflineUsageDialog();
          },
          onCloseButtonPressed: () {
            Navigator.of(dialogContext).pop();
            _dashboardProvider.setOfflineUsageDialog();
          },
        );
      },
    );
  }
}
