// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencing_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeofencingRequestModel _$GeofencingRequestModelFromJson(
  Map<String, dynamic> json,
) =>
    GeofencingRequestModel(
        data: json['data'] == null
            ? null
            : GeofencingDataRequestModel.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      )
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

Map<String, dynamic> _$GeofencingRequestModelToJson(
  GeofencingRequestModel instance,
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
  'data': instance.data,
};

GeofencingDataRequestModel _$GeofencingDataRequestModelFromJson(
  Map<String, dynamic> json,
) => GeofencingDataRequestModel(
  action: json['action'] as String?,
  moduleName: json['moduleName'] as String?,
  userLatitude: (json['userLatitude'] as num?)?.toDouble(),
  userLongitude: (json['userLongitude'] as num?)?.toDouble(),
  userAltitude: (json['userAltitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$GeofencingDataRequestModelToJson(
  GeofencingDataRequestModel instance,
) => <String, dynamic>{
  'action': instance.action,
  'moduleName': instance.moduleName,
  'userLatitude': instance.userLatitude,
  'userLongitude': instance.userLongitude,
  'userAltitude': instance.userAltitude,
};
