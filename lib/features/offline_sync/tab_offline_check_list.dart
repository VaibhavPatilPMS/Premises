import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/offline_sync/provider.dart';

import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';
import '../check_list/check_list.dart';
import 'check_list_item.dart';

class TabOfflineCheckList extends StatefulWidget {
  const TabOfflineCheckList({super.key});

  @override
  State<TabOfflineCheckList> createState() => _TabOfflineCheckListState();
}

class _TabOfflineCheckListState extends State<TabOfflineCheckList> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  //Methods
  @override
  void initState() {
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
    _syncOfflineProvider.isSelectAll = false;
    _syncOfflineProvider.getOfflineChecklist(
      context: context,
    );
    _syncOfflineProvider.getOfflineTask(context: context, isNotify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineChecklistList!
                        .isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 16, left: 12),
                    child: CheckBoxListTileWidget(
                      onChanged: (val) {
                        _syncOfflineProvider
                            .updateOfflineSyncSelectionChecklist(val);
                      },
                      title: AppText.smallGreyMedium('Select All'),
                      isCheck: context.watch<OfflineSyncProvider>().isSelectAll,
                    ),
                  )
                : Container(),
            Expanded(
              child: context
                      .watch<OfflineSyncProvider>()
                      .offlineChecklistList!
                      .isNotEmpty
                  ? _buildOfflineCheckList(
                      context.watch<OfflineSyncProvider>().offlineChecklistList)
                  : !context.watch<OfflineSyncProvider>().isLoading!
                      ? NoRecordFound(
                          message: AppStrings().no_offline_checklist_sync)
                      : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineChecklistList!
                        .where((element) => element.isCheck ?? false)
                        .toList()
                        .isNotEmpty
                ? _bottomSyncButton()
                : Container(),
          ],
        ),
        _progressBar(context),
      ],
    );
  }

  Widget _buildOfflineCheckList(List<CheckListsUiModel>? offlineChecklistList) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: offlineChecklistList!.length,
      itemBuilder: (context, index) {
        return CheckListOfflineItem(
          checkListUiModel: offlineChecklistList[index],
          index: index,
          isNetworkConnected:
              context.watch<OfflineSyncProvider>().isNetworkConnected,
          delete: () {
            _syncOfflineProvider.deleteChecklist(index);
          },
        );
      },
    );
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.watch<OfflineSyncProvider>().isLoading,
    );
  }

  Widget _bottomSyncButton() {
    return Container(
      color: AppColors.white,
      padding: MarginPadding().xlargeAll,
      child: AppButton(
          buttonName: AppStrings().sync_offline_screen.toUpperCase(),
          backgroundColor: AppColors.color_primary,
          onPressed: () {
            _syncOfflineProvider.syncOfflineChecklist(context: context);
          }),
    );
  }
}
