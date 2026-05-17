import 'package:flutter/cupertino.dart';

class TextSize {
  static final TextSize _instance = TextSize._internal();

  TextSize._internal();

  factory TextSize() => _instance;

  get xxxsmall => 8.0;

  get xxsmall => 10.0;

  get xsmall => 12.0;

  get xsmallEleven => 11.0;

  get small => 14.0;

  get medium => 16.0;

  get xmedium => 18.0;

  get large => 20.0;

  get xlarge => 22.0;

  get xxlarge => 24.0;

  get xxxlarge => 26.0;
}

class MarginPadding {
  static final MarginPadding _instance = MarginPadding._internal();

  MarginPadding._internal();

  factory MarginPadding() => _instance;
  final xxxxsmall = 1.0;
  final xxxsmall = 2.0;
  final xxsmall = 4.0;
  final xsmall = 8.0;
  final small = 12.0;
  final medium = 14.0;
  final xmedium = 16.0;
  final large = 20.0;
  final xlarge = 24.0;
  final xxlarge = 32.0;
  final xxxlarge = 40.0;
  final xxxxxlarge = 44.0;

  get xxxSmallAll => EdgeInsets.all(xxxsmall);

  get xxSmallLeft => EdgeInsets.only(left: xxsmall);

  get xxSmallAll => EdgeInsets.all(xxsmall);

  //xxxsmall
  get xxxsmallAll => EdgeInsets.all(xxxsmall);

  get xxxsmallBottom => EdgeInsets.only(bottom: xxxsmall);

  get xxxsmallTop => EdgeInsets.only(top: xxxsmall);

  ///xxsmall
  get xxsmallAll => EdgeInsets.all(xxsmall);

  get xxsmallTop => EdgeInsets.only(top: xxsmall);

  get xxsmallLeft => EdgeInsets.only(left: xxsmall);

  get xxsmallRight => EdgeInsets.only(right: xxsmall);

  get xxsmallLeftRight => EdgeInsets.only(right: xxsmall, left: xxsmall);

  get xxsmallBottom => EdgeInsets.only(bottom: xxsmall);

  get xxsmallTopBottom => EdgeInsets.only(top: xxsmall, bottom: xxsmall);

  /// xsmall
  get xsmallAll => EdgeInsets.all(xsmall);

  get xsmallTop => EdgeInsets.only(top: xsmall);

  get xsmallBottom => EdgeInsets.only(bottom: xsmall);

  get xsmallLeft => EdgeInsets.only(left: xsmall);

  get xsmallRight => EdgeInsets.only(right: xsmall);

  get xsmallLeftRight => EdgeInsets.only(right: xsmall, left: xsmall);

  get xsmallTopBottom => EdgeInsets.only(top: xsmall, bottom: xsmall);

  get xsmallLeftRightBottom =>
      EdgeInsets.only(right: xsmall, left: xsmall, bottom: xsmall);

  get xsmalltopRightBottom =>
      EdgeInsets.only(right: xsmall, top: xsmall, bottom: xsmall);

  /// Small
  get smallAll => EdgeInsets.all(small);

  get smallTop => EdgeInsets.only(top: small);

  get smallBottom => EdgeInsets.only(bottom: small);

  get smallLeft => EdgeInsets.only(left: small);

  get smallRight => EdgeInsets.only(right: small);

  get smallLeftRight => EdgeInsets.only(right: small, left: small);

  get smallTopBottom => EdgeInsets.only(top: small, bottom: small);

  /// medium
  get mediumAll => EdgeInsets.all(medium);

  get mediumTop => EdgeInsets.only(top: medium);

  get mediumBottom => EdgeInsets.only(bottom: medium);

  get mediumLeft => EdgeInsets.only(left: medium);

  get mediumRight => EdgeInsets.only(right: medium);

  get mediumLeftRight => EdgeInsets.only(left: medium, right: medium);

  get mediumLeftRightTop =>
      EdgeInsets.only(left: medium, right: medium, top: medium);

