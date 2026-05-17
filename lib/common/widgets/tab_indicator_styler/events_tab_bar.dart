import 'package:flutter/material.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class EventsTabBar extends StatefulWidget {
  final TabController tabController;
  final TabBarIndicatorSize? tabBarIndicatorSize;
  final List<Widget> tabs;
  final bool isScrollable;

  const EventsTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      this.tabBarIndicatorSize,
      this.isScrollable = true});

  @override
  State<EventsTabBar> createState() => _EventsTabBarState();
}

class _EventsTabBarState extends State<EventsTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      unselectedLabelColor: AppColors.text_grey_g1,
      labelColor: AppColors.white,
      isScrollable: false,
      indicator: const BoxDecoration(
        color: AppColors.selected_tab_bar,
      ),
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontFamily: FontFamily.fontFamily,
          //letterSpacing: AppSizes().letterSpacing,
          fontSize: TextSize().small),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontFamily: FontFamily.fontFamily,
          //letterSpacing: AppSizes().letterSpacing,
          fontSize: TextSize().small),
      tabs: widget.tabs,
      controller: widget.tabController,
      //indicatorSize: widget.tabBarIndicatorSize ?? TabBarIndicatorSize.tab,
    );
  }
}
