import 'package:flutter/material.dart';

abstract class ShowSubscriptionEndBanner {
  void showSubscriptionMaterialBanner();
  void hideSubscriptionMaterialBanner();
}

abstract class ShowMaterialBanner {
  void showCustomMaterialBanner(
      {required String message,
      Color? bannerBackgroundColor,
      Color? textColor,
      String? actionButtonText});
  void hideCustomMaterialBanner();
}

abstract class UpdateLowNetworkConnectivity {
  void updateLowNetwork(bool isLowNetwork);
}
