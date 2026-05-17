import '../models/models.dart';
import '../resources/resources.dart';
import 'package:premises/main_imports.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/widgets/contact_support_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardMenuWidget extends StatelessWidget {
  final BuildContext mainContext;
  final String? roleCode;
  final List<EntitlementPermissionsUiModel>? entitlementPermissionsList;

  const DashboardMenuWidget({
    super.key,
    required this.roleCode,
    bool? isNetworkConnected,
    required this.mainContext,
    required this.entitlementPermissionsList,
  });

  @override
  Widget build(BuildContext context) {
    return entitlementPermissionsList != null &&
            entitlementPermissionsList!.isNotEmpty
        ? _buildModulesGridView(context)
        : Container();
  }

  Widget _buildModulesGridView(BuildContext context) {
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

          //This is to intialize the work permit entitlement
          if (dashboardMenuModel.id == 1) {
            AppData().workPermitEntitlements =
                entitlementPermissionsList![index];
          }
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
            child: Visibility(
              visible:
                  dashboardMenuModel.isVisible! ||
                  (roleCode == FreemiumUserRoles.MOBILE_ADMIN ||
                      roleCode == FreemiumUserRoles.MOBILE_USER),
              child: _buildMenuCard(
                menuLable: dashboardMenuModel.menuLable!,
                isVisible: dashboardMenuModel.isVisible,
                menuIcon: dashboardMenuModel.menuIcon!,
                isWorkOffline: dashboardMenuModel.isWorkInOffline,
                context: context,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
      //staggeredTileBuilder: (int index) => new StairedGridTile(1, 1.25),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget _buildMenuCard({
    required String menuIcon,
    required String menuLable,
    required BuildContext context,
    required bool? isWorkOffline,
    required bool? isVisible,
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
      child: Card(
        elevation:
            ((roleCode == FreemiumUserRoles.MOBILE_ADMIN ||
                        roleCode == FreemiumUserRoles.MOBILE_USER) &&
                    !isVisible!) ||
                (!isWorkOffline! &&
                    !context.watch<DashboardProvider>().isNetworkConnected)
            ? 1.0
            : AppSizes().defaultMenuCardElevations,
        shadowColor: AppColors.color_primary.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes().dashboardTilesRoundCorners,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIconWithText(
              icon: menuIcon,
              iconText: menuLable,
              iconHeight: IconSize().xxxlarge,
              iconWidth: IconSize().xxxlarge,
              iconTextSpacing: Spacing().smallVertical,
            ),
          ],
        ),
      ),
    );
  }

  _menuNavigation(
    int menuId,
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiModel,
  ) {
    switch (menuId) {
      case 1:
        return _navigateToWorkPermit(context, entitlementPermissionsUiModel);

      case 2:
        return _navigateToToolboxTraining(
          context,
          entitlementPermissionsUiModel,
        );

      case 3:
        return _navigateToChecklist(context, entitlementPermissionsUiModel);

      case 4:
        return _navigateToSafetyObservation(
          context,
          entitlementPermissionsUiModel,
        );

      case 5:
        return _navigateToIncidentReport(
          context,
          entitlementPermissionsUiModel,
        );

      case 6:
        return _navigateToInductionTraining(
          context,
          entitlementPermissionsUiModel,
        );
      case 7:
        return _navigateToViolationNotice(
          context,
          entitlementPermissionsUiModel,
        );

      case 8:
        return _navigateToTask(context, entitlementPermissionsUiModel);

      case 9:
        return _navigateToManageUser(context, entitlementPermissionsUiModel);

      case 10:
        return _navigateToManageProject(context, entitlementPermissionsUiModel);

      case 11:
        return _navigateToProjectScoring(
          context,
          entitlementPermissionsUiModel,
        );

      case 12:
        return _navigateToProjectScoring(
          context,
          entitlementPermissionsUiModel,
        );
      case 13:
        return _navigateToProjectScoring(
          context,
          entitlementPermissionsUiModel,
        );
      case 14:
        return _navigateToProjectScoring(
          context,
          entitlementPermissionsUiModel,
        );
      case 15:
        return _navigateToProjectScoring(
          context,
          entitlementPermissionsUiModel,
        );
      case 16:
        return _navigateToOHSDocuments(context, entitlementPermissionsUiModel);
    }
  }

  _navigateToWorkPermit(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiModel,
  ) async {
    WorkPermitScreenArgs args = WorkPermitScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiModel,
    );
    if (context.read<DashboardProvider>().isNetworkConnected &&
        entitlementPermissionsUiModel.isWorkInOffline!) {
      Navigator.pushNamed(
        context,
        RouteName.workPermitListScreen,
        arguments: args,
      );
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced &&
          entitlementPermissionsUiModel.isWorkInOffline!) {
        Navigator.pushNamed(
          context,
          RouteName.workPermitListScreen,
          arguments: args,
        );
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToToolboxTraining(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) async {
    TBTScreenArgs args = TBTScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiMode,
      selectedIndex: 0,
    );
    if (context.read<DashboardProvider>().isNetworkConnected &&
        entitlementPermissionsUiMode.isWorkInOffline!) {
      Provider.of<ToolboxTrainingProvider>(
        context,
        listen: false,
      ).mainTabIndex = 0;
      Navigator.pushNamed(
        context,
        RouteName.eventsAndTrainingsScreen,
        arguments: args,
      );
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced &&
          entitlementPermissionsUiMode.isWorkInOffline!) {
        Provider.of<ToolboxTrainingProvider>(
          context,
          listen: false,
        ).mainTabIndex = 0;
        Navigator.pushNamed(
          context,
          RouteName.eventsAndTrainingsScreen,
          arguments: args,
        );
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToInductionTraining(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) async {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Navigator.pushNamed(
        context,
        RouteName.inductionTrainingListScreen,
        arguments: entitlementPermissionsUiMode,
      );
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced &&
          entitlementPermissionsUiMode.isWorkInOffline!) {
        Navigator.pushNamed(
          context,
          RouteName.inductionTrainingListScreen,
          arguments: entitlementPermissionsUiMode,
        );
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToChecklist(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) async {
    ChecklistScreenArgs args = ChecklistScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiMode,
    );
    if (context.read<DashboardProvider>().isNetworkConnected &&
        entitlementPermissionsUiMode.isWorkInOffline!) {
      Navigator.pushNamed(context, RouteName.checkListScreen, arguments: args);
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced &&
          entitlementPermissionsUiMode.isWorkInOffline!) {
        Navigator.pushNamed(
          context,
          RouteName.checkListScreen,
          arguments: args,
        );
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToProjectScoring(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) async {
    ChecklistScreenArgs args = ChecklistScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiMode,
    );
    if (context.read<DashboardProvider>().isNetworkConnected &&
        entitlementPermissionsUiMode.isWorkInOffline!) {
      Navigator.pushNamed(context, RouteName.checkListScreen, arguments: args);
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced &&
          entitlementPermissionsUiMode.isWorkInOffline!) {
        Navigator.pushNamed(
          context,
          RouteName.checkListScreen,
          arguments: args,
        );
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToOHSDocuments(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiModel,
  ) async {
    Navigator.pushNamed(context, RouteName.ohsDocumentScreen);
  }

  _navigateToSafetyObservation(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) async {
    SafetyScreenArgs args = SafetyScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiMode,
    );
    if (context.read<DashboardProvider>().isNetworkConnected &&
        entitlementPermissionsUiMode.isWorkInOffline!) {
      if (context.read<DashboardProvider>().isNetworkConnected) {
        Navigator.pushNamed(
          context,
          RouteName.safetyObservationListScreen,
          arguments: args,
        );
      }
    } else {
      bool isProjectSynced = await _checkProjectSyncStatus(context);
      if (!context.read<DashboardProvider>().isNetworkConnected &&
          isProjectSynced &&
          entitlementPermissionsUiMode.isWorkInOffline!) {
        Navigator.pushNamed(
          context,
          RouteName.safetyObservationListScreen,
          arguments: args,
        );
      } else {
        _showProjectNotSyncDialog(context);
      }
    }
  }

  _navigateToIncidentReport(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) {
    IncidentReportScreenArguments? incidentReportScreenArguments =
        IncidentReportScreenArguments(
          entitlementPermissionsUiModel: entitlementPermissionsUiMode,
          isFromMe: false,
        );
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Navigator.pushNamed(
        context,
        RouteName.incidentReportListScreen,
        arguments: incidentReportScreenArguments,
      );
    }
  }

  _navigateToViolationNotice(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) {
    ViolationScreenArgs args = ViolationScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiMode,
    );
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Navigator.pushNamed(
        context,
        RouteName.violationNoticeListScreen,
        arguments: args,
      );
    }
  }

  _navigateToTask(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiModel,
  ) {
    TaskScreenArgs args = TaskScreenArgs(
      entitlementPermissionsUiModel: entitlementPermissionsUiModel,
    );

    if (context.read<DashboardProvider>().isNetworkConnected ||
        entitlementPermissionsUiModel.isWorkInOffline!) {
      Navigator.pushNamed(context, RouteName.taskListScreen, arguments: args);
    }
  }

  _navigateToManageUser(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Navigator.pushNamed(context, RouteName.usersListScreenPage);
    }
  }

  _navigateToManageProject(
    BuildContext context,
    EntitlementPermissionsUiModel entitlementPermissionsUiMode,
  ) {
    if (context.read<DashboardProvider>().isNetworkConnected) {
      Navigator.pushNamed(
        context,
        RouteName.freemiumProjectListScreen,
        arguments: FreemiumProjectListScreenArguments(
          source: RouteName.dashboardScreen,
        ),
      );
    }
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
}
