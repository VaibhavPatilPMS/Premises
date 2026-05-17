import 'dart:io';
import 'package:flutter/material.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:upgrader/upgrader.dart';
import 'package:premises/common/resources/resources.dart';

class CommonScreen {
  static Upgrader upgrader = Upgrader(
    debugLogging: false,
    minAppVersion: '1.0.0',
  );

  static Widget commonScreenWithAppbar(
      {required BuildContext context,
      Widget? appbarWidget,
      required Widget screenWidget,
      Widget? floatingWidget,
      Widget? bottomWidget,
      Widget? drawerWidget,
      Widget? endDrawerWidget,
      required GlobalKey<ScaffoldState> scaffoldKey,
      Color? buildScreenColor,
      bool? noDefaultPadding,
      bool? resizeToAvoidBottomInset}) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        drawer: drawerWidget,
        endDrawer: endDrawerWidget,
        backgroundColor: buildScreenColor ?? AppColors.text_grey_g3,
        appBar: appbarWidget as PreferredSizeWidget?,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
        floatingActionButton: floatingWidget,
        bottomNavigationBar: bottomWidget,
        endDrawerEnableOpenDragGesture: false,
        extendBody: true,
        body: Platform.isIOS
            ? UpgradeAlert(
                showIgnore: false,
                showLater: false,
                showReleaseNotes: true,
                upgrader: upgrader,
                dialogStyle: UpgradeDialogStyle.cupertino,
                child: _getChild(
                    context: context,
                    noDefaultPadding: noDefaultPadding,
                    screenWidget: screenWidget),
              )
            : _getChild(
                context: context,
                noDefaultPadding: noDefaultPadding,
                screenWidget: screenWidget),
      ),
    );
  }

  static _getChild(
      {required BuildContext context,
      required bool? noDefaultPadding,
      required Widget screenWidget}) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Container(
          padding: noDefaultPadding != null && noDefaultPadding
              ? EdgeInsets.zero
              : MarginPadding().mediumLeftRight,
          //color added for all main container(bcoz it was looking like lite grey)
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              24.0,
          width: MediaQuery.of(context).size.width,
          child: screenWidget,
        ));
  }

  static Widget commonScreenWithBackgroundImage(
      {required BuildContext context,
      required Widget screenWidget,
      required String imagePath,
      bool? resizeToAvoidBottomInset}) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
        extendBody: true,
        backgroundColor: AppColors.white,
        body: Stack(
          children: <Widget>[
            Image.asset(
              imagePath,
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Container(
              padding: MarginPadding().mediumLeftRight,
              alignment: Alignment.center,
              child: screenWidget,
            ),
          ],
        ),
      ),
    );
  }

  static Widget commonScreenWithNoAppbar(
      {required BuildContext context,
      required Widget screenWidget,
      required GlobalKey<ScaffoldState> scaffoldKey,
      Color? buildScreenColor,
      bool? noDefaultPadding,
      bool? resizeToAvoidBottomInset}) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: buildScreenColor ?? AppColors.white,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
        endDrawerEnableOpenDragGesture: false,
        extendBody: true,
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: Container(
              margin: noDefaultPadding != null && noDefaultPadding
                  ? EdgeInsets.zero
                  : MarginPadding().xlargeLeftRight,
              //color added for all main container(bcoz it was looking like lite grey)
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: screenWidget,
            )),
      ),
    );
  }
}

class CustomMaterialBanner {
  static showNoInternetConnectionBanner({required BuildContext? context}) {
    ScaffoldMessenger.of(context!).showMaterialBanner(MaterialBanner(
        content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppText.xsmallWhiteRegular('You are', isCenter: true),
          Spacing().xxsmallHorizontal,
          AppText.xsmallWhiteBold('OFFLINE', isCenter: true)
        ]),
        // leading: AppIcon(
        //   icon: AppIcons().ic_no_internect_connection,
        //   iconHeight: IconSize().medium,
        //   iconWidth: IconSize().medium,
        //   iconColor: AppColors.white,
        // ),
        backgroundColor: AppColors.text_asteriskColor_color,
        actions: [
          TextButton(
              onPressed: () {
                // dismiss the material banner
                ScaffoldMessenger.of(context).clearMaterialBanners();
              },
              child: AppText.xsmallWhiteRegular('DISMISS'))
        ]));
  }

  static showLowInternetConnectionBanner({required BuildContext? context}) {
    ScaffoldMessenger.of(context!).showMaterialBanner(MaterialBanner(
        content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppText.xsmallWhiteRegular('You are on a ', isCenter: true),
          Spacing().xxsmallHorizontal,
          AppText.xsmallWhiteBold('low internet connection.', isCenter: true)
        ]),
        // leading: AppIcon(
        //   icon: AppIcons().ic_no_internect_connection,
        //   iconHeight: IconSize().medium,
        //   iconWidth: IconSize().medium,
        //   iconColor: AppColors.white,
        // ),
        backgroundColor: AppColors.text_asteriskColor_color,
        actions: [
          TextButton(
              onPressed: () {
                // dismiss the material banner
                ScaffoldMessenger.of(context).clearMaterialBanners();
              },
              child: AppText.xsmallWhiteRegular('DISMISS'))
        ]));
  }

  static showMaterialBannerSubscriptionExpiry(
      {required BuildContext? context, required String message}) {
    ScaffoldMessenger.of(context!).showMaterialBanner(MaterialBanner(
        content: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppText.xsmallWhiteRegular(message, isCenter: true),
          Spacing().smallVertical,
        ]),
        backgroundColor: AppColors.text_asteriskColor_color,
        padding: MarginPadding().xsmallAll,
        actions: [
          const ContactSupportWidget(),
          Row(
            children: [
              Spacer(),
              TextButton(
                  onPressed: () {
                    // dismiss the material banner
                    ScaffoldMessenger.of(context).clearMaterialBanners();
                  },
                  child: AppText.xsmallWhiteRegular('DISMISS'))
            ],
          )
        ]));
  }

  static showCustomMaterialBanner(
      {required BuildContext? context,
      required String message,
      Color? backgroundColor,
      Color? textColor,
      String? actionButtonText}) {
    ScaffoldMessenger.of(context!).showMaterialBanner(MaterialBanner(
        content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: AppText.xsmallCustomRegular(
            message,
            isCenter: true,
            color: textColor ?? AppColors.white,
          )),
        ]),
        // leading: AppIcon(
        //   icon: AppIcons().ic_close_icon,
        //   iconHeight: IconSize().medium,
        //   iconWidth: IconSize().medium,
        //   iconColor: AppColors.white,
        // ),
        backgroundColor: backgroundColor ?? AppColors.text_asteriskColor_color,
        actions: [
          TextButton(
              onPressed: () {
                // dismiss the material banner
                ScaffoldMessenger.of(context).clearMaterialBanners();
              },
              child: AppText.xsmallWhiteRegular(actionButtonText ?? 'DISMISS'))
        ]));
  }
}
