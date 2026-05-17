import 'package:json_annotation/json_annotation.dart';
import 'package:premises/common/models/models.dart';

part 'api_models.g.dart';

@JsonSerializable()
class UserLoginApiModel {
  String? accessToken;
  String? refreshToken;
  Authentication? authentication;
  @JsonKey(name: 'user')
  UserDetails? userDetails;
  String? clientName;

  UserLoginApiModel({
    this.accessToken,
    this.authentication,
    this.refreshToken,
    this.userDetails,
    this.clientName,
  });

  factory UserLoginApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginApiModelToJson(this);
}

@JsonSerializable()
class Authentication {
  String? strategy;

  Authentication({
    this.strategy,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}

@JsonSerializable()
class UserDetails {
  @JsonKey(name: '_id')
  String? id;
  bool? isAdmin;
  bool? isActive;
  List<String>? registrationTokens;
  bool? isMobileOtpVerified;
  String? firstName;
  String? lastName;
  String? username;
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
  CommonFileObjectApiAndRequestModel? profilePic;
  DateTime? createdAt;
  String? updatedAt;
  List<UsersProjectListApiModel>? projects;

  UserDetails(
      {this.id,
      this.isAdmin,
      this.isActive,
      this.registrationTokens,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.isMobileOtpVerified,
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
      this.projects});

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

@JsonSerializable()
class UserAssignedProjects {
  int? total;
  List<UsersProjectListApiModel>? data;
  @JsonKey(name: 'YouTubeLinkMobile')
  String? youTubeLinkMobile;
  String? clientName;

  UserAssignedProjects({this.data, this.total, this.youTubeLinkMobile,this.clientName});

  factory UserAssignedProjects.fromJson(Map<String, dynamic> json) =>
      _$UserAssignedProjectsFromJson(json);

  Map<String, dynamic> toJson() => _$UserAssignedProjectsToJson(this);
}

@JsonSerializable()
class UsersProjectListApiModel {
  String? projectCode;
  @JsonKey(name: '_id')
  String? sId;
  String? projectName;
  String? roleCode;
  String? roleName;
  bool? isActive;
  bool? isPlanExpired;
  dynamic photo;
  String? city;
  String? contactNumber;
  String? address;
  String? projectId;
  String? developerName;
  String? website;
  String? endDate;
  String? legalEntityName;

  UsersProjectListApiModel(
      {this.projectCode,
      this.projectName,
      this.roleCode,
      this.roleName,
      this.sId,
      this.isPlanExpired,
      this.photo,
      this.city,
      this.contactNumber,
      this.address,
      this.projectId,
      this.website,
      this.developerName,
      this.endDate,
      this.legalEntityName,
      this.isActive});

  factory UsersProjectListApiModel.fromJson(Map<String, dynamic> json) =>
      _$UsersProjectListApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersProjectListApiModelToJson(this);
}

@JsonSerializable()
class ForgetPasswordApiModel {
  List<dynamic>? data;
  String? message;

  ForgetPasswordApiModel({this.data, this.message});

  factory ForgetPasswordApiModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordApiModelToJson(this);
}

@JsonSerializable()
class ChangePasswordApiModel {
  ChangePasswordApiModel({
    this.msg,
    this.status,
  });

  String? msg;
  dynamic status;

  factory ChangePasswordApiModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordApiModelToJson(this);
}

@JsonSerializable()
class EmergencyContactApiModel {
  int? total;
  int? limit;
  int? skip;
  List<EmergencyContactDataApiModel>? data;

  EmergencyContactApiModel({this.total, this.limit, this.skip, this.data});

  factory EmergencyContactApiModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactApiModelToJson(this);
}

@JsonSerializable()
class EmergencyContactDataApiModel {
  @JsonKey(name: '_id')
  String? sId;
  String? name;
  String? details;
  String? contactNumberType;
  String? contactNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EmergencyContactDataApiModel(
      {this.sId,
      this.name,
      this.details,
      this.contactNumberType,
      this.contactNumber,
      this.createdAt,
      this.updatedAt,
      this.iV});

  factory EmergencyContactDataApiModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactDataApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactDataApiModelToJson(this);
}
