import 'package:flutter/material.dart';
import 'package:premises/common/resources/app_colors.dart';

class AppProgressBar extends StatelessWidget {
  final bool? isLoading;

  const AppProgressBar({super.key, this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return AbsorbPointer(
        absorbing: isLoading!,
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.progressBarBackground,
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.progressBarForeground),
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
