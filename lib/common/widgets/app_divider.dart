import 'package:flutter/material.dart';

import 'package:premises/common/resources/resources.dart';

class HorizontalDivider extends StatelessWidget {
  final double? dividerThikness;
  final EdgeInsetsGeometry? dividerMargin;
  final Color? dividerColor;

  const HorizontalDivider(
      {super.key, this.dividerThikness, this.dividerMargin, this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: dividerMargin ?? MarginPadding().xxsmallTopBottom,
        child: Divider(
          thickness: dividerThikness ?? 1.0,
          color: dividerColor ?? AppColors.app_divider,
        ));
  }
}

class CustomVerticalDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final double? thickness;
  final Color? color;

  const CustomVerticalDivider(
      {super.key, this.height, this.width, this.color, this.thickness});

  @override
  Widget build(BuildContext context) => Container(
        height: height ?? AppSizes().medium,
        margin: MarginPadding().xxsmallRight,
        child: VerticalDivider(
          color: color ?? AppColors.text_grey_g1,
          thickness: thickness ?? 1.5,
        ),
      );
}
