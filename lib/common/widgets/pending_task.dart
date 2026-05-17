import 'package:flutter/material.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/app_colors.dart';
import 'package:premises/common/resources/app_dimens.dart';
import 'package:premises/features/dashboard/pending_tasks_bottom_sheet.dart';
import 'package:premises/common/models/models.dart';

class PendingTaskWidget extends StatelessWidget {
  final List<DashboardCarouselPendingCountsUIModel>? pendingTasksList;
  final String? actionCountWorkPermits;
  final String? actionCountChecklist;
  final String? actionCountSafetyObervations;
  final List<EntitlementPermissionsUiModel>?
      entitlementPermissionsListDashboard;
  final List<EntitlementPermissionsUiModel>?
      entitlementPermissionsListQuickActions;

  const PendingTaskWidget(
      {super.key,
      this.pendingTasksList,
      this.actionCountWorkPermits,
      this.actionCountChecklist,
      this.actionCountSafetyObervations,
      this.entitlementPermissionsListDashboard,
      this.entitlementPermissionsListQuickActions});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: MarginPadding().smallAll,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes().dashboardTilesRoundCorners)),
              color: AppColors.color_secondary),
          child: IntrinsicHeight(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (pendingTasksList!.isNotEmpty) ...{
                    _taskContent(context,
                        count:
                            pendingTasksList![0].totalPendingCount!.toString(),
                        lable: pendingTasksList![0].module!,
                        pendingCounts: pendingTasksList![0].pendingCounts!,
                        pendingCountsModelList:
                            pendingTasksList![0].pendingCountsModelList!,
                        entitlementPermissionsListQuickActions:
                            entitlementPermissionsListQuickActions,
                        entitlementPermissionsListDashboard:
                            entitlementPermissionsListDashboard),
                    if (pendingTasksList!.length > 1) _divider(),
                  },
                  if (pendingTasksList!.length > 1) ...{
                    _taskContent(context,
                        count:
                            pendingTasksList![1].totalPendingCount!.toString(),
                        lable: pendingTasksList![1].module!,
                        pendingCounts: pendingTasksList![1].pendingCounts!,
                        pendingCountsModelList:
                            pendingTasksList![1].pendingCountsModelList!,
                        entitlementPermissionsListQuickActions:
                            entitlementPermissionsListQuickActions,
                        entitlementPermissionsListDashboard:
                            entitlementPermissionsListDashboard),
                    if (pendingTasksList!.length > 2) _divider(),
                  },
                  if (pendingTasksList!.length > 2) ...{
                    _taskContent(context,
                        count:
                            pendingTasksList![2].totalPendingCount!.toString(),
                        lable: pendingTasksList![2].module!,
                        pendingCounts: pendingTasksList![2].pendingCounts!,
                        pendingCountsModelList:
                            pendingTasksList![2].pendingCountsModelList!,
                        entitlementPermissionsListQuickActions:
                            entitlementPermissionsListQuickActions,
                        entitlementPermissionsListDashboard:
                            entitlementPermissionsListDashboard),
                  },
                ]),
          ),
        ),
      ],
    );
  }

  Widget _taskContent(BuildContext context,
      {required String count,
      required String lable,
      required PendingCountsUIModel pendingCounts,
      List<PendingCountsModelList>? pendingCountsModelList,
      List<EntitlementPermissionsUiModel>? entitlementPermissionsListDashboard,
      List<EntitlementPermissionsUiModel>?
          entitlementPermissionsListQuickActions}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (count != '0') {
            pendingTasksBottomSheet(context,
                pendingCountsModelList: pendingCountsModelList,
                lable: lable,
                entitlementPermissionQuickActionList:
                    entitlementPermissionsListQuickActions,
                entitlementPermissionsListDashboard:
                    entitlementPermissionsListDashboard);
          }
          // pendingTasksBottomSheet(context,
          //     pendingCountsModelList: pendingCountsModelList, lable: lable,entitlementPermissionsListDashboard:entitlementPermissionsListDashboard);
        },
        child: Column(
          children: [
            AppText.xlargeBrandPrimaryBold(count, isCenter: true),
            Spacing().xxsmallVertical,
            AppText.xsmallWhiteRegular(
              lable,
              isCenter: true,
            )
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return CustomVerticalDivider(
        height: AppSizes().large, color: AppColors.white);
  }
}
