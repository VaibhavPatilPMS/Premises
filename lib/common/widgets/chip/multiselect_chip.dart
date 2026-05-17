import 'package:flutter/material.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/resources/resources.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> chipsList;
  final Function(List<String> selectedList) onSelectionChanged;
  List<String>? existingSelectedChoices = [];

  MultiSelectChip(
      {super.key,
      required this.chipsList,
      required this.onSelectionChanged,
      this.existingSelectedChoices});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    selectedChoices = widget.existingSelectedChoices ?? [];

    for (var item in widget.chipsList) {
      bool isSelected = selectedChoices.contains(item);
      choices.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.fontFamily,
            color: isSelected ? Colors.white : AppColors.text_grey_g1,
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              isSelected
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
          backgroundColor: Colors.transparent,
          shape: StadiumBorder(
              side: BorderSide(
                  color: isSelected
                      ? AppColors.color_primary
                      : AppColors.text_grey_g1,
                  width: 0.7)),
          selectedColor: AppColors.color_primary,
          shadowColor: AppColors.color_primary,
        ),
      ));
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
