// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizationRequestModel _$AuthorizationRequestModelFromJson(
  Map<String, dynamic> json,
) => AuthorizationRequestModel()
  ..location_address = json['location_address'] as String?
  ..latitude = json['latitude'] as String?
  ..longitude = json['longitude'] as String?
  ..altitude = json['altitude'] as String?
  ..authorization = json['authorization'] as String?
  ..userid = json['userid'] as String?
  ..username = json['username'] as String?
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

Map<String, dynamic> _$AuthorizationRequestModelToJson(
  AuthorizationRequestModel instance,
) => <String, dynamic>{
  'location_address': instance.location_address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'altitude': instance.altitude,
  'authorization': instance.authorization,
  'userid': instance.userid,
  'username': instance.username,
  'projectid': instance.projectid,
  'projectName': instance.projectName,
  'projectCode': instance.projectCode,
  'userContactNumber': instance.userContactNumber,
  'deviceUniqueId': instance.deviceUniqueId,
  'roleCode': instance.roleCode,
  'projectSId': instance.projectSId,
  'locationDetails': instance.locationDetails,
};

LocationRequestModel _$LocationRequestModelFromJson(
  Map<String, dynamic> json,
) => LocationRequestModel()
  ..location_address = json['location_address'] as String?
  ..latitude = json['latitude'] as String?
  ..longitude = json['longitude'] as String?
  ..altitude = json['altitude'] as String?;

Map<String, dynamic> _$LocationRequestModelToJson(
  LocationRequestModel instance,
) => <String, dynamic>{
  'location_address': instance.location_address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'altitude': instance.altitude,
};
