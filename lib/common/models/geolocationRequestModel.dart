import 'package:json_annotation/json_annotation.dart';

part 'geolocationRequestModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoLocationRequestModel {
  String? locationAddress;
  String? latitude;
  String? longitude;
  String? altitude;

  GeoLocationRequestModel(
      {this.locationAddress, this.latitude, this.longitude, this.altitude});

  factory GeoLocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationRequestModelToJson(this);
}
