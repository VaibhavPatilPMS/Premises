import 'package:flutter/material.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';

class CustomTabBar extends StatefulWidget {
  final TabController tabController;
  final TabBarIndicatorSize? tabBarIndicatorSize;
  final List<Widget> tabs;
  final bool isScrollable;

  const CustomTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      this.tabBarIndicatorSize,
      this.isScrollable = true});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      unselectedLabelColor: AppColors.text_grey_g1,
      labelColor: AppColors.color_secondary,
      isScrollable: widget.isScrollable,
      indicatorWeight: AppSizes().tabBarIndicatorWeight,
      padding: MarginPadding().xsmallBottom,
      indicatorColor: AppColors.color_primary,
      indicator: MaterialIndicator(
        height: AppSizes().tabBarHeight,
        topLeftRadius: AppSizes().tabBarRadius,
        topRightRadius: AppSizes().tabBarRadius,
        bottomLeftRadius: AppSizes().tabBarRadius,
        bottomRightRadius: AppSizes().tabBarRadius,
        horizontalPadding: MarginPadding().small,
        color: AppColors.color_primary,
        tabPosition: TabPosition.bottom,
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
      indicatorSize: widget.tabBarIndicatorSize ?? TabBarIndicatorSize.tab,
    );
  }
}
