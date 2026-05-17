import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/utils/utils.dart';

part 'common_ui_models.g.dart';

@JsonSerializable()
class AssignedProjectUiModel extends UiModel {
  bool? success;
  List<ProjectDetailsUiModel>? projects;

  AssignedProjectUiModel({
    this.success,
    this.projects,
  });

  factory AssignedProjectUiModel.fromJson(Map<String, dynamic> json) =>
      _$AssignedProjectUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedProjectUiModelToJson(this);
}

@JsonSerializable()
class ProjectDetailsUiModel {
  String? projectID;
  List<int>? roles;
  String? projectName;
  String? projectCode;
  String? roleCode;
  String? roleName;
  String? cityName;
  String? projectImageToDisplay;
  bool? isActive;
  bool? isCheck;
  bool? isSubscriptionActive;
  String? contactNumber;
  String? address;
  String? projectId;
  String? website;
  String? developerName;
  String? sId;
  String? endDate;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? projectLogoFile;
  String? legalEntityName;
  String? clientName;

  ProjectDetailsUiModel({
    this.projectID,
    this.roles,
    this.projectName,
    this.projectCode,
    this.roleCode,
    this.roleName,
    this.projectLogoFile,
    this.sId,
    this.projectImageToDisplay,
    this.isSubscriptionActive,
    this.isActive,
    this.isCheck,
    this.cityName,
    this.address,
    this.projectId,
    this.website,
    this.endDate,
    this.developerName,
    this.legalEntityName,
    this.clientName,
  });

  factory ProjectDetailsUiModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailsUiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDetailsUiModelToJson(this);
}

class StatusUiModel {
  String? statusLable;
  String? statusCode;
  String? id;
  Color? backgroundColor;
  Color? statusLableColor;
  String? iconPath;
  WpStatus? wpStatus;

  StatusUiModel(
      {this.statusLable,
      this.id,
      this.backgroundColor,
      this.statusLableColor,
      this.iconPath,
      this.statusCode,
      this.wpStatus});
}

class StatusUiModelSafetyActionable {
  String? statusLable;
  String? id;
  Color? backgroundColor;
  Color? statusLableColor;
  String? iconPath;

  StatusUiModelSafetyActionable(
      {this.statusLable,
      this.id,
      this.backgroundColor,
      this.statusLableColor,
      this.iconPath});
}

class CommonResponseUiModel {
  bool? success;
  String? message;
  int? statusCode;
  String? sId;

  CommonResponseUiModel(
      {this.success, this.message, this.statusCode, this.sId});
}

class PendingTasksUIModel {
  int? total;
  int? limit;
  int? skip;
  List<PendingTasksDataUIModel>? data;
  String? message;
  bool? success;

  PendingTasksUIModel(
      {this.total,
      this.limit,
      this.skip,
      this.data,
      this.message,
      this.success});
}

class PendingTasksDataUIModel {
  List<DashboardCarouselPendingCountsUIModel>? dashboardCarouselPendingCounts;

  PendingTasksDataUIModel({this.dashboardCarouselPendingCounts});
}

class DashboardCarouselPendingCountsUIModel {
  String? module;
  int? totalPendingCount;
  PendingCountsUIModel? pendingCounts;
  List<PendingCountsModelList>? pendingCountsModelList;
  DashboardCarouselPendingCountsUIModel(
      {this.module,
      this.totalPendingCount,
      this.pendingCounts,
      this.pendingCountsModelList});
}

class PendingCountsUIModel {
  int? reviewerPendingCount;
  int? makerPendingCount;
  int? auditorPendingCount;
  int? checkerPendingCount;
  int? myChecklistPendingCount;
  int? byMePendingCount;
  int? forMePendingCount;
  int? approverPendingCount;

  PendingCountsUIModel(
      {this.reviewerPendingCount,
      this.makerPendingCount,
      this.auditorPendingCount,
      this.checkerPendingCount,
      this.myChecklistPendingCount,
      this.byMePendingCount,
      this.forMePendingCount,
      this.approverPendingCount});
}

class PendingCountsModelList {
  String? module;
  String? moduleTitle;
  int? totalPendingCount;
  List<PendingCounts>? pendingCounts;

  PendingCountsModelList(
      {this.module, this.totalPendingCount, this.pendingCounts});
}

class PendingCounts {
  String? title;
  int? pendingCount;

  PendingCounts({this.title, this.pendingCount});
}

class TaskStatusUiModel {
  String? statusLable;
  String? id;
  Color? indicatorColor;
  Color? statusLableColor;

  TaskStatusUiModel({
    this.statusLable,
    this.id,
    this.indicatorColor,
    this.statusLableColor,
  });
}
