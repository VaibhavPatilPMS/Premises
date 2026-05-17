import 'package:flutter/material.dart';

class AppCustomizationColors {
  //brand colors
  //App Customizations
  
  //bb_brand_orange //bb_brand_primary
  static const brand_color_primary = Color(0xffeb8d2f);
  //bb_brand_orange_light //bb_brand_primary_light
  static const primary_derived_color_one = Color(0xffFFF0D6);
  //bb_brand_orange_hover //bb_brand_primary_hover
  static const primary_derived_color_two = Color(0xffFFF9EF);
  //bb_brand_blue //bb_brand_secondary
  static const brand_color_secondary = Color(0xff000235);
}

class AppCustomizationIcons {
  static final AppCustomizationIcons _icon = AppCustomizationIcons._internal();

  AppCustomizationIcons._internal();

  factory AppCustomizationIcons() => _icon;

  icon(key) => "assets/icons/$key";

  get ic_app_logo => icon("ic_app_logo.svg");
}

class AppCustomizationImages {
  static final AppCustomizationImages _image =
      AppCustomizationImages._internal();

  AppCustomizationImages._internal();

  factory AppCustomizationImages() => _image;

  image(key) => "assets/images/$key";

  //App Customizations
  get bg_splash => image("img_splash.png");
}

class AppCustomizationStrings {
  static final AppCustomizationStrings _resource =
      AppCustomizationStrings._internal();

  factory AppCustomizationStrings() => _resource;

  AppCustomizationStrings._internal();

  //App Customizations
  String get app_title => 'Premises';

  String get splash_title => 'Premises';

  String get offline_db_name => 'premises_app_db';
}
