import 'package:json_annotation/json_annotation.dart';
import 'package:premises/common/models/models.dart';

part 'geofencing_request_model.g.dart';

@JsonSerializable()
class GeofencingRequestModel extends AuthorizationRequestModel {
  GeofencingDataRequestModel? data;

  GeofencingRequestModel({
    this.data,
  });

  factory GeofencingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GeofencingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeofencingRequestModelToJson(this);
}

@JsonSerializable()
class GeofencingDataRequestModel {
  String? action;
  String? moduleName;
  double? userLatitude;
  double? userLongitude;
  double? userAltitude;

  GeofencingDataRequestModel({
    this.action,
    this.moduleName,
    this.userLatitude,
    this.userLongitude,
    this.userAltitude,
  });

  factory GeofencingDataRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GeofencingDataRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeofencingDataRequestModelToJson(this);
}
