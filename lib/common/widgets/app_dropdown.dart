import 'package:flutter/material.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/app_constants.dart';
import 'package:premises/common/models/models.dart';

class AppDropDown<T> extends StatefulWidget {
  final bool isFilterDropDown;
  final String hint;
  final T? value;
  final List<T> dropdownItems;
  final ValueChanged? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;
  final bool? isMandatory;
  final String? errorMessage;
  final bool enabled;

  const AppDropDown({
    this.isFilterDropDown = false,
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow = false,
    this.offset,
    this.isMandatory,
    this.errorMessage,
    super.key,
    this.enabled = true,
  });

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown>
    with TickerProviderStateMixin {
  bool isDropDownOpen = false;

  final _outLineInputBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.text_grey_g2,
      width: AppSizes().dropDownBorderWidth,
    ),
    borderRadius: BorderRadius.circular(AppSizes().dropDownCornerRadius),
  );

  final _outLineErrorBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.text_asteriskColor_color,
      width: AppSizes().dropDownBorderWidth,
    ),
    borderRadius: BorderRadius.circular(AppSizes().dropDownCornerRadius),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFilterDropDown
        ? Container(
            alignment: Alignment.center,
            height: widget.buttonHeight ?? AppSizes().defaultButtonHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.text_grey_g2,
                width: AppSizes().dropDownBorderWidth,
              ),
              borderRadius: BorderRadius.circular(
                AppSizes().dropDownCornerRadius,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: widget.value,
                isDense: true,
                isExpanded: true,
                hint: Container(
                  alignment: widget.hintAlignment,
                  child: Text(
                    widget.hint,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: FormTextStyles.textFormFieldHintStyle,
                  ),
                ),
                icon:
                    widget.icon ??
                    AppIcon(
                      icon: AppIcons().ic_arrow_down,
                      iconHeight: IconSize().large,
                      iconWidth: IconSize().large,
                    ),
                // style: AppStyles.textNormalblack2,
                items: widget.dropdownItems
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Container(
                          alignment: widget.valueAlignment,
                          child: Text(
                            item is CommonDropDownModel ? item.lable : item,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: FormTextStyles.textFormFieldInputTextStyle,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: widget.enabled ? widget.onChanged : null,
              ),
            ),
          )
        : DropdownButtonHideUnderline(
            child: DropdownButtonFormField2(
              //To avoid long text overflowing.
              isExpanded: true,
              isDense: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: false,
                contentPadding: EdgeInsets.zero,
                focusedBorder: _outLineInputBorderStyle,
                focusedErrorBorder: _outLineErrorBorderStyle,
                errorBorder: _outLineErrorBorderStyle,
                enabledBorder: _outLineInputBorderStyle,
                disabledBorder: _outLineInputBorderStyle,
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              validator: (value) {
                if (value == null && widget.isMandatory!) {
                  return widget.errorMessage!;
                }
                return null;
              },
              hint: Container(
                alignment: widget.hintAlignment,
                child: Text(
                  widget.hint,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: FormTextStyles.textFormFieldHintStyle,
                ),
              ),
              value: widget.value,
              items: widget.dropdownItems
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Container(
                        alignment: widget.valueAlignment,
                        child: Text(
                          item is CommonDropDownModel
                              ? (item.lable == "Labour" ? "Worker" : item.lable)
                              : item,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: FormTextStyles.textFormFieldInputTextStyle,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: widget.enabled ? widget.onChanged : null,
              selectedItemBuilder: widget.selectedItemBuilder,
              iconStyleData: IconStyleData(
                icon:
                    widget.icon ??
                    AppIcon(
                      icon: AppIcons().ic_arrow_down,
                      iconHeight: IconSize().large,
                      iconWidth: IconSize().large,
                    ),
                iconSize: widget.iconSize ?? 30,
                iconEnabledColor:
                    widget.iconEnabledColor ?? AppColors.text_grey_g2,
                iconDisabledColor: widget.iconDisabledColor,
              ),
              buttonStyleData: ButtonStyleData(
                height: widget.buttonHeight ?? AppSizes().defaultButtonHeight,
                width: widget.buttonWidth ?? MediaQuery.of(context).size.width,
                padding: widget.buttonPadding ?? const EdgeInsets.all(12.0),
                elevation: widget.buttonElevation,
              ),
              dropdownStyleData: DropdownStyleData(
                //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
                maxHeight:
                    widget.dropdownHeight ??
                    AppSizes().defaultDropMenuOpenHeight,
                width:
                    widget.dropdownWidth ??
                    MediaQuery.of(context).size.width -
                        (MarginPadding().medium * 2),
                padding: widget.dropdownPadding,
                elevation: widget.dropdownElevation ?? 8,
                offset: widget.offset ?? const Offset(0, 0),
                isOverButton: false,
                scrollbarTheme: ScrollbarThemeData(
                  radius: widget.scrollbarRadius ?? const Radius.circular(40),
                  thickness: WidgetStateProperty.all<double?>(
                    widget.scrollbarThickness,
                  ),
                  thumbVisibility: WidgetStateProperty.all<bool>(
                    widget.scrollbarAlwaysShow!,
                  ),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: widget.itemHeight ?? 40,
                padding:
                    widget.itemPadding ??
                    const EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          );
  }
}
