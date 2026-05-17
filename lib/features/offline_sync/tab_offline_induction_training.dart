import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/induction_training/induction_training_list_card.dart';
import 'package:safety_app/ui/induction_training/request_models.dart';
import 'package:safety_app/ui/offline_sync/provider.dart';

import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';

class TabOfflineInductionTraining extends StatefulWidget {
  const TabOfflineInductionTraining({super.key});

  @override
  State<TabOfflineInductionTraining> createState() =>
      _TabOfflineInductionTrainingState();
}

class _TabOfflineInductionTrainingState
    extends State<TabOfflineInductionTraining> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  //Methods
  @override
  void initState() {
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
    _syncOfflineProvider.isSelectAll = false;
    _syncOfflineProvider.getOfflineInductionTrainings(
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
                        .offlineInductionTrainings!
                        .isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 16, left: 12),
                    child: CheckBoxListTileWidget(
                      onChanged: (val) {
                        _syncOfflineProvider
                            .updateOfflineSyncSelectionInductionTrainings(val);
                      },
                      title: AppText.smallGreyMedium('Select All'),
                      isCheck: context.watch<OfflineSyncProvider>().isSelectAll,
                    ),
                  )
                : Container(),
            Expanded(
              child: context
                      .watch<OfflineSyncProvider>()
                      .offlineInductionTrainings!
                      .isNotEmpty
                  ? _buildOfflineInductionTrainingList(context
                      .watch<OfflineSyncProvider>()
                      .offlineInductionTrainings)
                  : !context.watch<OfflineSyncProvider>().isLoading!
                      ? NoRecordFound(
                          message:
                              AppStrings().no_offline_inductions_offline_sync)
                      : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineInductionTrainings!
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

  Widget _buildOfflineInductionTrainingList(
      List<CreateInductionTrainingModel>? offlineInductionTrainingList) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: offlineInductionTrainingList!.length,
      itemBuilder: (context, index) {
        return InductionTrainingListItem(
          inductionTrainingDataUiModel: null,
          isOfflineSync: true,
          index: index,
          isNetworkConnected:
              context.watch<OfflineSyncProvider>().isNetworkConnected,
          offlineInductionTrainingModel: offlineInductionTrainingList[index],
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
            _syncOfflineProvider.syncOfflineInductionTrainings(
                context: context);
          }),
    );
  }
}
