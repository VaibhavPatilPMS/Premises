// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocationRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocationRequestModel _$GeoLocationRequestModelFromJson(
  Map<String, dynamic> json,
) => GeoLocationRequestModel(
  locationAddress: json['locationAddress'] as String?,
  latitude: json['latitude'] as String?,
  longitude: json['longitude'] as String?,
  altitude: json['altitude'] as String?,
);

Map<String, dynamic> _$GeoLocationRequestModelToJson(
  GeoLocationRequestModel instance,
) => <String, dynamic>{
  'locationAddress': instance.locationAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'altitude': instance.altitude,
};
