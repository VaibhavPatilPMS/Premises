import 'package:json_annotation/json_annotation.dart';
import 'package:premises/common/models/models.dart';

import '../../common/base/base.dart';

part 'ui_models.g.dart';

@JsonSerializable()
class UserLoginUiModel extends UiModel {
  bool? success;
  @override
  String? message;
  bool? isUserLoginSupported;
  bool? isActive;
  UserUiModel? data;
  @override
  int? statusCode;

  UserLoginUiModel(
      {this.success,
      this.message,
      this.data,
      this.isUserLoginSupported,
      this.isActive,
      this.statusCode});

  factory UserLoginUiModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginUiModelToJson(this);
}

@JsonSerializable()
class UserUiModel {
  String? accessToken;
  String? refreshToken;
  String? strategy;

  // User Details
  String? id;
  bool? isAdmin;
  bool? isActive;
  List<String>? registrationTokens;
  String? firstName;
  String? lastName;
  String? username;
  bool? isMobileOtpVerified;
  String? email;
  String? phoneNumber;
  String? emergencyContactName;
  String? emergencyContactRelation;
  String? idProofType;
  String? type;
  String? designation;
  String? emergencyContactNumber;
  String? organizationName;
  String? temporaryPassword;
  String? profilePic;
  DateTime? createdAt;
  String? updatedAt;
  String? userAssignedProjects;
  String? clientName;
  CommonFileObjectApiAndRequestModel? profilePicObject;
  List<ProjectDetailsUiModel>? assignedProjects;

  UserUiModel(
      {this.accessToken,
      this.refreshToken,
      this.strategy,
      this.id,
      this.isAdmin,
      this.isActive,
      this.registrationTokens,
      this.firstName,
      this.lastName,
      this.username,
      this.isMobileOtpVerified,
      this.email,
      this.phoneNumber,
      this.emergencyContactName,
      this.emergencyContactRelation,
      this.idProofType,
      this.type,
      this.designation,
      this.emergencyContactNumber,
      this.organizationName,
      this.temporaryPassword,
      this.profilePic,
      this.createdAt,
      this.updatedAt,
      this.userAssignedProjects,
      this.assignedProjects,
      this.clientName,
      this.profilePicObject});

  factory UserUiModel.fromJson(Map<String, dynamic> json) =>
      _$UserUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserUiModelToJson(this);
}

@JsonSerializable()
class ProjectUiModel {
  String? projectCode;
  String? projectName;
  String? roleCode;
  String? roleName;

  ProjectUiModel(
      {this.projectCode, this.projectName, this.roleCode, this.roleName});

  factory ProjectUiModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectUiModelToJson(this);
}

class EmergencyContactUiModel extends UiModel {
  int? total;
  bool? success;
  @override
  String? message;
  @override
  int? statusCode;
  List<EmergencyContactDataUiModel>? data;

  EmergencyContactUiModel(
      {this.total, this.message, this.data, this.statusCode, this.success});
}

class EmergencyContactDataUiModel {
  String? sId;
  String? name;
  String? details;
  String? contactNumberType;
  String? contactNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EmergencyContactDataUiModel(
      {this.sId,
      this.name,
      this.details,
      this.contactNumberType,
      this.contactNumber,
      this.createdAt,
      this.updatedAt,
      this.iV});
}

class TrainingVideosUiModel extends UiModel {
  int? total;
  bool? success;
  @override
  String? message;
  @override
  int? statusCode;
  List<TrainingVideosDataUiModel>? data;

  TrainingVideosUiModel(
      {this.total, this.message, this.data, this.statusCode, this.success});
}

class TrainingVideosDataUiModel {
  String? sId;
  String? name;
  String? details;
  String? contactNumberType;
  String? contactNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TrainingVideosDataUiModel(
      {this.sId,
      this.name,
      this.details,
      this.contactNumberType,
      this.contactNumber,
      this.createdAt,
      this.updatedAt,
      this.iV});
}
