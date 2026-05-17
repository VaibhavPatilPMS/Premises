import 'package:flutter/material.dart';
import 'package:premises/common/resources/app_colors.dart';

class RadioButtonListTileWidget extends StatelessWidget {
  final Widget? title;
  final int index;
  final ValueChanged<Object?>? onChanged;
  final bool isCheck;
   final Widget? subtitle;
  final int selectedIndex;
  final ListTileControlAffinity? listTileControlAffinity;
  final EdgeInsets? contentPadding;
  final bool isBackgroundWhite;
  final bool isBorderRequired;

  const RadioButtonListTileWidget(
      {super.key,
      required this.title,
      required this.onChanged,
      required this.index,
      required this.isCheck,
      this.subtitle,
      required this.selectedIndex,
      this.listTileControlAffinity,
      this.contentPadding,
      this.isBorderRequired = false,
      this.isBackgroundWhite = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTileTheme(
        horizontalTitleGap: 8,
        child: RadioListTile(
          groupValue: selectedIndex,
          subtitle: subtitle,
          shape: isBorderRequired
              ? RoundedRectangleBorder(
                  side: BorderSide(
                      color: index == selectedIndex
                          ? AppColors.color_primary
                          : AppColors.border_color,
                      width: 1),
                  borderRadius: BorderRadius.circular(14),
                )
              : null,
          contentPadding: contentPadding ?? EdgeInsets.zero,
          controlAffinity:
              listTileControlAffinity ?? ListTileControlAffinity.leading,
          activeColor: AppColors.color_primary,
          tileColor: Colors.white,
          dense: true,
          selectedTileColor: !isBackgroundWhite
              ? AppColors.derived_color_one
              : AppColors.white,
          selected: index == selectedIndex,
          visualDensity: VisualDensity.compact,
          title: title,
          value: index,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
