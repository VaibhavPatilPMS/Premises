enum FieldType {
  dropDown,
  multiselectChips,
  removeChips,
  peopleBottomsheetList,
  contractorFirmDropDown,
  multiSelectBottomShit,
  singleSelectBottomShit,
  singleSelectRadioButtons,
  minMaxrange,
  textbox,
  involvedPeopleBottomsheet,
  timeSelect,
  checkbox,
  peopleAssigneeList
}

class FilterUIModel {
  final FieldType? fieldType;
  final String? title;
  final String? hintText;
  dynamic arr;
  dynamic value;

  FilterUIModel({
    this.fieldType,
    this.title,
    this.hintText,
    this.arr,
    this.value,
  });
}
