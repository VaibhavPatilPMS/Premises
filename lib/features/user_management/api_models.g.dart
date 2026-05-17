// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginApiModel _$UserLoginApiModelFromJson(Map<String, dynamic> json) =>
    UserLoginApiModel(
      accessToken: json['accessToken'] as String?,
      authentication: json['authentication'] == null
          ? null
          : Authentication.fromJson(
              json['authentication'] as Map<String, dynamic>,
            ),
      refreshToken: json['refreshToken'] as String?,
      userDetails: json['user'] == null
          ? null
          : UserDetails.fromJson(json['user'] as Map<String, dynamic>),
      clientName: json['clientName'] as String?,
    );

Map<String, dynamic> _$UserLoginApiModelToJson(UserLoginApiModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'authentication': instance.authentication,
      'user': instance.userDetails,
      'clientName': instance.clientName,
    };

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(strategy: json['strategy'] as String?);

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{'strategy': instance.strategy};

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
  id: json['_id'] as String?,
  isAdmin: json['isAdmin'] as bool?,
  isActive: json['isActive'] as bool?,
  registrationTokens: (json['registrationTokens'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  isMobileOtpVerified: json['isMobileOtpVerified'] as bool?,
  phoneNumber: json['phoneNumber'] as String?,
  emergencyContactName: json['emergencyContactName'] as String?,
  emergencyContactRelation: json['emergencyContactRelation'] as String?,
  idProofType: json['idProofType'] as String?,
  type: json['type'] as String?,
  designation: json['designation'] as String?,
  emergencyContactNumber: json['emergencyContactNumber'] as String?,
  organizationName: json['organizationName'] as String?,
  temporaryPassword: json['temporaryPassword'] as String?,
  profilePic: json['profilePic'] == null
      ? null
      : CommonFileObjectApiAndRequestModel.fromJson(
          json['profilePic'] as Map<String, dynamic>,
        ),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] as String?,
  projects: (json['projects'] as List<dynamic>?)
      ?.map((e) => UsersProjectListApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'isAdmin': instance.isAdmin,
      'isActive': instance.isActive,
      'registrationTokens': instance.registrationTokens,
      'isMobileOtpVerified': instance.isMobileOtpVerified,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
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
      'projects': instance.projects,
    };

UserAssignedProjects _$UserAssignedProjectsFromJson(
  Map<String, dynamic> json,
) => UserAssignedProjects(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => UsersProjectListApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num?)?.toInt(),
  youTubeLinkMobile: json['YouTubeLinkMobile'] as String?,
  clientName: json['clientName'] as String?,
);

Map<String, dynamic> _$UserAssignedProjectsToJson(
  UserAssignedProjects instance,
) => <String, dynamic>{
  'total': instance.total,
  'data': instance.data,
  'YouTubeLinkMobile': instance.youTubeLinkMobile,
  'clientName': instance.clientName,
};

UsersProjectListApiModel _$UsersProjectListApiModelFromJson(
  Map<String, dynamic> json,
) => UsersProjectListApiModel(
  projectCode: json['projectCode'] as String?,
  projectName: json['projectName'] as String?,
  roleCode: json['roleCode'] as String?,
  roleName: json['roleName'] as String?,
  sId: json['_id'] as String?,
  isPlanExpired: json['isPlanExpired'] as bool?,
  photo: json['photo'],
  city: json['city'] as String?,
  contactNumber: json['contactNumber'] as String?,
  address: json['address'] as String?,
  projectId: json['projectId'] as String?,
  website: json['website'] as String?,
  developerName: json['developerName'] as String?,
  endDate: json['endDate'] as String?,
  legalEntityName: json['legalEntityName'] as String?,
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$UsersProjectListApiModelToJson(
  UsersProjectListApiModel instance,
) => <String, dynamic>{
  'projectCode': instance.projectCode,
  '_id': instance.sId,
  'projectName': instance.projectName,
  'roleCode': instance.roleCode,
  'roleName': instance.roleName,
  'isActive': instance.isActive,
  'isPlanExpired': instance.isPlanExpired,
  'photo': instance.photo,
  'city': instance.city,
  'contactNumber': instance.contactNumber,
  'address': instance.address,
  'projectId': instance.projectId,
  'developerName': instance.developerName,
  'website': instance.website,
  'endDate': instance.endDate,
  'legalEntityName': instance.legalEntityName,
};

ForgetPasswordApiModel _$ForgetPasswordApiModelFromJson(
  Map<String, dynamic> json,
) => ForgetPasswordApiModel(
  data: json['data'] as List<dynamic>?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ForgetPasswordApiModelToJson(
  ForgetPasswordApiModel instance,
) => <String, dynamic>{'data': instance.data, 'message': instance.message};

ChangePasswordApiModel _$ChangePasswordApiModelFromJson(
  Map<String, dynamic> json,
) =>
    ChangePasswordApiModel(msg: json['msg'] as String?, status: json['status']);

Map<String, dynamic> _$ChangePasswordApiModelToJson(
  ChangePasswordApiModel instance,
) => <String, dynamic>{'msg': instance.msg, 'status': instance.status};

EmergencyContactApiModel _$EmergencyContactApiModelFromJson(
  Map<String, dynamic> json,
) => EmergencyContactApiModel(
  total: (json['total'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  skip: (json['skip'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map(
        (e) => EmergencyContactDataApiModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$EmergencyContactApiModelToJson(
  EmergencyContactApiModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'limit': instance.limit,
  'skip': instance.skip,
  'data': instance.data,
};

EmergencyContactDataApiModel _$EmergencyContactDataApiModelFromJson(
  Map<String, dynamic> json,
) => EmergencyContactDataApiModel(
  sId: json['_id'] as String?,
  name: json['name'] as String?,
  details: json['details'] as String?,
  contactNumberType: json['contactNumberType'] as String?,
  contactNumber: json['contactNumber'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  iV: (json['iV'] as num?)?.toInt(),
);

Map<String, dynamic> _$EmergencyContactDataApiModelToJson(
  EmergencyContactDataApiModel instance,
) => <String, dynamic>{
  '_id': instance.sId,
  'name': instance.name,
  'details': instance.details,
  'contactNumberType': instance.contactNumberType,
  'contactNumber': instance.contactNumber,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'iV': instance.iV,
};
