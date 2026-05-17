import 'package:flutter/material.dart';
import 'package:premises/common/resources/resources.dart';

class AppColors {
  //brand colors
  //App Customizations
  static const color_primary = AppCustomizationColors
      .brand_color_primary; //bb_brand_orange //brand_color_primary

  static const derived_color_one = AppCustomizationColors
      .primary_derived_color_one; //bb_brand_orange_light //primary_derived_color_one

  static const derived_color_two = AppCustomizationColors
      .primary_derived_color_two; //bb_brand_orange_hover //primary_derived_color_two

  static const color_secondary = AppCustomizationColors
      .brand_color_secondary; //bb_brand_blue //brand_color_secondary

  //App Colors
  static const app_background_color_primary = Color(0xffFFFFFF); //white
  static const app_background_color_secondary = Color(0xffFAFAFA); // grey_g_3
  static const status_bar_color = Color(0xffFFFFFF);
  static const bar_chart_brown = Color(0xff82460A);
  static const bar_chart_cyan = Color(0xff0ED1B6);
  static const bar_chart_blue = Color(0xff2F35EB);
  static const bar_chart_termeric = Color(0xffEBB92F);
  static const background_response_tab = Color(0xffEEEEEE);

  //toolbar shadow color
  static const toolbarShadowColor = Color(0xff000029);

  static const white = Color(0xffFFFFFF);
  static const black = Color(0xff000000);

  //asteriskColor
  static const text_asteriskColor_color = Color(0xffEB3033);

  //progress bar color
  static const progressBarBackground = derived_color_one;
  static const progressBarForeground = color_primary;

  //App Test Theme Colors Text Grey
  static const text_grey = Color(0xff212121);
  static const text_grey_opacity80 = Color(0x80212121);

  static const text_grey_g1 = Color(0xff7D8184);
  static const text_grey_dark = Color(0xff5B5B5B);
  static const text_grey_g2 = Color(0xffCECECE);
  static const text_grey_g3 = Color(0xffFAFAFA);
  static const text_grey_g4 = Color(0xffF8F8F8);

  static const app_divider = Color(0xffCECECE);
  static const border_color = Color(0xffCECECE);

  //status colors Don't use this colors for App Widget
  static const status_accepted = Color(0xff149359);
  static const status_accepted_light = Color(0xffE4FFF2);
  static const status_open = Color(0xffF58D26);
  static const status_open_light = Color(0xffFFEEDC);

  static const status_rejected = Color(0xffEB3033);
  static const status_rejected_light = Color(0xffFCE0E0);
  static const status_resubmitted = Color(0xff3089E4);
  static const status_resubmitted_light = Color(0xffEAF3FD);
  static const status_reassigned = Color(0xff9E01DF);
  static const status_reassigned_light = Color(0xffF7EAFD);
  static const status_started_light = Color(0xffEAE2F2);

  //inductee colors
  static const category_consultant = Color(0xff16AEB9);
  static const category_staff = Color(0xffE13C29);
  static const category_client = Color(0xffCE9613);
  static const category_govt_official = Color(0xff6625B1);
  static const category_contractors = Color(0xff03B57F);
  //Task
  static const close_light = Color(0xffE4FFF2);

  static const category_labor = Color(0xff035BB5);

  //toast colors
  static const toast_color_error = Color(0xffEB3033);

  static const app_color_green = Color(0xff149359);
  static const app_color_red = Color(0xffEB3033);
  static const app_dashboard_1 = Color(0xffFFCFD0);
  static const app_dashboard_2 = Color(0xffFFF3C2);

  static const non_selected_tab_bar = Color(0xffECECEC);
  static const selected_tab_bar = Color(0xff000235);
  static const greyBackgroundColor = Color(0xffEDEDED);

  static const lightBlueBackgroundColor = Color(0xffe8f0f7);

  static const messageWidgetBackgroundColor = Color(0xfff7f6f8);
  static const supportCardTextColor = Color(0xff067AD2);

  static var highlightColor = Colors.grey.shade100;
  static var baseColor = Colors.grey.shade300;

  static const MaterialColor whiteMaterial = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
}
