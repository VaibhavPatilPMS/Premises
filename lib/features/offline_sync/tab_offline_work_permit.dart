import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/offline_sync/provider.dart';
import 'package:safety_app/ui/work_permit/request_models.dart';
import 'package:safety_app/ui/work_permit/work_permit_list_card.dart';

import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';
import '../../common/utils/utils.dart';

class TabOfflineWorkPermits extends StatefulWidget {
  const TabOfflineWorkPermits({super.key});

  @override
  State<TabOfflineWorkPermits> createState() => _TabOfflineWorkPermitsState();
}

class _TabOfflineWorkPermitsState extends State<TabOfflineWorkPermits> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  //Methods
  @override
  void initState() {
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
    _syncOfflineProvider.isSelectAll = false;
    _syncOfflineProvider.getOfflineWorkPermits(
        context: context, isNotify: false);
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
                        .offlineWorkPermitsList!
                        .isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 16, left: 12),
                    child: CheckBoxListTileWidget(
                      onChanged: (val) {
                        _syncOfflineProvider
                            .updateOfflineSyncSelectionWorkPermit(val);
                      },
                      title: AppText.smallGreyMedium('Select All'),
                      isCheck: context.watch<OfflineSyncProvider>().isSelectAll,
                    ),
                  )
                : Container(),
            Expanded(
              child: context
                      .watch<OfflineSyncProvider>()
                      .offlineWorkPermitsList!
                      .isNotEmpty
                  ? _buildOfflineWorkPermitList(context
                      .watch<OfflineSyncProvider>()
                      .offlineWorkPermitsList)
                  : !context.watch<OfflineSyncProvider>().isLoading!
                      ? NoRecordFound(
                          message:
                              AppStrings().no_offline_work_permit_offline_sync)
                      : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineWorkPermitsList!
                        .where((element) => element.isCheck!)
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

  Widget _buildOfflineWorkPermitList(
      List<CreateWorkPermitRequestModel>? workPermitListOffline) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: workPermitListOffline!.length,
      itemBuilder: (context, index) {
        return WorkPermitListItem(
          workPermitDataListUiModel: null,
          createWorkPermitRequestModel: workPermitListOffline[index],
          selectedWpTab: SelectedWorkPermitTab.ALL,
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
          onPressed: () {
            _syncOfflineProvider.syncOfflineWorkPermits(context: context);
          }),
    );
  }
}
