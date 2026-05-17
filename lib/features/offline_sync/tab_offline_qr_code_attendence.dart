import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/features/offline_sync/provider.dart';
import '../../common/widgets/widgets.dart';
import '../../common/resources/resources.dart';
import '../attendence/attendance.dart';

class TabOfflineQRCodeAttendence extends StatefulWidget {
  final String? source;

  const TabOfflineQRCodeAttendence({super.key, this.source});

  @override
  State<TabOfflineQRCodeAttendence> createState() =>
      _TabOfflineQRCodeAttendenceState();
}

class _TabOfflineQRCodeAttendenceState
    extends State<TabOfflineQRCodeAttendence> {
  late OfflineSyncProvider _syncOfflineProvider;
  final ScrollController _scrollController = ScrollController();

  //Methods
  @override
  void initState() {
    super.initState();
    _syncOfflineProvider =
        Provider.of<OfflineSyncProvider>(context, listen: false);
    _syncOfflineProvider.isSelectAll = false;
    _syncOfflineProvider.getAllCapturedAttendanceData(
        context: context, isNotify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: context
                      .watch<OfflineSyncProvider>()
                      .offlineDisplayCreatedInAndOutsList!
                      .isNotEmpty
                  ? _buildOfflineAttendanceList(context
                      .watch<OfflineSyncProvider>()
                      .offlineDisplayCreatedInAndOutsList)
                  : !context.watch<OfflineSyncProvider>().isLoading!
                      ? NoRecordFound(
                          message:
                              AppStrings().no_offline_attendance_offline_sync)
                      : Container(),
            ),
            context.watch<OfflineSyncProvider>().isNetworkConnected &&
                    context
                        .watch<OfflineSyncProvider>()
                        .offlineDisplayCreatedInAndOutsList!
                        .isNotEmpty
                ? _bottomSyncButton()
                : Container(),
          ],
        ),
        _progressBar(context),
      ],
    );
  }

  Widget _buildOfflineAttendanceList(
      List<AttendanceCaptureRequestModel>? offlineDisplayCreatedInAndOutsList) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: offlineDisplayCreatedInAndOutsList!.length,
      itemBuilder: (context, index) {
        return CapturedAttendanceListItem(
          attendanceCaptureRequestModel:
              offlineDisplayCreatedInAndOutsList[index],
          isNetworkConnected:
              context.watch<OfflineSyncProvider>().isNetworkConnected,
          isOfflineSync: true,
          index: index,
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
            _syncOfflineProvider.syncOfflineAttendanceCaptured(
                context: context, source: widget.source);
          }),
    );
  }
}
