import 'package:flutter/material.dart';

import '../../common/common_models/common_models.dart';
import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';
import 'offline_sync.dart';

class OfflineSyncScreen extends StatefulWidget {
  final OfflineSyncScreenArguments? offlineSyncScreenArguments;

  const OfflineSyncScreen({super.key, this.offlineSyncScreenArguments});

  @override
  _OfflineSyncScreenState createState() => _OfflineSyncScreenState();
}

class _OfflineSyncScreenState extends State<OfflineSyncScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  List<_ModuleTabConfig> _getEnabledModules() {
    final module = widget.offlineSyncScreenArguments!.customOfflineSyncModule!;
    final List<_ModuleTabConfig> configs = [];

    if (module.isWorkPermit ?? false) {
      configs.add(
        _ModuleTabConfig(
          title: AppStrings().work_permit_screen,
          tabWidget: const TabOfflineWorkPermits(),
        ),
      );
    }
    if (module.isToolBoxTraining ?? false) {
      configs.add(
        _ModuleTabConfig(
          title: AppStrings().toolbox_training_screen,
          tabWidget: const TabOfflineToolboxTraining(),
        ),
      );
    }
    if (module.isInductionTraining ?? false) {
      configs.add(
        _ModuleTabConfig(
          title: AppStrings().induction_training,
          tabWidget: const TabOfflineInductionTraining(),
        ),
      );
    }
    if ((module.isQRCodeScan ?? false) ||
        (module.isSearchAndMarkAttendance ?? false)) {
      configs.add(
        _ModuleTabConfig(
          title: AppStrings().qr_scans,
          tabWidget: const TabOfflineQRCodeAttendence(),
        ),
      );
    }
    if (module.isCheckList ?? false) {
      configs.add(
        _ModuleTabConfig(
          title: AppStrings().checklist,
          tabWidget: const TabOfflineCheckList(),
        ),
      );
    }
    if (module.isSafetyObservation ?? false) {
      configs.add(
        _ModuleTabConfig(
          title: AppStrings().safety_observation_screen,
          tabWidget: const TabOfflineSafetyObservation(),
        ),
      );
    }

    return configs;
  }

  //Methods
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _getTabLength(),
      vsync: this,
      initialIndex: _getCurrentSelectedTab(
        widget.offlineSyncScreenArguments!.title,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //Widgets
  Widget _buildScreenWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTabBar(
              tabController: _tabController,
              tabBarIndicatorSize: TabBarIndicatorSize.label,
              tabs: _getTabNames(),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: _getTabBars(),
                controller: _tabController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Redundant methods deleted

  _getTabNames() {
    return _getEnabledModules().map((e) => Tab(text: e.title)).toList();
  }

  _getTabBars() {
    return _getEnabledModules().map((e) => e.tabWidget).toList();
  }

  _getTabLength() {
    return _getEnabledModules().length;
  }

  _getCurrentSelectedTab(String? title) {
    if (title == null) return 0;
    final modules = _getEnabledModules();
    for (int i = 0; i < modules.length; i++) {
      if (modules[i].title == title ||
          (modules[i].title == AppStrings().qr_scans &&
              title == AppStrings().scan_qr)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithAppbar(
      context: context,
      scaffoldKey: _scaffoldKey,
      appbarWidget: CommonAppBar(title: AppStrings().sync_offline_screen),
      buildScreenColor: AppColors.white,
      noDefaultPadding: true,
      screenWidget: _buildScreenWidget(context),
    );
  }
}

class OfflineSyncScreenArguments {
  CustomOfflineSyncModule? customOfflineSyncModule;
  String? title;

  OfflineSyncScreenArguments({this.customOfflineSyncModule, this.title});
}

class _ModuleTabConfig {
  final String title;
  final Widget tabWidget;

  _ModuleTabConfig({required this.title, required this.tabWidget});
}
