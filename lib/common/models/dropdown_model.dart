class CommonDropDownModel {
  String id;
  String lable;
  String? subTitle;
  String? code;

  CommonDropDownModel(
      {required this.id, required this.lable, this.subTitle, this.code});

  @override
  bool operator ==(dynamic other) =>
      other != null &&
      other is CommonDropDownModel &&
      other.runtimeType == runtimeType &&
      id == other.id;
}
