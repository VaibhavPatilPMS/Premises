import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/events_and_trainings/toolbox_trainings/request_models.dart';
import 'package:safety_app/ui/offline_sync/provider.dart';

import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';
import '../events_and_trainings/toolbox_trainings/toolbox_training_list_card.dart';

class TabOfflineToolboxTraining extends StatefulWidget {
  const TabOfflineToolboxTraining({super.key});

  @override
  State<TabOfflineToolboxTraining> createState() =>
      _TabOfflineToolboxTrainingState();
}

class _TabOfflineToolboxTrainingState extends State<TabOfflineToolboxTraining> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  //Methods
  @override
  void initState() {
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
    _syncOfflineProvider.isSelectAll = false;
    _syncOfflineProvider.getOfflineTbts(context: context, isNotify: false);
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
                    context.watch<OfflineSyncProvider>().offlineTBTS!.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 16, left: 12),
                    child: CheckBoxListTileWidget(
                      onChanged: (val) {
                        _syncOfflineProvider
                            .updateOfflineSyncSelectionTbts(val);
                      },
                      title: AppText.smallGreyMedium('Select All'),
                      isCheck: context.watch<OfflineSyncProvider>().isSelectAll,
                    ),
                  )
                : Container(),
            Expanded(
              child:
                  context.watch<OfflineSyncProvider>().offlineTBTS!.isNotEmpty
                      ? _buildOfflineToolboxTrainingList(
                          context.watch<OfflineSyncProvider>().offlineTBTS)
                      : !context.watch<OfflineSyncProvider>().isLoading!
                          ? NoRecordFound(
                              message: AppStrings().no_offline_tbt_offline_sync)
                          : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineTBTS!
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

  Widget _bottomSyncButton() {
    return Container(
      color: AppColors.white,
      padding: MarginPadding().xlargeAll,
      child: AppButton(
          buttonName: AppStrings().sync_offline_screen.toUpperCase(),
          backgroundColor: AppColors.color_primary,
          onPressed: () {
            _syncOfflineProvider.syncOfflineTbts(context: context);
          }),
    );
  }

  Widget _buildOfflineToolboxTrainingList(
      List<CreateToolboxTrainingModel>? offlineTBTsList) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: offlineTBTsList!.length,
      itemBuilder: (context, index) {
        return ToolboxTrainingListItem(
          toolboxTrainingListDataUIModel: null,
          isMaker: true,
          isNetworkConnected:
              context.watch<OfflineSyncProvider>().isNetworkConnected,
          index: index,
          isOfflineSync: true,
          toolboxTrainingRequestModel: offlineTBTsList[index],
        );
      },
    );
  }

  Widget _progressBar(BuildContext context) {
    return AppProgressBar(
      isLoading: context.watch<OfflineSyncProvider>().isLoading,
    );
  }
}
