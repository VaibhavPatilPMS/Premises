import 'package:hive_ce/hive_ce.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_api_models.g.dart';

@JsonSerializable()
class ProjectImageApiModel {
  List<ProjectImageApiDataModel>? data;

  ProjectImageApiModel({this.data});

  factory ProjectImageApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectImageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectImageApiModelToJson(this);
}

@JsonSerializable()
class ProjectImageApiDataModel {
  String? sId;
  dynamic photo;
  bool? isPlanExpired;

  ProjectImageApiDataModel({this.sId, this.photo, this.isPlanExpired});

  factory ProjectImageApiDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectImageApiDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectImageApiDataModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 143)
class PendingTasksApiModel {
  @HiveField(0)
  int? total;
  @HiveField(1)
  int? limit;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  List<PendingTasksDataApiModel>? data;

  PendingTasksApiModel({this.total, this.limit, this.skip, this.data});

  factory PendingTasksApiModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTasksApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTasksApiModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 144)
class PendingTasksDataApiModel {
  @HiveField(0)
  List<DashboardCarouselPendingCountsApiModel>? dashboardCarouselPendingCounts;

  PendingTasksDataApiModel({this.dashboardCarouselPendingCounts});

  factory PendingTasksDataApiModel.fromJson(Map<String, dynamic> json) =>
      _$PendingTasksDataApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTasksDataApiModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 145)
class DashboardCarouselPendingCountsApiModel {
  @HiveField(0)
  String? module;
  @HiveField(1)
  int? totalPendingCount;
  @HiveField(2)
  PendingCountsApiModel? pendingCounts;

  DashboardCarouselPendingCountsApiModel(
      {this.module, this.totalPendingCount, this.pendingCounts});

  factory DashboardCarouselPendingCountsApiModel.fromJson(
          Map<String, dynamic> json) =>
      _$DashboardCarouselPendingCountsApiModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashboardCarouselPendingCountsApiModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 146)
class PendingCountsApiModel {
  @HiveField(0)
  int? reviewerPendingCount;
  @HiveField(1)
  int? makerPendingCount;
  @HiveField(2)
  int? auditorPendingCount;
  @HiveField(3)
  int? checkerPendingCount;
  @HiveField(4)
  int? myChecklistPendingCount;
  @HiveField(5)
  int? byMePendingCount;
  @HiveField(6)
  int? forMePendingCount;
  @HiveField(7)
  int? approverPendingCount;

  PendingCountsApiModel(
      {this.reviewerPendingCount,
      this.makerPendingCount,
      this.auditorPendingCount,
      this.checkerPendingCount,
      this.myChecklistPendingCount,
      this.byMePendingCount,
      this.forMePendingCount,
      this.approverPendingCount});

  factory PendingCountsApiModel.fromJson(Map<String, dynamic> json) =>
      _$PendingCountsApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingCountsApiModelToJson(this);
}

@JsonSerializable()
class CommonApiResponseModel {
  String? message;
  String? code;
  @JsonKey(name: 'id')
  String? sId;
  @JsonKey(name: 'statusCode')
  int? customStatusCode;

  CommonApiResponseModel(
      {this.message, this.code, this.sId, this.customStatusCode});

  factory CommonApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommonApiResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonApiResponseModelToJson(this);
}
