import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';
// import '../check_list/check_list.dart';
import 'provider.dart';

class CheckListOfflineItem extends StatefulWidget {
  // final CheckListsUiModel checkListUiModel;
  final bool? isNetworkConnected;
  final int? index;
  final Function? delete;

  const CheckListOfflineItem({
    super.key,
    // required this.checkListUiModel,
    this.isNetworkConnected = false,
    this.index,
    this.delete,
  });

  @override
  State<CheckListOfflineItem> createState() => _CheckListOfflineItemState();
}

class _CheckListOfflineItemState extends State<CheckListOfflineItem> {
  late OfflineSyncProvider _syncOfflineProvider;

  @override
  void initState() {
    super.initState();
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
  }

  Color convertToColor(int intColor) {
    return Color(intColor);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ChecklistDetailsArgs args = ChecklistDetailsArgs(
        //     checkListsUiModel: checkListUiModel,
        //     selectedTab: CheckListTab.MY_CHECKLIST);
        // Navigator.of(context)
        //     .pushNamed(RouteName.checklistDetailsScreen, arguments: args);
      },
      child: Container(
        padding: const EdgeInsets.only(right: 16, left: 8),
        margin: MarginPadding().xsmallTop,
        color: widget.checkListUiModel.checklistType == 'scheduled' &&
                widget.checkListUiModel.cardBackgroundColor != null
            ? convertToColor(widget.checkListUiModel.cardBackgroundColor!)
            : AppColors.status_resubmitted_light,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.isNetworkConnected!
                ? Checkbox(
                    side: WidgetStateBorderSide.resolveWith(
                      (states) => const BorderSide(
                        width: 1.0,
                        color: AppColors.color_primary,
                      ),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    activeColor: AppColors.white,
                    checkColor: AppColors.color_primary,
                    value: widget.checkListUiModel.isCheck ?? false,
                    onChanged: (v) {
                      _syncOfflineProvider
                          .updateOfflineSyncSingleSelectionChecklist(
                              widget.index, v);
                    },
                  )
                : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.checkListUiModel.checklistType == 'scheduled') ...{
                    Spacing().xsmallVertical,
                    AppText.xsmallCustomSemiBold(
                      widget.checkListUiModel.answerSheetStatus,
                      isUpperCase: true,
                      color:
                          convertToColor(widget.checkListUiModel.statusColor!),
                    ),
                    Spacing().smallVertical,
                    // } else if (widget.checkListUiModel.checklistType == null) ...{
                    // Spacing().xsmallVertical,
                    // AppText.xsmallCustomSemiBold(
                    //   widget.checkListUiModel.answerSheetStatus,
                    //   isUpperCase: true,
                    //   color: widget.checkListUiModel.statusColor != null
                    //       ? convertToColor(widget.checkListUiModel.statusColor!)
                    //       : AppColors.resubmitted,
                    // ),
                  },
                  Spacing().xsmallVertical,
                  AppText.smallBrandSecondaryBold(
                      widget.checkListUiModel.checklistId),
                  Spacing().smallVertical,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: AppText.xsmallGreyG1Medium(
                      widget.checkListUiModel.checklistName,
                    ),
                  ),
                  Spacing().xxsmallVertical,
                  if (widget.checkListUiModel.checklistType == 'scheduled') ...{
                    widget.checkListUiModel.groupCode != 'ADHOC'
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: AppText.xsmallGreyG1Medium(
                              widget.checkListUiModel.displayDate,
                            ),
                          )
                        : Container(),
                    Spacing().xxsmallVertical,
                  },
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: AppText.xsmallGreyG1Medium(
                      widget.checkListUiModel.documentNo,
                    ),
                  ),
                  Spacing().smallVertical,
                  widget.checkListUiModel.flgDraftAnswerSheet != null &&
                          widget.checkListUiModel.flgDraftAnswerSheet!
                      ? AppText.xsmallGreySemiBold('DRAFT')
                      : Container(),
                  if (widget.checkListUiModel.checklistType == 'scheduled') ...{
                    Spacing().smallVertical,
                  },
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColors.derived_color_one),
              ),
              child: AppIcon(
                icon: AppIcons().ic_delete,
                type: IconAssetType.SVG_ICON,
                iconHeight: IconSize().toolbrBackArrowIconHeight,
                onClick: () {
                  _deleteOfflineData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteOfflineData() {
    showDialog(
      context: context,
      builder: (context) {
        return CommonAlertDialog(
          onPressed: () {
            Navigator.of(context).pop();
            widget.delete!();
          },
          dialogButtonName: AppStrings().delete.toUpperCase(),
          dialogMessage: AppStrings().confirm_delete_message,
          dialogTitle: AppStrings().confirm_delete,
        );
      },
    );
  }
}
