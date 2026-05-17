import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/ui/offline_sync/provider.dart';
import 'package:safety_app/ui/safety_actionable/safety_actionable.dart';

import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';

class TabOfflineSafetyObservation extends StatefulWidget {
  const TabOfflineSafetyObservation({super.key});

  @override
  State<TabOfflineSafetyObservation> createState() =>
      _TabOfflineSafetyObservationState();
}

class _TabOfflineSafetyObservationState
    extends State<TabOfflineSafetyObservation> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _syncOfflineProvider = Provider.of<OfflineSyncProvider>(
      context,
      listen: false,
    );
    _syncOfflineProvider.isSelectAll = false;
    _syncOfflineProvider.getOfflineSafetyObservations(
      context: context,
      isNotify: false,
    );
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
                        .offlineSafetyObservationsList!
                        .isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 16, left: 12),
                    child: CheckBoxListTileWidget(
                      onChanged: (val) {
                        _syncOfflineProvider
                            .updateOfflineSyncSelectionSafetyObservation(val);
                      },
                      title: AppText.smallGreyMedium('Select All'),
                      isCheck: context.watch<OfflineSyncProvider>().isSelectAll,
                    ),
                  )
                : Container(),
            Expanded(
              child:
                  context
                      .watch<OfflineSyncProvider>()
                      .offlineSafetyObservationsList!
                      .isNotEmpty
                  ? _buildOfflineSafetyObservationList(
                      context
                          .watch<OfflineSyncProvider>()
                          .offlineSafetyObservationsList,
                    )
                  : !context.watch<OfflineSyncProvider>().isLoading!
                  ? NoRecordFound(
                      message: AppStrings()
                          .no_offline_safety_observation_offline_sync,
                    )
                  : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineSafetyObservationsList!
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

  Widget _buildOfflineSafetyObservationList(
    List<CreateSafetyObservationModel>? safetyObservationListOffline,
  ) {
    final filteredList =
        (safetyObservationListOffline ?? <CreateSafetyObservationModel>[])
            .where(
              (element) =>
                  element.uuid == null ||
                  !element.uuid!.startsWith('server_action_'),
            )
            .toList();
    if (filteredList.isEmpty) {
      return NoRecordFound(
        message: AppStrings().no_offline_safety_observation_offline_sync,
      );
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return SafetyObservationListItem(
          key: ValueKey(filteredList[index].uuid ?? index),
          finalIssuesDataUiModel: null,
          createSafetyObservationModel: filteredList[index],
          isAll: false,
          isCreate: false,
          isDownload: false,
          isUpdate: false,
          isNetworkConnected: context
              .watch<OfflineSyncProvider>()
              .isNetworkConnected,
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
          _syncOfflineProvider.syncOfflineSafetyObservations(context: context);
        },
      ),
    );
  }
}
