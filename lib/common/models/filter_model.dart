import 'models.dart';

class FilterModel {
  DateTime? selectedFromDateTime;
  DateTime? selectedFromDateAlert;
  List<DateTime>? selectedDateTime;
  DateTime? selectedToDateTime;
  DateTime? selectedToDateAlert;
  List<SelectedDropDownId>? selectedDropDownId = [];
  List<SelectedChoice>? selectedChoice = [];
  List<RemovableChoice>? removableChoice = [];

  // Map<String, String>? selectedDropDownMap = <String, String>{};

  FilterModel({
    this.selectedFromDateTime,
    this.selectedFromDateAlert,
    this.selectedDateTime,
    this.selectedToDateTime,
    this.selectedToDateAlert,
    this.selectedDropDownId,
    this.selectedChoice,
    this.removableChoice,
    // this.selectedDropDownMap,
  });

  FilterModel.fromJson(Map<String, dynamic> json) {
    selectedFromDateTime = json['startDate'];
    selectedFromDateAlert = json['startDateAlert'];
    selectedToDateTime = json['endDate'];
    selectedToDateAlert = json['endDateAlert'];
    if (json['selectedDropDownId'] != null) {
      selectedDropDownId = <SelectedDropDownId>[];
      json['selectedDropDownId'].forEach((v) {
        selectedDropDownId!.add(SelectedDropDownId.fromJson(v));
      });
    }
    if (json['selectedChoice'] != null) {
      selectedChoice = <SelectedChoice>[];
      json['selectedChoice'].forEach((v) {
        selectedChoice!.add(SelectedChoice.fromJson(v));
      });
    }
    if (json['removableChoice'] != null) {
      removableChoice = <RemovableChoice>[];
      json['removableChoice'].forEach((v) {
        removableChoice!.add(RemovableChoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = selectedFromDateTime;
    data['startDateAlert'] = selectedFromDateAlert;
    data['endDate'] = selectedToDateTime;
    data['endDateAlert'] = selectedToDateAlert;
    if (selectedDropDownId != null) {
      data['selectedDropDownId'] =
          selectedDropDownId!.map((v) => v.toJson()).toList();
    }
    if (selectedChoice != null) {
      data['selectedChoice'] = selectedChoice!.map((v) => v.toJson()).toList();
    }
    if (removableChoice != null) {
      data['removableChoice'] =
          removableChoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class SelectedDropDownId {
  CommonDropDownModel? selectedValue;
  String? title;

  SelectedDropDownId({this.selectedValue, this.title});

  SelectedDropDownId.fromJson(Map<String, dynamic> json) {
    selectedValue = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = selectedValue;
    data['title'] = title;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class SelectedChoice {
  String? title;
  List<String>? selected;

  SelectedChoice({this.title, this.selected});

  SelectedChoice.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    selected = json['selected'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['selected'] = selected;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class RemovableChoice {
  String? title;
  List<CheckBoxListTileModel>? selected;

  RemovableChoice({this.title, this.selected});

  RemovableChoice.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    selected = json['selected'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['selected'] = selected;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

/*
{
  "startDate":"asdf",
  "endDate":"adsf",
  "selectedDropDownId":
  [
    {"id":"12","title":"afsafaf"},
    {"id":"34","title":"lkjhkjh"}
  ],
  "selectedChoice":
  [
    {"title":"Status","selected":["Open","Close"]},
    {"title":"Work Permit","selected":["Accepted","Rejected"]}
  ],
  "removableChoice":
  [
    {"title":"Status","selected":["Open","Close"]},
    {"title":"Work Permit","selected":["Accepted","Rejected"]}
  ]
}
*/
