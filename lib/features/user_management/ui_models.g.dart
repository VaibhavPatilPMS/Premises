// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginUiModel _$UserLoginUiModelFromJson(Map<String, dynamic> json) =>
    UserLoginUiModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserUiModel.fromJson(json['data'] as Map<String, dynamic>),
      isUserLoginSupported: json['isUserLoginSupported'] as bool?,
      isActive: json['isActive'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    )..isSuccess = json['isSuccess'] as bool?;

Map<String, dynamic> _$UserLoginUiModelToJson(UserLoginUiModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'success': instance.success,
      'message': instance.message,
      'isUserLoginSupported': instance.isUserLoginSupported,
      'isActive': instance.isActive,
      'data': instance.data,
      'statusCode': instance.statusCode,
    };

UserUiModel _$UserUiModelFromJson(Map<String, dynamic> json) => UserUiModel(
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  strategy: json['strategy'] as String?,
  id: json['id'] as String?,
  isAdmin: json['isAdmin'] as bool?,
  isActive: json['isActive'] as bool?,
  registrationTokens: (json['registrationTokens'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  username: json['username'] as String?,
  isMobileOtpVerified: json['isMobileOtpVerified'] as bool?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  emergencyContactName: json['emergencyContactName'] as String?,
  emergencyContactRelation: json['emergencyContactRelation'] as String?,
  idProofType: json['idProofType'] as String?,
  type: json['type'] as String?,
  designation: json['designation'] as String?,
  emergencyContactNumber: json['emergencyContactNumber'] as String?,
  organizationName: json['organizationName'] as String?,
  temporaryPassword: json['temporaryPassword'] as String?,
  profilePic: json['profilePic'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] as String?,
  userAssignedProjects: json['userAssignedProjects'] as String?,
  assignedProjects: (json['assignedProjects'] as List<dynamic>?)
      ?.map((e) => ProjectDetailsUiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  clientName: json['clientName'] as String?,
  profilePicObject: json['profilePicObject'] == null
      ? null
      : CommonFileObjectApiAndRequestModel.fromJson(
          json['profilePicObject'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserUiModelToJson(UserUiModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'strategy': instance.strategy,
      'id': instance.id,
      'isAdmin': instance.isAdmin,
      'isActive': instance.isActive,
      'registrationTokens': instance.registrationTokens,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'isMobileOtpVerified': instance.isMobileOtpVerified,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactRelation': instance.emergencyContactRelation,
      'idProofType': instance.idProofType,
      'type': instance.type,
      'designation': instance.designation,
      'emergencyContactNumber': instance.emergencyContactNumber,
      'organizationName': instance.organizationName,
      'temporaryPassword': instance.temporaryPassword,
      'profilePic': instance.profilePic,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt,
      'userAssignedProjects': instance.userAssignedProjects,
      'clientName': instance.clientName,
      'profilePicObject': instance.profilePicObject,
      'assignedProjects': instance.assignedProjects,
    };

ProjectUiModel _$ProjectUiModelFromJson(Map<String, dynamic> json) =>
    ProjectUiModel(
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      roleCode: json['roleCode'] as String?,
      roleName: json['roleName'] as String?,
    );

Map<String, dynamic> _$ProjectUiModelToJson(ProjectUiModel instance) =>
    <String, dynamic>{
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'roleCode': instance.roleCode,
      'roleName': instance.roleName,
    };
