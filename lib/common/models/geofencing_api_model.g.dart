// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geofencing_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeofencingApiModel _$GeofencingApiModelFromJson(Map<String, dynamic> json) =>
    GeofencingApiModel(
      success: json['success'] as bool?,
      isWithinGeofence: json['isWithinGeofence'] as bool?,
      distance: (json['distance'] as num?)?.toDouble(),
      allowedRadius: (json['allowedRadius'] as num?)?.toInt(),
      message: json['message'] as String?,
      distanceWarning: json['distanceWarning'] as String?,
      geofencingActive: json['geofencingActive'] as bool?,
    );

Map<String, dynamic> _$GeofencingApiModelToJson(GeofencingApiModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'isWithinGeofence': instance.isWithinGeofence,
      'distance': instance.distance,
      'allowedRadius': instance.allowedRadius,
      'message': instance.message,
      'distanceWarning': instance.distanceWarning,
      'geofencingActive': instance.geofencingActive,
    };
