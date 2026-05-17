class GeofencingUiModel {
  int? statusCode;
  bool? success;
  bool? isWithinGeofence;
  double? distance;
  int? allowedRadius;
  String? message;
  String? distanceWarning;
  bool? geofencingActive;

  GeofencingUiModel({
    this.statusCode,
    this.success,
    this.isWithinGeofence,
    this.distance,
    this.allowedRadius,
    this.message,
    this.distanceWarning,
    this.geofencingActive,
  });
}
