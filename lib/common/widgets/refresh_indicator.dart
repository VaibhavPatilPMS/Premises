import 'package:flutter/material.dart';
import 'package:premises/common/resources/resources.dart';

class AppRefreshIndicator extends StatefulWidget {
  final RefreshCallback onRefresh;
  final RefreshIndicatorTriggerMode? triggerMode;
  final Color? backgroundColor;
  final Color? color;
  final Widget? child;
  final ScrollNotificationPredicate? notificationPredicate;

  const AppRefreshIndicator(
      {super.key,
      required this.onRefresh,
      this.triggerMode,
      this.backgroundColor,
      required this.child,
      this.color,
      this.notificationPredicate});

  @override
  State<AppRefreshIndicator> createState() => _AppRefreshIndicatorState();
}

class _AppRefreshIndicatorState extends State<AppRefreshIndicator> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: widget.onRefresh,
        triggerMode: widget.triggerMode ?? RefreshIndicatorTriggerMode.anywhere,
        backgroundColor:
            widget.backgroundColor ?? AppColors.progressBarBackground,
        color: widget.color ?? AppColors.progressBarForeground,
        notificationPredicate: widget.notificationPredicate ?? (_) => true,
        child: widget.child!);
  }
}
