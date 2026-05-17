// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_ui_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedProjectUiModel _$AssignedProjectUiModelFromJson(
  Map<String, dynamic> json,
) =>
    AssignedProjectUiModel(
        success: json['success'] as bool?,
        projects: (json['projects'] as List<dynamic>?)
            ?.map(
              (e) => ProjectDetailsUiModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      )
      ..isSuccess = json['isSuccess'] as bool?
      ..message = json['message'] as String?
      ..statusCode = (json['statusCode'] as num?)?.toInt();

Map<String, dynamic> _$AssignedProjectUiModelToJson(
  AssignedProjectUiModel instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'success': instance.success,
  'projects': instance.projects,
};

ProjectDetailsUiModel _$ProjectDetailsUiModelFromJson(
  Map<String, dynamic> json,
) => ProjectDetailsUiModel(
  projectID: json['projectID'] as String?,
  roles: (json['roles'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  projectName: json['projectName'] as String?,
  projectCode: json['projectCode'] as String?,
  roleCode: json['roleCode'] as String?,
  roleName: json['roleName'] as String?,
  sId: json['sId'] as String?,
  projectImageToDisplay: json['projectImageToDisplay'] as String?,
  isSubscriptionActive: json['isSubscriptionActive'] as bool?,
  isActive: json['isActive'] as bool?,
  isCheck: json['isCheck'] as bool?,
  cityName: json['cityName'] as String?,
  address: json['address'] as String?,
  projectId: json['projectId'] as String?,
  website: json['website'] as String?,
  endDate: json['endDate'] as String?,
  developerName: json['developerName'] as String?,
  legalEntityName: json['legalEntityName'] as String?,
  clientName: json['clientName'] as String?,
)..contactNumber = json['contactNumber'] as String?;

Map<String, dynamic> _$ProjectDetailsUiModelToJson(
  ProjectDetailsUiModel instance,
) => <String, dynamic>{
  'projectID': instance.projectID,
  'roles': instance.roles,
  'projectName': instance.projectName,
  'projectCode': instance.projectCode,
  'roleCode': instance.roleCode,
  'roleName': instance.roleName,
  'cityName': instance.cityName,
  'projectImageToDisplay': instance.projectImageToDisplay,
  'isActive': instance.isActive,
  'isCheck': instance.isCheck,
  'isSubscriptionActive': instance.isSubscriptionActive,
  'contactNumber': instance.contactNumber,
  'address': instance.address,
  'projectId': instance.projectId,
  'website': instance.website,
  'developerName': instance.developerName,
  'sId': instance.sId,
  'endDate': instance.endDate,
  'legalEntityName': instance.legalEntityName,
  'clientName': instance.clientName,
};
