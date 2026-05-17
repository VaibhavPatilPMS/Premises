import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/check_list/offlinetask_list_card.dart';
import 'package:safety_app/ui/check_list/request_models.dart';
import 'package:safety_app/ui/offline_sync/provider.dart';

import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';

class TabTask extends StatefulWidget {
  const TabTask({super.key});

  @override
  State<TabTask> createState() => _TabTaskState();
}

class _TabTaskState extends State<TabTask> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  //Methods
  @override
  void initState() {
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
    _syncOfflineProvider.isSelectAll = false;
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
            // context.watch<OfflineSyncProvider>().isNetworkConnected &&
            //         context
            //             .watch<OfflineSyncProvider>()
            //             .offlineTaskList!
            //             .isNotEmpty
            //     ? Container(
            //         padding: const EdgeInsets.only(top: 16, left: 12),
            //         child: CheckBoxListTileWidget(
            //           onChanged: (val) {
            //             _syncOfflineProvider
            //                 .updateOfflineSyncSelectionTaskList(val);
            //           },
            //           title: AppText.smallGreyMedium('Select All'),
            //           isCheck: context.watch<OfflineSyncProvider>().isSelectAll,
            //         ),
            //       )
            //     : Container(),
            Expanded(
              child: context
                      .watch<OfflineSyncProvider>()
                      .offlineTaskList!
                      .isNotEmpty
                  ? _buildOfflineWorkPermitList(
                      context.watch<OfflineSyncProvider>().offlineTaskList)
                  : !context.watch<OfflineSyncProvider>().isLoading!
                      ? NoRecordFound(
                          message: AppStrings().no_offline_Task_sync)
                      : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineTaskList!
                        .isNotEmpty
                ? _bottomSyncButton()
                : Container(),
          ],
        ),
        _progressBar(context),
      ],
    );
  }

  Widget _buildOfflineWorkPermitList(
      List<CreateTaskModel>? workPermitListOffline) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: workPermitListOffline!.length,
      itemBuilder: (context, index) {
        return OfflineTaskListItem(
          // workPermitDataListUiModel: null,
          attendanceCaptureRequestModel: workPermitListOffline[index],
          // selectedWpTab: SelectedWorkPermitTab.ALL,
          isNetworkConnected:
              context.watch<OfflineSyncProvider>().isNetworkConnected,
          index: index,
          isOfflineSync: true,
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
          onPressed: () async {
            _syncOfflineProvider.syncOfflineTasks(context: context);
          }),
    );
  }
}
