import 'package:equatable/equatable.dart';
import 'package:premises/common/models/models.dart';

class CheckBoxListTileModel extends Equatable {
  String id;
  String? elementId;
  String title;
  String? subTitle;
  String? firstName;
  String? lastName;
  String? username;
  bool isCheck;
  CommonFileObjectApiAndRequestModel? profilePic;
  String? designation;

  CheckBoxListTileModel({
    required this.id,
    required this.title,
    required this.isCheck,
    this.subTitle,
    this.elementId,
    this.firstName,
    this.lastName,
    this.username,
    this.profilePic,
    this.designation,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, isCheck, elementId, designation];
}

class RadioButtonListTileModel {
  int? id;
  String? elementId;
  String title;
  String? subTitle;
  bool isCheck;

  RadioButtonListTileModel(
      {required this.id,
      required this.title,
      required this.isCheck,
      this.subTitle,
      this.elementId});
}
