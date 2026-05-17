import 'package:flutter/material.dart';
import 'package:safety_app/ui/offline_sync/offline_sync.dart';

import '../../../common/custom_widgets/custom_widgets.dart';
import '../../../common/resources/resources.dart';
import '../../application/app_router.dart';
import '../../common/common_models/common_models.dart';
import '../../common/utils/utils.dart';
import '../check_list/check_list_screen.dart';
import '../events_and_trainings/toolbox_trainings/tab_toolbox_training_list_reviewer.dart';
import '../safety_actionable/safety_actionable_list_screen.dart';
import '../violation_notice/violation_notice_list_screen.dart';
import '../work_permit/work_permit_screen.dart';

Future pendingTasksBottomSheet(BuildContext context,
    {
    // required PendingCountsUIModel pendingCounts,
    required List<PendingCountsModelList>? pendingCountsModelList,
    String? lable,
    List<EntitlementPermissionsUiModel>? entitlementPermissionsListDashboard,
    List<EntitlementPermissionsUiModel>?
        entitlementPermissionQuickActionList}) {
  return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes().bottomSheetCornerRadius)),
      ),
      context: context,
      builder: (context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DraggableScrollableSheet(
                    expand: false,
                    minChildSize: 0.2,
                    maxChildSize: 0.9,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Spacing().xsmallVertical,
                          Padding(
                            padding: MarginPadding().smallLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText.smallBrandSecondaryBold(
                                    '$lable Pending Actions'),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                          Spacing().xsmallVertical,
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: pendingCountsModelList![0]
                                  .pendingCounts!
                                  .length, //replace with array
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    _navigationToScreen(context,
                                        pendingCountsModelList:
                                            pendingCountsModelList,
                                        lable: lable,
                                        entitlementPermissionsListQuickActions:
                                            entitlementPermissionQuickActionList,
                                        title: pendingCountsModelList[0]
                                            .pendingCounts![index]
                                            .title,
                                        entitlementPermissionsListDashboard:
                                            entitlementPermissionsListDashboard);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          // flex: 6,
                                          child: AppText.smallGreyRegular(
                                              pendingCountsModelList[0]
                                                  .pendingCounts![index]
                                                  .title),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          // width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            // border: ,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: AppColors.color_primary,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 6, 10, 6),
                                            child: AppText.xsmallWhiteRegular(
                                                pendingCountsModelList[0]
                                                    .pendingCounts![index]
                                                    .pendingCount
                                                    .toString(),
                                                isCenter: true),
                                          ),
                                        ),
                                        AppIcon(
                                          icon: AppIcons().ic_arrow_forward,
                                          type: IconAssetType.SVG_ICON,
                                          iconHeight: IconSize().xmedium,
                                          iconWidth: IconSize().xmedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    });
              },
            ));
      });
}

_navigationToScreen(BuildContext context,
    {
    // required PendingCountsUIModel pendingCounts,
    required List<PendingCountsModelList>? pendingCountsModelList,
    String? lable,
    String? title,
    List<EntitlementPermissionsUiModel>? entitlementPermissionsListDashboard,
    List<EntitlementPermissionsUiModel>?
        entitlementPermissionsListQuickActions}) {
  if (lable == 'TBT') {
    EntitlementPermissionsUiModel entitlementPermissionsUiModel =
        entitlementPermissionsListDashboard!
            .firstWhere((element) => element.moduleCode == 'TBT');
    if (title == 'Reviewer') {
      TBTScreenArgs args = TBTScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          title: title);
      Navigator.pushNamed(context, RouteName.eventsAndTrainingsScreen,
          arguments: args);
    }
  }
  if (lable == 'Work Permit') {
    EntitlementPermissionsUiModel entitlementPermissionsUiModel =
        entitlementPermissionsListDashboard!
            .firstWhere((element) => element.moduleName == 'Work Permit');
    if (title == 'Maker') {
      //  if (context.read<DashboardProvider>().isNetworkConnected) {
      WorkPermitScreenArgs args = WorkPermitScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.workPermitListScreen,
          arguments: args);
      // }
    }
    if (title == 'Checker') {
      WorkPermitScreenArgs args = WorkPermitScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.workPermitListScreen,
          arguments: args);
    }
    if (title == 'Auditor') {
      WorkPermitScreenArgs args = WorkPermitScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.workPermitListScreen,
          arguments: args);
    }
  }
  if (lable == 'Checklist') {
    EntitlementPermissionsUiModel entitlementPermissionsUiModel =
        entitlementPermissionsListDashboard!
            .firstWhere((element) => element.moduleName == 'Checklist');
    if (title == 'My Checklist') {
      ChecklistScreenArgs args = ChecklistScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.checkListScreen, arguments: args);
      //  Navigator.pushNamed(context, RouteName.checkListScreen,
      //   );
    }
    if (title == 'Reviewer') {
      ChecklistScreenArgs args = ChecklistScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.checkListScreen, arguments: args);
    }
  }
  if (lable == 'Safety Observation') {
    EntitlementPermissionsUiModel entitlementPermissionsUiModel =
        entitlementPermissionsListDashboard!.firstWhere(
            (element) => element.moduleName == 'Safety Observation');
    if (title == 'By me') {
      SafetyScreenArgs args = SafetyScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.safetyObservationListScreen,
          arguments: args);
    }
    if (title == 'For me') {
      SafetyScreenArgs args = SafetyScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.safetyObservationListScreen,
          arguments: args);
    }
  }
  if (lable == 'Violation Notice') {
    EntitlementPermissionsUiModel entitlementPermissionsUiModel =
        entitlementPermissionsListDashboard!
            .firstWhere((element) => element.moduleCode == 'VNDN');
    if (title == 'For me') {
      ViolationScreenArgs args = ViolationScreenArgs(
          entitlementPermissionsUiModel: entitlementPermissionsUiModel,
          showAcceptedOnly: false,
          title: title);
      Navigator.pushNamed(context, RouteName.violationNoticeListScreen,
          arguments: args);
    }
  }
  if (lable == 'Offline Sync') {
    EntitlementPermissionsUiModel entitlementPermissionsUiModel =
        entitlementPermissionsListQuickActions!
            .firstWhere((element) => element.id == 6);

    Navigator.pushNamed(context, RouteName.offlineSyncScreen,
        arguments: OfflineSyncScreenArguments(
            customOfflineSyncModule:
                entitlementPermissionsUiModel.customOfflineSyncModule,
            title: title));
  }

  // _navigateToAcceptedWorkPermit(BuildContext context,
  //     EntitlementPermissionsUiModel entitlementPermissionsUiModel) {
  //   if (context.read<DashboardProvider>().isNetworkConnected) {
  //     WorkPermitScreenArgs args = WorkPermitScreenArgs(
  //         entitlementPermissionsUiModel: entitlementPermissionsUiModel,
  //         showAcceptedOnly: true);
  //     Navigator.pushNamed(context, RouteName.workPermitListScreen,
  //         arguments: args);
  //   }
  // }
}
