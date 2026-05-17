import 'package:json_annotation/json_annotation.dart';

part 'geofencing_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GeofencingApiModel {
  bool? success;
  bool? isWithinGeofence;
  double? distance;
  int? allowedRadius;
  String? message;
  String? distanceWarning;
  bool? geofencingActive;

  GeofencingApiModel({
    this.success,
    this.isWithinGeofence,
    this.distance,
    this.allowedRadius,
    this.message,
    this.distanceWarning,
    this.geofencingActive,
  });

  factory GeofencingApiModel.fromJson(Map<String, dynamic> json) =>
      _$GeofencingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeofencingApiModelToJson(this);
}
