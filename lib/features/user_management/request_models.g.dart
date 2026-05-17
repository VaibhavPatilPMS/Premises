// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginRequestModel _$UserLoginRequestModelFromJson(
  Map<String, dynamic> json,
) => UserLoginRequestModel(
  username: json['username'] as String?,
  password: json['password'] as String?,
  strategy: json['strategy'] as String?,
);

Map<String, dynamic> _$UserLoginRequestModelToJson(
  UserLoginRequestModel instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'strategy': instance.strategy,
};

ForgetPasswordRequestModel _$ForgetPasswordRequestModelFromJson(
  Map<String, dynamic> json,
) => ForgetPasswordRequestModel(username: json['username'] as String?);

Map<String, dynamic> _$ForgetPasswordRequestModelToJson(
  ForgetPasswordRequestModel instance,
) => <String, dynamic>{'username': instance.username};

ChangePasswordRequestModel _$ChangePasswordRequestModelFromJson(
  Map<String, dynamic> json,
) =>
    ChangePasswordRequestModel(
        username: json['username'] as String?,
        currentpassword: json['currentpassword'] as String?,
        newpassword: json['newpassword'] as String?,
        confirmedpassword: json['confirmedpassword'] as String?,
      )
      ..location_address = json['location_address'] as String?
      ..latitude = json['latitude'] as String?
      ..longitude = json['longitude'] as String?
      ..altitude = json['altitude'] as String?
      ..authorization = json['authorization'] as String?
      ..userid = json['userid'] as String?
      ..projectid = json['projectid'] as String?
      ..projectName = json['projectName'] as String?
      ..projectCode = json['projectCode'] as String?
      ..userContactNumber = json['userContactNumber'] as String?
      ..deviceUniqueId = json['deviceUniqueId'] as String?
      ..roleCode = json['roleCode'] as String?
      ..projectSId = json['projectSId'] as String?
      ..locationDetails = json['locationDetails'] == null
          ? null
          : LocationRequestModel.fromJson(
              json['locationDetails'] as Map<String, dynamic>,
            );

Map<String, dynamic> _$ChangePasswordRequestModelToJson(
  ChangePasswordRequestModel instance,
) => <String, dynamic>{
  'location_address': instance.location_address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'altitude': instance.altitude,
  'authorization': instance.authorization,
  'userid': instance.userid,
  'projectid': instance.projectid,
  'projectName': instance.projectName,
  'projectCode': instance.projectCode,
  'userContactNumber': instance.userContactNumber,
  'deviceUniqueId': instance.deviceUniqueId,
  'roleCode': instance.roleCode,
  'projectSId': instance.projectSId,
  'locationDetails': instance.locationDetails,
  'username': instance.username,
  'currentpassword': instance.currentpassword,
  'newpassword': instance.newpassword,
  'confirmedpassword': instance.confirmedpassword,
};
