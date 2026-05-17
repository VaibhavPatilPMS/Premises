import 'package:flutter/material.dart';
import 'package:premises/common/utils/debouncer.dart';

import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class CustomSearch extends StatelessWidget {
  final Function(String str) onChanged;
  String? searchStr = '';
  String? hintText;
  TextEditingController? searchController;
  final Debouncer onSearchDebouncer =
      Debouncer(delay: const Duration(milliseconds: 1000));

  CustomSearch({
    super.key,
    required this.onChanged,
    this.searchStr,
    this.hintText,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onSearchDebouncer.debounce(() => onChanged(value));
        onChanged(value);
      },
      initialValue: searchStr,
      controller: searchController,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(
        color: AppColors.text_grey,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.text_grey_g1,
          size: 20,
        ),
        prefixIconColor: AppColors.text_grey_g1,
        hintText: hintText ?? AppStrings().search,
        hintStyle: FormTextStyles.textFormFieldHintStyle,
        labelStyle: FormTextStyles.textFormFieldInputTextStyle,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.text_grey_g2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.text_grey_g2),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.text_grey_g2),
        ),
      ),
    );
  }
}
