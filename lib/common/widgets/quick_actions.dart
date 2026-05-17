import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/features/dashboard/provider.dart';
import 'package:premises/features/offline_sync/offline_sync.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class QuickActionsMenuWidget extends StatelessWidget {
  final BuildContext mainContext;
  final String? roleCode;
  final List<EntitlementPermissionsUiModel>? entitlementPermissionsList;

  const QuickActionsMenuWidget({
    super.key,
    bool? isNetworkConnected,
    required this.mainContext,
    required this.roleCode,
    required this.entitlementPermissionsList,
  });

  @override
  Widget build(BuildContext context) {
    return entitlementPermissionsList != null &&
            entitlementPermissionsList!.isNotEmpty
        ? _buildQuickActionsGridView(mainContext)
        : Container();
  }

  Widget _buildQuickActionsGridView(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: entitlementPermissionsList!.length,
      itemBuilder: (BuildContext itemContext, int index) {
        if (entitlementPermissionsList != null &&
            entitlementPermissionsList!.length > index) {
          EntitlementPermissionsUiModel dashboardMenuModel =
              entitlementPermissionsList![index];
          return InkWell(
            onTap: () {
              if (context
                      .read<DashboardProvider>()
                      .userSelectedProject!
                      .isActive! &&
                  dashboardMenuModel.isVisible!) {
                _menuNavigation(
                  dashboardMenuModel.id!,
                  context,
                  dashboardMenuModel,
                );
              } else {
                if ((roleCode != FreemiumUserRoles.MOBILE_ADMIN &&
                    roleCode != FreemiumUserRoles.MOBILE_USER)) {
                  AppStrings().deacitivate_project.showAsToast(
                    context: context,
                    type: ToastType.TOAST_ERROR,
                  );
                } else {
                  MixpanelService().disableModuleClickEvent(
                    moduleName: dashboardMenuModel.menuLable!,
                  );
                  _showContactSupportDialog(context);
                }
              }
            },
            child: _buildQuickActions(
              menuLable: dashboardMenuModel.menuLable!,
              menuIcon: dashboardMenuModel.menuIcon!,
              isVisible: dashboardMenuModel.isVisible,
              isWorkOffline: dashboardMenuModel.isWorkInOffline,
              context: context,
            ),
          );
        } else {
          return Container();
        }
      },
      //staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 0.83),
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
    );
  }

  Widget _buildQuickActions({
    required String menuIcon,
    required String menuLable,
    required bool? isWorkOffline,
    required bool? isVisible,
    required BuildContext context,
  }) {
    return Opacity(
      opacity:
          ((roleCode == FreemiumUserRoles.MOBILE_ADMIN ||
                      roleCode == FreemiumUserRoles.MOBILE_USER) &&
                  !isVisible!) ||
              (!isWorkOffline! &&
                  !context.watch<DashboardProvider>().isNetworkConnected)
          ? 0.2
          : 1.0,
      child: AppIconWithText(
        icon: menuIcon,
        iconText: menuLable,
        iconHeight: IconSize().large,
        iconWidth: IconSize().large,
        isBackgroundColorAvailable: true,
        iconTextSpacing: Spacing().smallVertical,
      ),
    );
  }

  _menuNavigation(
    int menuId,
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    switch (menuId) {
      case 1:
        return _navigateToCreateWorkPermit(context, dashboardMenuModel);

      case 2:
        return _navigateToAcceptedWorkPermit(context, dashboardMenuModel!);

      case 3:
        return _navigateToLabour(context, dashboardMenuModel);

      case 4:
        return _navigateToSafetyActionable(context, dashboardMenuModel);

      case 5:
        return _navigateToIncidentReport(context, dashboardMenuModel);

      case 6:
        return _navigateToSyncOffline(context, dashboardMenuModel);

      case 7:
        return _navigateToCreateToolboxTrainingScreen(
          context,
          dashboardMenuModel,
        );

      case 8:
        return _navigateToScanQR(context, dashboardMenuModel);

      case 9:
        return _navigateToProjectLabors(context, dashboardMenuModel);

      case 10:
        return _navigateToProjectDashoboard(context, dashboardMenuModel);

      case 11:
        return _navigateToWorkForceReport(context, dashboardMenuModel);

      case 12:
        return _navigateToVisitorScan(context, dashboardMenuModel);

      case 13:
        return _navigateToFaceScan(context, dashboardMenuModel);
    }
  }

  _navigateToCreateWorkPermit(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) async {
    AppData().inductionTrainingEntitlements = dashboardMenuModel;
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).navigateToCreateWorkPermit(context);
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced) {
        Provider.of<DashboardProvider>(
          context,
          listen: false,
        ).navigateToCreateWorkPermit(context);
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToAcceptedWorkPermit(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiModel,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      WorkPermitScreenArgs args = WorkPermitScreenArgs(
        entitlementPermissionsUiModel: entitlementPermissionsUiModel,
        showAcceptedOnly: true,
      );
      Navigator.pushNamed(
        context,
        RouteName.workPermitListScreen,
        arguments: args,
      );
    }
  }

  _navigateToLabour(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) async {
    AppData().inductionTrainingEntitlements = dashboardMenuModel;
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).navigateToAddLabour(context);
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced) {
        Provider.of<DashboardProvider>(
          context,
          listen: false,
        ).navigateToAddLabour(context);
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToIncidentReport(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      IncidentReportScreenArguments? incidentReportScreenArguments =
          IncidentReportScreenArguments(
            entitlementPermissionsUiModel: dashboardMenuModel,
            isFromMe: true,
          );
      if (context.read<DashboardProvider>().isNetworkConnected) {
        Provider.of<DashboardProvider>(
          context,
          listen: false,
        ).navigateToIncidentReport(context);
      }
      // Provider.of<DashboardProvider>(context, listen: false)
      //     .navigateToIncidentReport(context);
    }
  }

  _navigateToSafetyActionable(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) async {
    //AppData().safetyActionableEntitlements = dashboardMenuModel;
    SafetyScreenArgs args = SafetyScreenArgs(
      entitlementPermissionsUiModel: dashboardMenuModel,
    );
    AppData().safetyActionableEntitlements = args;

    if (context.read<DashboardProvider>().isNetworkConnected) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).navigateToSafetyActionable(context);
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced) {
        Provider.of<DashboardProvider>(
          context,
          listen: false,
        ).navigateToSafetyActionable(context);
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToSyncOffline(
    context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    Navigator.pushNamed(
      context,
      RouteName.offlineSyncScreen,
      arguments: OfflineSyncScreenArguments(
        customOfflineSyncModule: dashboardMenuModel!.customOfflineSyncModule,
        title: null,
      ),
    );
  }

  _navigateToCreateToolboxTrainingScreen(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) async {
    AppData().tbtEntitlemnets = dashboardMenuModel;
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).navigateToCreateTBT(context);
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced) {
        Provider.of<DashboardProvider>(
          context,
          listen: false,
        ).navigateToCreateTBT(context);
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToScanQR(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) async {
    AppData().scanQRCodeEntitlements = dashboardMenuModel;
    WorkForceArgs args = WorkForceArgs(
      entitlementPermissionsUiModel: dashboardMenuModel,
      showWorkForce: false,
    );
    if (context.read<DashboardProvider>().isNetworkConnected) {
      bool? isInGeofencingArea = await context
          .read<DashboardProvider>()
          .checkIsInGeofencingArea(context, 'Scan ID QR');
      if (isInGeofencingArea) {
        Navigator.pushNamed(
          context,
          RouteName.qrcodeListScreen,
          arguments: args,
        );
      }
    } else {
      Navigator.pushNamed(context, RouteName.qrcodeListScreen, arguments: args);
    }
  }

  _navigateToProjectLabors(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      AppData().projectLaborsEntitlements = dashboardMenuModel;
      Navigator.pushNamed(
        context,
        RouteName.activeProjectLaborsScreen,
        arguments: dashboardMenuModel,
      );
    }
  }

  _navigateToProjectDashoboard(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      AppData().mobileDashboardEntitlements = dashboardMenuModel;

      Navigator.pushNamed(
        context,
        RouteName.importDashboardScreen,
        arguments: dashboardMenuModel,
      );
    }
  }

  _navigateToWorkForceReport(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    AppData().scanQRCodeEntitlements = dashboardMenuModel;
    WorkForceArgs args = WorkForceArgs(
      entitlementPermissionsUiModel: dashboardMenuModel,
      showWorkForce: true,
    );
    Navigator.pushNamed(context, RouteName.qrcodeListScreen, arguments: args);
    // Navigator.pushNamed(context, RouteName.QrcodeListScreen,
    //     arguments: dashboardMenuModel);
  }

  _navigateToVisitorScan(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      AppData().visitorScanEntitlements = dashboardMenuModel;
      Navigator.pushNamed(context, RouteName.visitorPassListScreen);
    }
  }

  _navigateToFaceScan(
    BuildContext context,
    EntitlementPermissionsUiModel? dashboardMenuModel,
  ) async {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      AppData().visitorScanEntitlements = dashboardMenuModel;
      bool? isInGeofencingArea = await context
          .read<DashboardProvider>()
          .checkIsInGeofencingArea(context, 'Face Scan');
      if (isInGeofencingArea) {
        Navigator.pushNamed(context, RouteName.faceScanDetails);
      }
    }
  }

  _showContactSupportDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return FreemiumAlertDialog(
          showSupportContent: true,
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
          onPressedClosedIcon: () {
            Navigator.of(dialogContext).pop();
          },
          dialogButtonName: AppStrings().ok,
          dialogMessage: AppStrings().unlockFeatures,
          dialogTitle: AppStrings().support.toUpperCase(),
        );
      },
    );
  }

  _checkProjectSyncStatus(BuildContext context) async {
    DashboardProvider dashboardProvider = Provider.of<DashboardProvider>(
      context,
      listen: false,
    );
    bool? syncStatus =
        await dashboardProvider.checkProjectOfflineModuleDataIsSyncOrNot(
          dashboardProvider.userSelectedProject,
        ) ??
        false;
    return syncStatus;
  }

  _showProjectNotSyncDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(context).pop();
          },
          dialogButtonName: AppStrings().close.toUpperCase(),
          dialogMessage: AppStrings().project_data_not_sync,
          dialogTitle: AppStrings().project_not_sync_title,
        );
      },
    );
  }
}

class QuickActionsShimmerMenuWidget extends StatelessWidget {
  const QuickActionsShimmerMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildQuickActionsGridView();
  }

  Widget _buildQuickActionsGridView() {
    return AlignedGridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 12,
      itemBuilder: (context, index) => Column(
        children: [
          Container(
            width: 48,
            height: 48,
            clipBehavior: Clip.antiAlias,
            margin: MarginPadding().smallAll,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            //padding: MarginPadding().smallTop,
            //clipBehavior: Clip.antiAlias,
            width: 70,
            height: 10,
          ),
        ],
      ),
      //staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 0.83),
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
    );
  }
}