  get mediumLeftRightBottom =>
      EdgeInsets.only(left: medium, right: medium, bottom: medium);

  get mediumTopBottom => EdgeInsets.only(top: medium, bottom: medium);

  get mediumLeftbottom => EdgeInsets.only(left: medium, bottom: medium);

  //xmedium
  get xmediumAll => EdgeInsets.all(xmedium);

  get xmediumTop => EdgeInsets.only(top: xmedium);

  get xmediumTopBottom => EdgeInsets.only(top: xmedium, bottom: xmedium);

  get xmediumLeftRight => EdgeInsets.only(left: xmedium, right: xmedium);

  get xmediumLeftRightTop =>
      EdgeInsets.only(left: xmedium, right: xmedium, top: xmedium);

  /// Large
  get largeAll => EdgeInsets.all(large);

  get largeTop => EdgeInsets.only(top: large);

  get largeBottom => EdgeInsets.only(bottom: large);

  get largeLeft => EdgeInsets.only(left: large);

  get largeRight => EdgeInsets.only(right: large);

  get largeLeftRight => EdgeInsets.only(right: large, left: large);

  /// xlarge
  get xlargeAll => EdgeInsets.all(xlarge);

  get xlargeTop => EdgeInsets.only(top: xlarge);

  get xlargeLeft => EdgeInsets.only(left: xlarge);

  get xlargeRight => EdgeInsets.only(right: xlarge);

  get xlargeLeftRight => EdgeInsets.only(right: xlarge, left: xlarge);

  get xlargeTopBottom => EdgeInsets.only(top: xlarge, bottom: xlarge);

  get xxlargeTopBottom => EdgeInsets.only(top: xxlarge, bottom: xxlarge);

  /// xxlarge
  get xxlargeAll => EdgeInsets.all(xxlarge);

  get xxlargeTop => EdgeInsets.only(top: xxlarge);

  get xxlargeLeft => EdgeInsets.only(left: xxlarge);

  get xxlargeRight => EdgeInsets.only(right: xxlarge);

  get xxlargeLeftRight => EdgeInsets.only(right: xxlarge, left: xxlarge);

  /// xxxlarge
  get xxxlargeAll => EdgeInsets.all(xxxlarge);

  get xxxlargeTop => EdgeInsets.only(top: xxxlarge);

  get xxxlargeLeft => EdgeInsets.only(left: xxxlarge);

  get xxxlargeRight => EdgeInsets.only(right: xxxlarge);

  get xxxlargeLeftRight => EdgeInsets.only(right: xxxlarge, left: xxxlarge);

  get toastDefaultPadding =>
      EdgeInsets.symmetric(horizontal: medium, vertical: medium);
}

class Spacing {
  static final Spacing _instance = Spacing._internal();

  Spacing._internal();

  factory Spacing() => _instance;
  final _xxxsmall = 2.0;
  final _xxsmall = 4.0;
  final _xsmall = 8.0;
  final _small = 12.0;
  final _xmedium = 14.0;
  final _medium = 16.0;
  final _lmedium = 18.0;
  final _large = 20.0;
  final _xlarge = 24.0;
  final _xxlarge = 32.0;
  final _xxxlarge = 72.0;
  final _xxxxlarge = 144.0;
  final _xxxxxlarge = 200.0;

  get xxsmallVertical => SizedBox(height: _xxsmall);

  get xxxsmallVertical => SizedBox(height: _xxxsmall);

  get xxxsmallHorizontal => SizedBox(width: _xxxsmall);

  get xxsmallHorizontal => SizedBox(width: _xxsmall);

  get xsmallVertical => SizedBox(height: _xsmall);

  get xsmallHorizontal => SizedBox(width: _xsmall);

  get smallVertical => SizedBox(height: _small);

  get xmediumVertical => SizedBox(height: _xmedium);

  get smallHorizontal => SizedBox(width: _small);

  get mediumVertical => SizedBox(height: _medium);

  get mediumHorizontal => SizedBox(width: _medium);

  get xmediumHorizontal => SizedBox(width: _xmedium);

