import 'package:flutter/material.dart';
import 'package:premises/common/resources/resources.dart';

class CheckBoxListTileWidget extends StatefulWidget {
  final Widget? title;
  final ValueChanged<bool?>? onChanged;
  final bool? isCheck;
  final ListTileControlAffinity? listTileControlAffinity;
  final EdgeInsets? contentPadding;

  const CheckBoxListTileWidget({
    required this.title,
    required this.onChanged,
    this.listTileControlAffinity,
    this.isCheck,
    super.key,
    this.contentPadding,
  });

  @override
  CheckBoxListTileWidgetState createState() => CheckBoxListTileWidgetState();
}

class CheckBoxListTileWidgetState extends State<CheckBoxListTileWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;
    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes().defaultCornerRadius)),
    );
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Theme(
        data: theme.copyWith(
          checkboxTheme: newCheckBoxTheme,
        ),
        child: ListTileTheme(
          horizontalTitleGap: 8,
          child: CheckboxListTile(
              contentPadding: widget.contentPadding ?? EdgeInsets.zero,
              controlAffinity: widget.listTileControlAffinity ??
                  ListTileControlAffinity.leading,
              activeColor: Colors.white,
              side: WidgetStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                        width: 1.0,
                        color: AppColors.color_primary,
                      )),
              checkColor: AppColors.color_primary,
              dense: true,
              selectedTileColor: AppColors.derived_color_one,
              selected: widget.isCheck!,
              visualDensity: VisualDensity.compact,
              title: widget.title,
              value: widget.isCheck!,
              onChanged: widget.onChanged!),
        ),
      ),
    );
  }
}