  get lmediumHorizontal => SizedBox(width: _lmedium);

  get largeVertical => SizedBox(height: _large);

  get largeMediumVertical => SizedBox(height: _medium);

  get largeHorizontal => SizedBox(width: _large);

  get xlargeVertical => SizedBox(height: _xlarge);

  get xlargeHorizontal => SizedBox(width: _xlarge);

  get xxlargeVertical => SizedBox(height: _xxlarge);

  get xxlargeHorizontal => SizedBox(width: _xxlarge);

  get xxxlargeVertical => SizedBox(height: _xxxlarge);

  get xxxlargeHorizontal => SizedBox(width: _xxxlarge);

  get xxxxlargeVertical => SizedBox(height: _xxxxlarge);

  get xxxxxlargeVertical => SizedBox(height: _xxxxxlarge);

  get xxxxlargeHorizontal => SizedBox(width: _xxxxlarge);
}

class AppSizes {
  static final AppSizes _instance = AppSizes._internal();

  AppSizes._internal();

  factory AppSizes() => _instance;

  get xxxsmall => 8.0;

  get small => 24.0;

  get xsmall => 16.0;

  get medium => 32.0;

  get large => 48.0;

  get xlarge => 55.0;

  get toolboxHeight => 76.0;

  get dashboardTilesRoundCorners => 12.0;

  get dialogRoundCorners => 12.0;

  get dialogElevations => 5.0;

  get defaultMenuCardElevations => 7.0;

  get defaultButtonHeight => 48.0;

  get defaultButtonHeightSearchDropDown => 68.0;

  get butttonRoundedCorners => 8.0;

  get defaultCornerRadius => 4.0;

  get radioButtonCornerRadius => 22.0;

  get buttonBorderWidth => 1.0;

  get textFormFieldBorderWidth => 1.0;

  get dropDownBorderWidth => 1.0;

  get defaultTextFormFieldHeight => 56.0;

  get dropDownCornerRadius => 8.0;

  get defaultDropDownHeight => 56.0;

  get defaultTextFormFieldRoundedCorners => 8.0;

  get incidentReportActionButtonHeight => 42.0;

  get letterSpacing => 0.7;

  get letterSpacingButton => 1.2;

  get letterHeight => 1.2;

  get toolBarElevation => 3.0;

  get dashboardToolbarElevation => 1.5;

  get toolBarHeight => 80.0;

  get dashboardTopBottomSheetRoundCorners => 24.0;

  get drawerProfileCardRoundCorners => 24.0;

  get tabBarIndicatorWeight => 4.0;

  get tabBarHeight => 4.0;

  get tabBarRadius => 4.0;

  get floatingActionButtonElevation => 15.0;

  get defaultDropMenuOpenHeight => 250.0;

  get bottomSheetCornerRadius => 24.0;

  get documentPlaceHolderRoundedCorners => 8.0;

  get all_tab_default_width => 55.0;

  get induction_add_documents_width => 150.0;
}

class IconSize {
  static final IconSize _instance = IconSize._internal();

  IconSize._internal();

  factory IconSize() => _instance;

  get xxxsmall => 6.0;

  get xxsmall => 10.0;

  get xsmall => 16.0;

  get small => 20.0;

  get medium => 22.0;

  get xmedium => 24.0;

  get large => 28.0;

  get xlarge => 32.0;

  get xxlarge => 40.0;

  get xxxlarge => 48.0;

  get xxxxlarge => 52.0;

  //custom
  get defaultMenuIcon => 48.0;

  get profileCardMenuIcon => 32.0;

  get loginScreenIcon => 48.0;

  //quickActionIconSize
  get quickActions => 24.0;

  //toolbar back arrow icon height
  get toolbrBackArrowIconHeight => 30.0;

  get inducteePhoto => 55.0;
}

class ProfileSize {
  static final ProfileSize _instance = ProfileSize._internal();

  ProfileSize._internal();

  factory ProfileSize() => _instance;

  get width => 100.0;

  get height => 100.0;
}
