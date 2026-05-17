import 'package:collection/collection.dart';
import 'package:premises/app_config.dart';
import 'package:premises/application/app_data.dart';
import 'package:premises/application/app_router.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/features/user_management/user_management.dart';
import 'package:premises/common/resources/resources.dart';

class EntitlementsMapper {
  getProjectEntitlementsMapper({
    required EntitlementPermissionsApiModel? entitlementPermissionsApiModel,
    required int? statusCode,
    required List<ProjectImageApiDataModel>? projectImageData,
  }) {
    try {
      if (statusCode == 200 || statusCode == 201) {
        if (entitlementPermissionsApiModel!.data != null) {
          getEntitlementsData(EntitlementApiData? entitlementApiData) {
            return EntitlementDataUiModel(
              sId: entitlementApiData?.sId,
              roleCode: entitlementApiData?.roleCode,
              roleName: entitlementApiData?.roleName,
              entitlementPermissionsDashboardMenuList:
                  GetDashboardEntitlementsListV2()
                      .getEntitlementsPermissionDashboardList(
                        entitlementPermissionsApiList:
                            entitlementApiData?.entitlementPermissions,
                      ),
              projectImagePath: GetProjectImage().getProjectImage(
                projectImageData,
              ),
              entitlementPermissionsQuickActionsList:
                  GetQuickActionsEntitlementsList()
                      .getEntitlementsQuickActionsList(
                        entitlementPermissionsApiList:
                            entitlementApiData?.entitlementPermissions,
                      ),
            );
          }

          return EntitlementUiModel(
            message: null,
            projectId: AppData().userCurrentSelectedProject?.projectID,
            data: getEntitlementsData(entitlementPermissionsApiModel.data),
            projectCode: AppData().userCurrentSelectedProject?.projectCode,
            success: true,
          );
        } else {
          return EntitlementUiModel(
            message: AppStrings().data_not_found,
            projectId: null,
            data: null,
            projectCode: null,
            success: false,
          );
        }
      } else {
        return EntitlementUiModel(
          message: AppStrings().data_not_found,
          projectId: null,
          data: null,
          projectCode: null,
          success: false,
        );
      }
    } catch (error) {
      CustomLogger.logPrint('mapper error entitlements $error');
    }
  }
}

class GlobalConfigurationMapper {
  getGlobalConfigurationMapper({
    required GlobalConfigurationsApiModel? globalConfigurationsApiModel,
    required int? statusCode,
  }) {
    if (statusCode == 200 || statusCode == 201) {
      if (globalConfigurationsApiModel!.data != null &&
          globalConfigurationsApiModel.data!.isNotEmpty) {
        getConfigValue(Configuration? configuration) {
          if (configuration != null) {
            return configuration.value;
          } else {
            return false;
          }
        }

        getConfiguration(Configuration? configuration) {
          if (configuration != null) {
            return ConfigurationUIModel(
              lable: configuration.lable,
              type: configuration.type,
              value: configuration.value,
            );
          } else {
            return null;
          }
        }

        getConfigurationsData(
          List<GlobalConfigurationsApiDataModel>? configurationsList,
        ) {
          List<GlobalConfigurationsUiDataModel>? data = [];
          for (var element in configurationsList!) {
            GlobalConfigurationsUiDataModel globalConfigurationsUiDataModel =
                GlobalConfigurationsUiDataModel(
                  isActive: element.isActive,
                  sId: element.sId,
                  configurationCode: element.configurationCode,
                  ocrAccessKey: element.ocrAccessKey,
                  checker: element.checker,
                  maker: element.maker,
                  hoursLimit: element.hoursLimit,
                  configurationTypeCode: element.configurationTypeCode,
                  value: getConfigValue(element.configuration),
                  configuration: getConfiguration(element.configuration),
                );
            data.add(globalConfigurationsUiDataModel);
          }
          return data;
        }

        return GlobalConfigurationsUiModel(
          message: null,
          projectId: AppData().userCurrentSelectedProject?.projectID,
          data: getConfigurationsData(globalConfigurationsApiModel.data),
          projectCode: AppData().userCurrentSelectedProject?.projectCode,
          success: true,
        );
      } else {
        return GlobalConfigurationsUiModel(
          message: null,
          projectId: AppData().userCurrentSelectedProject?.projectID,
          data: null,
          projectCode: AppData().userCurrentSelectedProject?.projectCode,
          success: false,
        );
      }
    } else {
      return GlobalConfigurationsUiModel(
        message: null,
        projectId: AppData().userCurrentSelectedProject?.projectID,
        data: null,
        projectCode: AppData().userCurrentSelectedProject?.projectCode,
        success: false,
      );
    }
  }
}

class GetModuleIcon {
  String? getModuleIcon(String? entitlementCode) {
    switch (entitlementCode) {
      case EntitlementsCode.INDUCTION_TRAINING:
        return AppIcons().ic_induction_training_db;

      case EntitlementsCode.TOOLBOX_TRAINING || EntitlementsCode.EVENTS:
        return AppIcons().ic_toolbox_training_db;

      case EntitlementsCode.WORK_PERMIT:
        return AppIcons().ic_work_permit_db;

      case EntitlementsCode.WORK_PERMIT_AUDIT:
        return AppIcons().ic_work_permit_db;

      case EntitlementsCode.WORK_PERMIT_APPROVAL:
        return AppIcons().ic_work_permit_db;

      case EntitlementsCode.SAFETY_ACTIONABLE:
        return AppIcons().ic_safety_observations_db;

      case EntitlementsCode.INCIDENT_REPORT:
        return AppIcons().ic_incident_report_db;

      case EntitlementsCode.MOBILE_CHECKLIST:
        return AppIcons().ic_checklist_db;

      case EntitlementsCode.MOBILE_CHECKLIST_APPROVAL:
        return AppIcons().ic_checklist_db;

      case EntitlementsCode.MOBILE_SCORING:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_SCORING_APPROVAL:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_WORK_INSPECTION:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_WORK_INSPECTION_APPROVAL:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION_APPROVAL:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION_APPROVAL:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_HOME_INSPECTION:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.MOBILE_HOME_INSPECTION_APPROVAL:
        return AppIcons().ic_scoring_db;

      case EntitlementsCode.VIOLATION_DEBITNOTE:
        return AppIcons().ic_violation_notice;

      case EntitlementsCode.TASK_ASSIGNOR_BY_ME:
        return AppIcons().ic_task;

      case EntitlementsCode.TASK_ASSIGNEE_FOR_ME:
        return AppIcons().ic_task;

      case EntitlementsCode.TASK_MY_ALERT:
        return AppIcons().ic_task;

      case EntitlementsCode.MANAGE_USERS:
        return AppIcons().ic_manage_user;

      case EntitlementsCode.MANAGE_PROJECTS:
        return AppIcons().ic_manage_project;

      case EntitlementsCode.INCIDENT_REPORT_CAPA:
        return AppIcons().ic_incident_report_db;

      case EntitlementsCode.INCIDENT_REPORT_RCA:
        return AppIcons().ic_incident_report_db;

      case EntitlementsCode.INCIDENT_CAPA_APPROVER:
        return AppIcons().ic_incident_report_db;

      case EntitlementsCode.INCIDENT_REVIEWER:
        return AppIcons().ic_incident_report_db;

      case EntitlementsCode.MOBILE_OHS_DOCUMENT:
        return AppIcons().ic_mobile_ohs_document;
    }
    return null;
  }
}

class GetModuleName {
  String? getModuleName(String? entitlementCode) {
    switch (entitlementCode) {
      case EntitlementsCode.INDUCTION_TRAINING:
        return AppStrings().induction_training;

      case EntitlementsCode.TOOLBOX_TRAINING:
        return AppStrings().toolbox_training;

      case EntitlementsCode.EVENTS:
        return AppStrings().toolbox_training;

      case EntitlementsCode.WORK_PERMIT:
        return AppStrings().work_permit;

      case EntitlementsCode.WORK_PERMIT_AUDIT:
        return AppStrings().work_permit;

      case EntitlementsCode.WORK_PERMIT_APPROVAL:
        return AppStrings().work_permit;

      case EntitlementsCode.SAFETY_ACTIONABLE:
        return AppStrings().safety_actionable;

      case EntitlementsCode.INCIDENT_REPORT:
        return AppStrings().incident_report;

      case EntitlementsCode.INCIDENT_REPORT_CAPA:
        return AppStrings().incident_report;

      case EntitlementsCode.INCIDENT_REPORT_RCA:
        return AppStrings().incident_report;

      case EntitlementsCode.INCIDENT_CAPA_APPROVER:
        return AppStrings().incident_report;

      case EntitlementsCode.INCIDENT_REVIEWER:
        return AppStrings().incident_report;

      case EntitlementsCode.MOBILE_CHECKLIST:
        return AppStrings().checklist;

      case EntitlementsCode.MOBILE_CHECKLIST_APPROVAL:
        return AppStrings().checklist;

      case EntitlementsCode.MOBILE_SCORING:
        return AppStrings().projectScoring;

      case EntitlementsCode.MOBILE_SCORING_APPROVAL:
        return AppStrings().projectScoring;

      case EntitlementsCode.MOBILE_WORK_INSPECTION:
        return AppStrings().workInspection;

      case EntitlementsCode.MOBILE_WORK_INSPECTION_APPROVAL:
        return AppStrings().workInspection;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION:
        return AppStrings().materialInspection;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION_APPROVAL:
        return AppStrings().materialInspection;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION:
        return AppStrings().qualityInspection;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION_APPROVAL:
        return AppStrings().qualityInspection;

      case EntitlementsCode.MOBILE_HOME_INSPECTION:
        return AppStrings().homeInspection;

      case EntitlementsCode.MOBILE_HOME_INSPECTION_APPROVAL:
        return AppStrings().homeInspection;

      case EntitlementsCode.VIOLATION_DEBITNOTE:
        return AppStrings().violation_notice;

      case EntitlementsCode.TASK_ASSIGNOR_BY_ME:
        return AppStrings().task;

      case EntitlementsCode.TASK_ASSIGNEE_FOR_ME:
        return AppStrings().task;

      case EntitlementsCode.TASK_MY_ALERT:
        return AppStrings().task;

      case EntitlementsCode.MANAGE_USERS:
        return AppStrings().manageUsers;

      case EntitlementsCode.MANAGE_PROJECTS:
        return AppStrings().manageProjects;

      case EntitlementsCode.MOBILE_OHS_DOCUMENT:
        return AppStrings().ohs_document;
    }
    return null;
  }
}

class GetModuleNamesWorkInOffline {
  bool? getModuleNameWorkOffline(String? entitlementCode) {
    switch (entitlementCode) {
      case EntitlementsCode.INDUCTION_TRAINING:
        return true;

      case EntitlementsCode.TOOLBOX_TRAINING:
        return true;

      case EntitlementsCode.WORK_PERMIT:
        return true;

      case EntitlementsCode.WORK_PERMIT_AUDIT:
        return true;

      case EntitlementsCode.WORK_PERMIT_APPROVAL:
        return true;

      case EntitlementsCode.SAFETY_ACTIONABLE:
        return true;

      case EntitlementsCode.INCIDENT_REPORT:
        return false;

      case EntitlementsCode.MOBILE_CHECKLIST:
        return true;

      case EntitlementsCode.MOBILE_CHECKLIST_APPROVAL:
        return false;

      case EntitlementsCode.MOBILE_SCORING:
        return true;

      case EntitlementsCode.MOBILE_SCORING_APPROVAL:
        return false;

      case EntitlementsCode.MOBILE_WORK_INSPECTION:
        return true;

      case EntitlementsCode.MOBILE_WORK_INSPECTION_APPROVAL:
        return false;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION:
        return true;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION_APPROVAL:
        return false;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION:
        return true;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION_APPROVAL:
        return false;

      case EntitlementsCode.MOBILE_HOME_INSPECTION:
        return true;

      case EntitlementsCode.MOBILE_HOME_INSPECTION_APPROVAL:
        return false;

      case EntitlementsCode.VIOLATION_DEBITNOTE:
        return false;

      case EntitlementsCode.EVENTS:
        return false;

      case EntitlementsCode.MANAGE_USERS:
        return false;

      case EntitlementsCode.MANAGE_PROJECTS:
        return false;
    }
    return null;
  }
}

class GetModuleId {
  int? getModuleID(String? entitlementCode) {
    switch (entitlementCode) {
      case EntitlementsCode.WORK_PERMIT:
        return 1;

      case EntitlementsCode.WORK_PERMIT_AUDIT:
        return 1;

      case EntitlementsCode.WORK_PERMIT_APPROVAL:
        return 1;

      case EntitlementsCode.TOOLBOX_TRAINING:
        return 2;

      case EntitlementsCode.EVENTS:
        return 2;

      case EntitlementsCode.MOBILE_CHECKLIST:
        return 3;

      case EntitlementsCode.MOBILE_CHECKLIST_APPROVAL:
        return 3;

      case EntitlementsCode.SAFETY_ACTIONABLE:
        return 4;

      case EntitlementsCode.INCIDENT_REPORT:
        return 5;

      case EntitlementsCode.INCIDENT_REPORT_CAPA:
        return 5;

      case EntitlementsCode.INCIDENT_REPORT_RCA:
        return 5;

      case EntitlementsCode.INCIDENT_CAPA_APPROVER:
        return 5;

      case EntitlementsCode.INCIDENT_REVIEWER:
        return 5;

      case EntitlementsCode.INDUCTION_TRAINING:
        return 6;

      case EntitlementsCode.VIOLATION_DEBITNOTE:
        return 7;

      case EntitlementsCode.TASK_ASSIGNOR_BY_ME:
        return 8;
      case EntitlementsCode.TASK_ASSIGNEE_FOR_ME:
        return 8;
      case EntitlementsCode.TASK_MY_ALERT:
        return 8;

      case EntitlementsCode.MANAGE_USERS:
        return 9;

      case EntitlementsCode.MANAGE_PROJECTS:
        return 10;

      case EntitlementsCode.MOBILE_SCORING:
        return 11;

      case EntitlementsCode.MOBILE_SCORING_APPROVAL:
        return 11;

      case EntitlementsCode.MOBILE_WORK_INSPECTION:
        return 12;

      case EntitlementsCode.MOBILE_WORK_INSPECTION_APPROVAL:
        return 12;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION:
        return 13;

      case EntitlementsCode.MOBILE_MATERIAL_INSPECTION_APPROVAL:
        return 13;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION:
        return 14;

      case EntitlementsCode.MOBILE_QUALITY_INSPECTION_APPROVAL:
        return 14;

      case EntitlementsCode.MOBILE_HOME_INSPECTION:
        return 15;

      case EntitlementsCode.MOBILE_HOME_INSPECTION_APPROVAL:
        return 15;

      case EntitlementsCode.MOBILE_OHS_DOCUMENT:
        return 16;
    }
    return null;
  }
}

class GetModuleVisibility {
  getModuleVisibility({
    required bool? isCreate,
    required bool? isDelete,
    required bool? isUpdate,
    required bool? isRead,
    required bool? isDownload,
  }) {
    if (!isCreate! && !isDelete! && !isUpdate! && !isRead! && !isDownload!) {
      return false;
    } else {
      return true;
    }
  }
}

class GetProjectImage {
  getProjectImage(List<ProjectImageApiDataModel>? projectImageData) {
    if (projectImageData != null && projectImageData.isNotEmpty) {
      if (projectImageData[0].photo != null &&
          projectImageData[0].photo.runtimeType == String) {
        return null;
      } else if (projectImageData[0].photo != null) {
        CommonFileObjectApiAndRequestModel? commonFileObjectApiAndRequestModel =
            CommonFileObjectApiAndRequestModel.fromJson(
              projectImageData[0].photo,
            );
        if (commonFileObjectApiAndRequestModel.filename != null) {
          return FilePathUrls().getProjectPhotoDisplayUrl +
              commonFileObjectApiAndRequestModel.filename!;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  getProjectImageFromObject(
    dynamic projectImage, {
    String? projectCode,
    required String source,
  }) {
    if (projectImage != null) {
      if (projectImage != null && projectImage.runtimeType == String) {
        return null;
      } else if (projectImage != null) {
        CommonFileObjectApiAndRequestModel? commonFileObjectApiAndRequestModel =
            CommonFileObjectApiAndRequestModel.fromJson(projectImage);
        if (commonFileObjectApiAndRequestModel.filename != null) {
          if (source == RouteName.dashboardScreen) {
            return FilePathUrls().getProjectPhotoDisplayUrl +
                commonFileObjectApiAndRequestModel.filename!;
          } else if (source == RouteName.freemiumProjectListScreen &&
              projectCode != null) {
            return '${Environment.baseUrl}/project/api/v1/$projectCode/project/photo/${commonFileObjectApiAndRequestModel.filename!}';
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

class GetDashboardPendingCountsMapper {
  getDashboardPendingCountsMapper({
    required PendingTasksApiModel? pendingTasksApiModel,
    required int? statusCode,
    required List<ProjectImageApiDataModel>? projectImageData,
  }) async {
    try {
      if (statusCode == 200 || statusCode == 201) {
        if (pendingTasksApiModel!.data != null) {
          getCustomPendingCounts(
            String? module,
            PendingCountsApiModel? pendingCountsApiModel,
          ) {
            List<PendingCountsModelList> list = [];
            if (module == 'Work Permit') {
              List<PendingCounts>? pendingCounts = [];
              if (pendingCountsApiModel!.makerPendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.makerPendingCount,
                    title: 'Maker',
                  ),
                );
              }
              if (pendingCountsApiModel.checkerPendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.checkerPendingCount,
                    title: 'Checker',
                  ),
                );
              }

              if (pendingCountsApiModel.auditorPendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.auditorPendingCount,
                    title: 'Auditor',
                  ),
                );
              }

              list.add(
                PendingCountsModelList(
                  module: "work permit",
                  pendingCounts: pendingCounts,
                ),
              );
            } else if (module == 'TBT') {
              List<PendingCounts>? pendingCounts = [];
              pendingCounts.add(
                PendingCounts(
                  pendingCount: pendingCountsApiModel!.reviewerPendingCount,
                  title: 'Reviewer',
                ),
              );
              list.add(
                PendingCountsModelList(
                  module: "TBT",
                  pendingCounts: pendingCounts,
                ),
              );
            } else if (module == 'Checklist') {
              List<PendingCounts>? pendingCounts = [];
              if (pendingCountsApiModel!.myChecklistPendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.myChecklistPendingCount,
                    title: 'My Checklist',
                  ),
                );
              }

              if (pendingCountsApiModel.reviewerPendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.reviewerPendingCount,
                    title: 'Reviewer',
                  ),
                );
              }

              list.add(
                PendingCountsModelList(
                  module: "Checklist",
                  pendingCounts: pendingCounts,
                ),
              );
            } else if (module == 'Safety Observation' ||
                module == 'Safety Actionable') {
              List<PendingCounts>? pendingCounts = [];
              if (pendingCountsApiModel!.byMePendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.byMePendingCount,
                    title: 'By me',
                  ),
                );
              }

              if (pendingCountsApiModel.forMePendingCount != null) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: pendingCountsApiModel.forMePendingCount,
                    title: 'For me',
                  ),
                );
              }

              list.add(
                PendingCountsModelList(
                  module: "Safety Observation",
                  pendingCounts: pendingCounts,
                ),
              );
            } else if (module == 'Violation Notice') {
              List<PendingCounts>? pendingCounts = [];

              pendingCounts.add(
                PendingCounts(
                  pendingCount: pendingCountsApiModel!.approverPendingCount,
                  title: 'For me',
                ),
              );
              list.add(
                PendingCountsModelList(
                  module: "Violation Notice",
                  pendingCounts: pendingCounts,
                ),
              );
            }
            return list;
          }

          getPendingCountes(PendingCountsApiModel? pendingCountsApiModel) {
            return PendingCountsUIModel(
              reviewerPendingCount: pendingCountsApiModel!.reviewerPendingCount,
              makerPendingCount: pendingCountsApiModel.makerPendingCount,
              auditorPendingCount: pendingCountsApiModel.auditorPendingCount,
              checkerPendingCount: pendingCountsApiModel.checkerPendingCount,
              myChecklistPendingCount:
                  pendingCountsApiModel.myChecklistPendingCount,
              byMePendingCount: pendingCountsApiModel.byMePendingCount,
              forMePendingCount: pendingCountsApiModel.forMePendingCount,
              approverPendingCount: pendingCountsApiModel.approverPendingCount,
            );
          }

          Future<List<PendingTasksDataUIModel>> getPendingCounts(
            List<DashboardCarouselPendingCountsApiModel>? entitlementApiData,
          ) async {
            List<DashboardCarouselPendingCountsUIModel> pendingCountList = [];
            for (var element in entitlementApiData!) {
              if (element.totalPendingCount != 0) {
                pendingCountList.add(
                  DashboardCarouselPendingCountsUIModel(
                    module: element.module == 'Safety Actionable'
                        ? 'Safety Observation'
                        : element.module,
                    totalPendingCount: element.totalPendingCount,
                    pendingCounts: getPendingCountes(element.pendingCounts),
                    pendingCountsModelList: getCustomPendingCounts(
                      element.module,
                      element.pendingCounts,
                    ),
                  ),
                );
              }
            }

            int? offlineSyncPendingCount = await _getOfflineSyncCounts();
            if (offlineSyncPendingCount != 0) {
              List<PendingCountsModelList>? offlineModulesCounts = [];
              List<PendingCounts>? pendingCounts = [];

              // Work Permits
              List<CreateWorkPermitRequestModel>? offlineWorkPermitList =
                  await HiveWorkPermitService.getOfflineWorkPermits(
                    AppData().userCurrentSelectedProject!.projectCode,
                  );
              if (offlineWorkPermitList != null &&
                  offlineWorkPermitList.isNotEmpty) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: offlineWorkPermitList.length,
                    title: AppStrings().work_permit_screen,
                  ),
                );
                offlineModulesCounts.add(
                  PendingCountsModelList(
                    module: '',
                    pendingCounts: pendingCounts,
                    totalPendingCount: offlineWorkPermitList.length,
                  ),
                );
              }

              //TBT
              List<CreateToolboxTrainingModel>? offlineToolboxTrainingList =
                  await HiveTBTService.getOfflineTbts(
                    AppData().userCurrentSelectedProject!.projectCode,
                  );
              if (offlineToolboxTrainingList != null &&
                  offlineToolboxTrainingList.isNotEmpty) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: offlineToolboxTrainingList.length,
                    title: AppStrings().toolbox_training_screen,
                  ),
                );
                offlineModulesCounts.add(
                  PendingCountsModelList(
                    module: '',
                    pendingCounts: pendingCounts,
                    totalPendingCount: offlineToolboxTrainingList.length,
                  ),
                );
              }

              //Induction Trainings
              List<CreateInductionTrainingModel>? offlineInductionTrainingList =
                  await HiveInductionService.getOfflineInductionTrainings(
                    AppData().userCurrentSelectedProject!.projectCode,
                  );
              if (offlineInductionTrainingList != null &&
                  offlineInductionTrainingList.isNotEmpty) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: offlineInductionTrainingList.length,
                    title: AppStrings().induction_training,
                  ),
                );
                offlineModulesCounts.add(
                  PendingCountsModelList(
                    module: '',
                    pendingCounts: pendingCounts,
                    totalPendingCount: offlineInductionTrainingList.length,
                  ),
                );
              }

              // Offline Captured Attendance
              List<AttendanceCaptureRequestModel>?
              offlineScannedAttendanceList =
                  await HiveAttendanceCaptureService.getAttendanceRecords(
                    AppData().userCurrentSelectedProject!.projectCode,
                  );
              if (offlineScannedAttendanceList != null &&
                  offlineScannedAttendanceList.isNotEmpty) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: offlineScannedAttendanceList.length,
                    title: AppStrings().scan_qr,
                  ),
                );
                offlineModulesCounts.add(
                  PendingCountsModelList(
                    module: '',
                    pendingCounts: pendingCounts,
                    totalPendingCount: offlineScannedAttendanceList.length,
                  ),
                );
              }

              List<ChecklistDetailRequestModel>?
              offlineChecklistDetailRequestModelList =
                  await HiveChecklistService.getSubmittedOfflineChecklists(
                    AppData().userCurrentSelectedProject!.projectCode,
                  );
              if (offlineChecklistDetailRequestModelList!.isNotEmpty) {
                pendingCounts.add(
                  PendingCounts(
                    pendingCount: offlineChecklistDetailRequestModelList.length,
                    title: AppStrings().checklist,
                  ),
                );
                offlineModulesCounts.add(
                  PendingCountsModelList(
                    module: '',
                    pendingCounts: pendingCounts,
                    totalPendingCount:
                        offlineChecklistDetailRequestModelList.length,
                  ),
                );
              }

              pendingCountList.add(
                DashboardCarouselPendingCountsUIModel(
                  module: 'Offline Sync',
                  totalPendingCount: offlineSyncPendingCount,
                  pendingCounts: PendingCountsUIModel(
                    forMePendingCount: offlineSyncPendingCount,
                  ),
                  pendingCountsModelList: offlineModulesCounts,
                ),
              );
            }

            List<PendingTasksDataUIModel>? list = [];
            list.add(
              PendingTasksDataUIModel(
                dashboardCarouselPendingCounts: pendingCountList,
              ),
            );
            return list;
          }

          return PendingTasksUIModel(
            message: null,
            data: await getPendingCounts(
              pendingTasksApiModel.data![0].dashboardCarouselPendingCounts,
            ),
            success: true,
          );
        } else {
          return PendingTasksUIModel(
            message: AppStrings().data_not_found,
            data: null,
            success: false,
          );
        }
      } else {
        return PendingTasksUIModel(
          message: AppStrings().data_not_found,
          data: null,
          success: false,
        );
      }
    } catch (error) {
      //CustomLogger.logPrint('mapper error $error');
      return PendingTasksUIModel(
        message: AppStrings().data_not_found,
        data: null,
        success: false,
      );
    }
  }

  _getOfflineSyncCounts() async {
    int? totalCount = 0;
    List<CreateToolboxTrainingModel>? offlineToolboxTrainingList =
        await HiveTBTService.getOfflineTbts(
          AppData().userCurrentSelectedProject!.projectCode,
        );

    List<CreateInductionTrainingModel>? offlineInductionTrainingList =
        await HiveInductionService.getOfflineInductionTrainings(
          AppData().userCurrentSelectedProject!.projectCode,
        );

    List<CreateWorkPermitRequestModel>? offlineWorkPermitList =
        await HiveWorkPermitService.getOfflineWorkPermits(
          AppData().userCurrentSelectedProject!.projectCode,
        );

    List<AttendanceCaptureRequestModel>? offlineScannedAttendanceList =
        await HiveAttendanceCaptureService.getAttendanceRecords(
          AppData().userCurrentSelectedProject!.projectCode,
        );

    List<ChecklistDetailRequestModel>? offlineChecklistDetailRequestModelList =
        await HiveChecklistService.getSubmittedOfflineChecklists(
          AppData().userCurrentSelectedProject!.projectCode,
        );

    if (offlineToolboxTrainingList != null &&
        offlineToolboxTrainingList.isNotEmpty) {
      totalCount = totalCount + offlineToolboxTrainingList.length;
    }
    if (offlineInductionTrainingList != null &&
        offlineInductionTrainingList.isNotEmpty) {
      totalCount = totalCount + offlineInductionTrainingList.length;
    }
    if (offlineWorkPermitList != null && offlineWorkPermitList.isNotEmpty) {
      totalCount = totalCount + offlineWorkPermitList.length;
    }
    if (offlineScannedAttendanceList != null &&
        offlineScannedAttendanceList.isNotEmpty) {
      totalCount = totalCount + offlineScannedAttendanceList.length;
    }
    if (offlineChecklistDetailRequestModelList!.isNotEmpty) {
      totalCount = totalCount + offlineChecklistDetailRequestModelList.length;
    }
    return totalCount;
  }
}

class GetUserProjectMapper {
  List<ProjectDetailsUiModel>? getUserProjects({
    List<UsersProjectListApiModel>? projects,
    required String source,
    required String? clientName,
  }) {
    try {
      if (projects != null && projects.isNotEmpty) {
        // List<Project>? activeProjectsList =
        // projects.where((element) => element.isActive!).toList();

        List<ProjectDetailsUiModel>? userAssignedProjects = [];
        // projects.sort((a, b) => a.projectName!.compareTo(b.projectName!));
        for (int i = 0; i < projects.length; i++) {
          var element = projects[i];
          ProjectDetailsUiModel projectUiModel = ProjectDetailsUiModel(
            projectName: element.projectName,
            projectCode: element.projectCode,
            roleCode: element.roleCode,
            cityName: element.city,
            projectID: element.sId ?? '',
            isSubscriptionActive: element.isPlanExpired ?? false,
            isCheck: i == 0 ? true : false,
            //isActive: element.isActive ?? false,
            isActive: element.isActive ?? true,
            projectImageToDisplay: GetProjectImage().getProjectImageFromObject(
              element.photo,
              projectCode: element.projectCode,
              source: source,
            ),
            address: element.address,
            developerName: element.developerName,
            projectId: element.projectId,
            website: element.website,
            sId: element.sId,
            endDate: element.endDate,
            legalEntityName: element.legalEntityName,
            clientName: clientName,
            roleName: element.roleName?.trim(),
          );
          userAssignedProjects.add(projectUiModel);
        }
        return userAssignedProjects;
      }
    } catch (e) {
      //CustomLogger.logPrint('project exceptions ${e.toString()}');
      return null;
    }
    return null;
  }
}

class GetDashboardEntitlementsListV2 {
  List<EntitlementPermissionsUiModel>? getEntitlementsPermissionDashboardList({
    required List<EntitlementPermissions>? entitlementPermissionsApiList,
  }) {
    if (entitlementPermissionsApiList == null ||
        entitlementPermissionsApiList.isEmpty) {
      return null;
    }

    try {
      List<EntitlementPermissionsUiModel> entitlementPermissionsUiModelList =
          [];

      // Helper function to create EntitlementPermissionsUiModel
      EntitlementPermissionsUiModel createUiModel({
        bool isWorkInOffline = false,
        bool isVisible = true,
        List<EntitlementPermissionsUiModel>? multipleEntitlements,
        EntitlementPermissions? element,
        List<String>? entitlementCodeUiList,
      }) {
        return EntitlementPermissionsUiModel(
          entitlementCodeUiList: entitlementCodeUiList,
          entitlementName: element?.entitlementName,
          moduleCode: element?.moduleCode,
          moduleName: element?.moduleName,
          isCreate: element?.permissions?.create?.isAllowed ?? false,
          isDelete: element?.permissions?.delete?.isAllowed ?? false,
          isDownload: element?.permissions?.download?.isAllowed ?? false,
          isRead: element?.permissions?.read?.isAllowed ?? false,
          isUpdate: element?.permissions?.update?.isAllowed ?? false,
          menuIcon: GetModuleIcon().getModuleIcon(element?.entitlementCode),
          menuLable: GetModuleName().getModuleName(element?.entitlementCode),
          isWorkInOffline: isWorkInOffline,
          isVisible: isVisible,
          multiModuleEntitlementCode: element?.entitlementCode,
          multipleEntitlementsPermissions: multipleEntitlements,
          id: GetModuleId().getModuleID(element?.entitlementCode),
        );
      }

      // Helper function to check if any permission is allowed
      bool isAnyPermissionAllowed(Permissions? permissions) {
        return permissions?.create?.isAllowed == true ||
            permissions?.read?.isAllowed == true ||
            permissions?.update?.isAllowed == true ||
            permissions?.delete?.isAllowed == true ||
            permissions?.download?.isAllowed == true;
      }

      // Process each module type
      void processModule({
        required String moduleType,
        required List<String> entitlementCodes,
        required List<String> offlineEntitlementCodes,
        required bool Function(List<EntitlementPermissions>) visibilityCheck,
      }) {
        List<EntitlementPermissions> moduleList = entitlementPermissionsApiList
            .where(
              (element) => entitlementCodes.contains(element.entitlementCode),
            )
            .toList();

        if (moduleList.isNotEmpty) {
          List<String> entitlementCodeUiList = moduleList
              .map((e) => e.entitlementCode!)
              .toList();

          List<EntitlementPermissionsUiModel> multipleEntitlements = moduleList
              .where((element) => isAnyPermissionAllowed(element.permissions))
              .map(
                (element) => createUiModel(
                  element: element,
                  entitlementCodeUiList: entitlementCodeUiList,
                ),
              )
              .toList();

          bool isVisible = visibilityCheck(moduleList);
          bool? isWorkInOffline =
              GetModuleNamesWorkInOffline().getModuleNameWorkOffline(
                    offlineEntitlementCodes.first,
                  ) !=
                  null
              ? (GetModuleNamesWorkInOffline().getModuleNameWorkOffline(
                          offlineEntitlementCodes.first,
                        ) !=
                        null &&
                    (GetModuleNamesWorkInOffline().getModuleNameWorkOffline(
                          offlineEntitlementCodes.first,
                        ) ==
                        true))
              : false;

          //CustomLogger.logPrint('entitlementCode ${moduleList.first.entitlementCode} ${GetModuleNamesWorkInOffline().getModuleNameWorkOffline(moduleList.first.entitlementCode)}');
          //CustomLogger.logPrint('permissions ${moduleList.first.entitlementCode}${moduleList.first.permissions?.create?.isAllowed}');
          //CustomLogger.logPrint('isWorkInOffline ${isWorkInOffline}');

          entitlementPermissionsUiModelList.add(
            createUiModel(
              element: moduleList.first,
              entitlementCodeUiList: entitlementCodeUiList,
              isWorkInOffline: isWorkInOffline,
              isVisible: isVisible,
              multipleEntitlements: multipleEntitlements,
            ),
          );
        }
      }

      // Process Work Permit
      processModule(
        moduleType: 'Work Permit',
        offlineEntitlementCodes: [EntitlementsCode.WORK_PERMIT],
        entitlementCodes: [
          EntitlementsCode.WORK_PERMIT,
          EntitlementsCode.WORK_PERMIT_APPROVAL,
          EntitlementsCode.WORK_PERMIT_AUDIT,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) => isAnyPermissionAllowed(element.permissions),
        ),
      );

      // Process Checklist
      processModule(
        moduleType: 'Checklist',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_CHECKLIST],
        entitlementCodes: [
          EntitlementsCode.MOBILE_CHECKLIST,
          EntitlementsCode.MOBILE_CHECKLIST_APPROVAL,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) =>
              element.permissions?.create?.isAllowed == true ||
              element.permissions?.read?.isAllowed == true ||
              element.permissions?.update?.isAllowed == true,
        ),
      );

      // Process Scoring Point
      processModule(
        moduleType: 'Project Scoring',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_SCORING],
        entitlementCodes: [
          EntitlementsCode.MOBILE_SCORING,
          EntitlementsCode.MOBILE_SCORING_APPROVAL,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) =>
              element.permissions?.create?.isAllowed == true ||
              element.permissions?.read?.isAllowed == true ||
              element.permissions?.update?.isAllowed == true,
        ),
      );

      // Process Scoring Point
      processModule(
        moduleType: 'Work Inspection',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_WORK_INSPECTION],
        entitlementCodes: [
          EntitlementsCode.MOBILE_WORK_INSPECTION,
          EntitlementsCode.MOBILE_WORK_INSPECTION_APPROVAL,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) =>
              element.permissions?.create?.isAllowed == true ||
              element.permissions?.read?.isAllowed == true ||
              element.permissions?.update?.isAllowed == true,
        ),
      );
      processModule(
        moduleType: 'Material Inspection',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_MATERIAL_INSPECTION],
        entitlementCodes: [
          EntitlementsCode.MOBILE_MATERIAL_INSPECTION,
          EntitlementsCode.MOBILE_MATERIAL_INSPECTION_APPROVAL,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) =>
              element.permissions?.create?.isAllowed == true ||
              element.permissions?.read?.isAllowed == true ||
              element.permissions?.update?.isAllowed == true,
        ),
      );
      processModule(
        moduleType: 'Quality Inspection',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_QUALITY_INSPECTION],
        entitlementCodes: [
          EntitlementsCode.MOBILE_QUALITY_INSPECTION,
          EntitlementsCode.MOBILE_QUALITY_INSPECTION_APPROVAL,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) =>
              element.permissions?.create?.isAllowed == true ||
              element.permissions?.read?.isAllowed == true ||
              element.permissions?.update?.isAllowed == true,
        ),
      );

      processModule(
        moduleType: 'Home Inspection',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_HOME_INSPECTION],
        entitlementCodes: [
          EntitlementsCode.MOBILE_HOME_INSPECTION,
          EntitlementsCode.MOBILE_HOME_INSPECTION_APPROVAL,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) =>
              element.permissions?.create?.isAllowed == true ||
              element.permissions?.read?.isAllowed == true ||
              element.permissions?.update?.isAllowed == true,
        ),
      );

      // Process Task
      processModule(
        moduleType: 'Task',
        offlineEntitlementCodes: [EntitlementsCode.TASK_ASSIGNOR_BY_ME],
        entitlementCodes: [
          EntitlementsCode.TASK_ASSIGNOR_BY_ME,
          EntitlementsCode.TASK_ASSIGNEE_FOR_ME,
          EntitlementsCode.TASK_MY_ALERT,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) => isAnyPermissionAllowed(element.permissions),
        ),
      );

      // Process Toolbox Training
      processModule(
        moduleType: 'Toolbox Training',
        offlineEntitlementCodes: [EntitlementsCode.TOOLBOX_TRAINING],
        entitlementCodes: [
          EntitlementsCode.TOOLBOX_TRAINING,
          EntitlementsCode.EVENTS,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) => isAnyPermissionAllowed(element.permissions),
        ),
      );

      // Process Incident Report
      processModule(
        moduleType: 'Incident Report',
        offlineEntitlementCodes: [EntitlementsCode.INCIDENT_REPORT],
        entitlementCodes: [
          EntitlementsCode.INCIDENT_REPORT,
          EntitlementsCode.INCIDENT_REPORT_CAPA,
          EntitlementsCode.INCIDENT_REPORT_RCA,
          EntitlementsCode.INCIDENT_CAPA_APPROVER,
          EntitlementsCode.INCIDENT_REVIEWER,
        ],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) => isAnyPermissionAllowed(element.permissions),
        ),
      );

      // Mobile OHS Document
      processModule(
        moduleType: 'Mobile OHS Document',
        offlineEntitlementCodes: [EntitlementsCode.MOBILE_OHS_DOCUMENT],
        entitlementCodes: [EntitlementsCode.MOBILE_OHS_DOCUMENT],
        visibilityCheck: (moduleList) => moduleList.any(
          (element) => isAnyPermissionAllowed(element.permissions),
        ),
      );

      // Process Other Modules
      List<String> otherModuleCodes = [
        EntitlementsCode.INDUCTION_TRAINING,
        EntitlementsCode.SAFETY_ACTIONABLE,
        EntitlementsCode.VIOLATION_DEBITNOTE,
        EntitlementsCode.MANAGE_PROJECTS,
        EntitlementsCode.MANAGE_USERS,
      ];

      for (var entitlementCode in otherModuleCodes) {
        EntitlementPermissions? element = entitlementPermissionsApiList
            .firstWhereOrNull((e) => e.entitlementCode == entitlementCode);

        if (element != null) {
          entitlementPermissionsUiModelList.add(
            createUiModel(
              element: element,
              entitlementCodeUiList: [element.entitlementCode!],
              isWorkInOffline:
                  GetModuleNamesWorkInOffline().getModuleNameWorkOffline(
                    element.entitlementCode,
                  )! &&
                  isAnyPermissionAllowed(element.permissions),
              isVisible: GetModuleVisibility().getModuleVisibility(
                isCreate: element.permissions?.create?.isAllowed,
                isDelete: element.permissions?.delete?.isAllowed,
                isUpdate: element.permissions?.update?.isAllowed,
                isRead: element.permissions?.read?.isAllowed,
                isDownload: element.permissions?.download?.isAllowed,
              ),
            ),
          );
        }
      }

      return entitlementPermissionsUiModelList;
    } catch (e) {
      CustomLogger.logPrint('dashboard mapper exceptions ${e.toString()}');
      return [];
    }
  }
}

class GetQuickActionsEntitlementsList {
  getEntitlementsQuickActionsList({
    List<EntitlementPermissions>? entitlementPermissionsApiList,
  }) {
    try {
      if (entitlementPermissionsApiList != null &&
          entitlementPermissionsApiList.isNotEmpty) {
        List<EntitlementPermissionsUiModel>?
        entitlementPermissionsUiModelQuickActionsList = [];

        List<EntitlementPermissions> workPermitModuleCreate =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode == EntitlementsCode.WORK_PERMIT,
                )
                .toList();

        List<EntitlementPermissions> inductionTrainingCreate =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.INDUCTION_TRAINING,
                )
                .toList();

        List<EntitlementPermissions> safetyActionable =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.SAFETY_ACTIONABLE,
                )
                .toList();

        List<EntitlementPermissions>
        incidentReportModules = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode == EntitlementsCode.INCIDENT_REPORT ||
                  element.entitlementCode ==
                      EntitlementsCode.INCIDENT_REPORT_CAPA ||
                  element.entitlementCode ==
                      EntitlementsCode.INCIDENT_REPORT_RCA ||
                  element.entitlementCode ==
                      EntitlementsCode.INCIDENT_CAPA_APPROVER ||
                  element.entitlementCode == EntitlementsCode.INCIDENT_REVIEWER,
            )
            .toList();

        List<EntitlementPermissions> incidentReportCreateOnly =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.INCIDENT_REPORT,
                )
                .toList();

        List<EntitlementPermissions> workOffline = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode == EntitlementsCode.WORK_PERMIT ||
                  element.entitlementCode ==
                      EntitlementsCode.TOOLBOX_TRAINING ||
                  element.entitlementCode ==
                      EntitlementsCode.INDUCTION_TRAINING,
            )
            .toList();

        List<EntitlementPermissions>
        mobileAttendance = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode ==
                      EntitlementsCode.MOBILE_ATTENDANCE ||
                  element.entitlementCode ==
                      EntitlementsCode.SEARCH_AND_CREATE_MOBILE_ATTENDANCE ||
                  element.entitlementCode == EntitlementsCode.MOBILE_WORK_FORCE,
            )
            .toList();

        //Only QR Scan
        List<EntitlementPermissions> mobileAttendanceQRScanOnly =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_ATTENDANCE,
                )
                .toList();

        List<EntitlementPermissions> searchAndCreateMobileAttendance =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.SEARCH_AND_CREATE_MOBILE_ATTENDANCE,
                )
                .toList();

        List<EntitlementPermissions> todaysWorkForce =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_WORK_FORCE,
                )
                .toList();

        List<EntitlementPermissions> projectLabours =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.PROJECT_LABOUR,
                )
                .toList();

        List<EntitlementPermissions> labourDigitalProfile =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.LABOUR_DIGITAL_PROFILE,
                )
                .toList();

        List<EntitlementPermissions> mobileDashboard =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_DASHBOARD,
                )
                .toList();

        List<EntitlementPermissions> workPermitModules =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode == EntitlementsCode.WORK_PERMIT ||
                      element.entitlementCode ==
                          EntitlementsCode.WORK_PERMIT_APPROVAL ||
                      element.entitlementCode ==
                          EntitlementsCode.WORK_PERMIT_AUDIT,
                )
                .toList();

        List<EntitlementPermissions> workPermitModulesCreate =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode == EntitlementsCode.WORK_PERMIT,
                )
                .toList();

        List<EntitlementPermissions> workPermitApprove =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.WORK_PERMIT_APPROVAL,
                )
                .toList();

        List<EntitlementPermissions> workPermitAudit =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.WORK_PERMIT_AUDIT,
                )
                .toList();

        //visitor scan
        List<EntitlementPermissions> visitorScan = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode == EntitlementsCode.VISITOR_SCAN,
            )
            .toList();

        List<EntitlementPermissionsUiModel>? getMultipleEntitlementsForModules(
          List<EntitlementPermissions> modules,
        ) {
          if (modules.isEmpty) {
            return null;
          }

          List<EntitlementPermissionsUiModel> multipleEntitlementsPermissions =
              [];

          for (var module in modules) {
            final hasPermission =
                module.permissions?.create?.isAllowed == true ||
                module.permissions?.delete?.isAllowed == true ||
                module.permissions?.download?.isAllowed == true ||
                module.permissions?.read?.isAllowed == true ||
                module.permissions?.update?.isAllowed == true;

            if (!hasPermission) {
              continue;
            }

            multipleEntitlementsPermissions.add(
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: [module.entitlementCode ?? ''],
                entitlementName: module.entitlementName,
                multiModuleEntitlementCode: module.entitlementCode,
                moduleCode: module.moduleCode,
                moduleName: module.moduleName,
                isCreate: module.permissions?.create?.isAllowed ?? false,
                isDelete: module.permissions?.delete?.isAllowed ?? false,
                isDownload: module.permissions?.download?.isAllowed ?? false,
                isRead: module.permissions?.read?.isAllowed ?? false,
                isUpdate: module.permissions?.update?.isAllowed ?? false,
              ),
            );
          }

          return multipleEntitlementsPermissions.isEmpty
              ? null
              : multipleEntitlementsPermissions;
        }

        //Face scan
        List<EntitlementPermissions> faceScan = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode == EntitlementsCode.FACE_RECOGNITION,
            )
            .toList();

        //Sync Offline
        List<EntitlementPermissions> workPermit = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode == EntitlementsCode.WORK_PERMIT,
            )
            .toList();

        List<EntitlementPermissions> toolboxTraining =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.TOOLBOX_TRAINING,
                )
                .toList();

        List<EntitlementPermissions> inductionTraining =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.INDUCTION_TRAINING,
                )
                .toList();

        List<EntitlementPermissions> checkList = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode == EntitlementsCode.MOBILE_CHECKLIST,
            )
            .toList();

        List<EntitlementPermissions> projectScoring =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_SCORING,
                )
                .toList();

        List<EntitlementPermissions> workInspection =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_WORK_INSPECTION,
                )
                .toList();

        List<EntitlementPermissions> materialInspection =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_MATERIAL_INSPECTION,
                )
                .toList();

        List<EntitlementPermissions> qualityInspection =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_QUALITY_INSPECTION,
                )
                .toList();

        List<EntitlementPermissions> homeInspection =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                      EntitlementsCode.MOBILE_HOME_INSPECTION,
                )
                .toList();

        List<EntitlementPermissions> task = entitlementPermissionsApiList
            .where(
              (element) =>
                  element.entitlementCode ==
                  EntitlementsCode.TASK_ASSIGNOR_BY_ME,
            )
            .toList();

        List<EntitlementPermissions> tbtAndEventsModules =
            entitlementPermissionsApiList
                .where(
                  (element) =>
                      element.entitlementCode ==
                          EntitlementsCode.TOOLBOX_TRAINING ||
                      element.entitlementCode == EntitlementsCode.EVENTS,
                )
                .toList();

        getOfflineSyncVisibility({
          required bool? isWorkPermitCreate,
          required bool? isInductionTrainingCreate,
          required bool? isToolboxTrainingCreate,
          required bool? isCheckListCreate,
          required bool? isProjectScoringCreate,
          required bool? isWorkInspectionCreate,
          required bool? isMaterialInspectionCreate,
          required bool? isQualityInspectionCreate,
          required bool? isHomeInspectionCreate,
          required bool? isMarkMobileAttendance,
          required bool? isMobileAttendanceSearchAndMark,
          required bool? isTask,
        }) {
          if (isWorkPermitCreate! ||
              isInductionTrainingCreate! ||
              isToolboxTrainingCreate! ||
              isCheckListCreate! ||
              isProjectScoringCreate! ||
              isWorkInspectionCreate! ||
              isMaterialInspectionCreate! ||
              isQualityInspectionCreate! ||
              isHomeInspectionCreate! ||
              isMarkMobileAttendance! ||
              isMobileAttendanceSearchAndMark! ||
              isTask!) {
            return true;
          } else {
            return false;
          }
        }

        //Create Work Permit
        if (workPermitModuleCreate.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = workPermitModuleCreate.first;
          for (var element in workPermitModuleCreate) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                menuIcon: AppIcons().ic_qa_create_workpermit,
                menuLable: AppStrings().create_wp,
                isWorkInOffline: true,
                isVisible: element.permissions!.create!.isAllowed,
                id: 1,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Accepted Work Permit
        if (workPermitModules.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = workPermitModules.first;

          for (var element in workPermitModules) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          getMultipleEntitlementsForWorkPermit(
            List<EntitlementPermissions> workPermitModules,
          ) {
            if (workPermitModules.isNotEmpty) {
              List<EntitlementPermissionsUiModel>?
              multipleEntitlementsPermissions = [];

              for (var workPermitListElement in workPermitModules) {
                EntitlementPermissionsUiModel
                multipleEntitlementPermissions = EntitlementPermissionsUiModel(
                  entitlementCodeUiList: entitlementCodeUiList,
                  entitlementName: workPermitListElement.entitlementName,
                  multiModuleEntitlementCode:
                      workPermitListElement.entitlementCode,
                  moduleCode: workPermitListElement.moduleCode,
                  moduleName: workPermitListElement.moduleName,
                  isCreate:
                      workPermitListElement.permissions!.create!.isAllowed,
                  isDelete:
                      workPermitListElement.permissions!.delete!.isAllowed,
                  isDownload:
                      workPermitListElement.permissions!.download!.isAllowed,
                  isRead: workPermitListElement.permissions!.read!.isAllowed,
                  isUpdate:
                      workPermitListElement.permissions!.update!.isAllowed,
                );

                if (workPermitListElement.permissions!.create!.isAllowed! ||
                    workPermitListElement.permissions!.delete!.isAllowed! ||
                    workPermitListElement.permissions!.download!.isAllowed! ||
                    workPermitListElement.permissions!.read!.isAllowed! ||
                    workPermitListElement.permissions!.update!.isAllowed!) {
                  multipleEntitlementsPermissions.add(
                    multipleEntitlementPermissions,
                  );
                }
              }
              EntitlementPermissionsUiModel?
              entitlementPermissionsWorkPermitCreate =
                  multipleEntitlementsPermissions.firstWhereOrNull(
                    (element) =>
                        element.multiModuleEntitlementCode ==
                        EntitlementsCode.WORK_PERMIT,
                  );

              //Only Create // Only Update
              if (entitlementPermissionsWorkPermitCreate != null) {
                if ((entitlementPermissionsWorkPermitCreate.isCreate!) &&
                        !(entitlementPermissionsWorkPermitCreate.isUpdate!) ||
                    (!entitlementPermissionsWorkPermitCreate.isCreate!) &&
                        (entitlementPermissionsWorkPermitCreate.isUpdate!)) {
                  entitlementPermissionsWorkPermitCreate.isCreate = false;
                  entitlementPermissionsWorkPermitCreate.isUpdate = false;
                }
              }
              return multipleEntitlementsPermissions;
            } else {
              return null;
            }
          }

          getWorkPermitVisibility(
            Permissions? workPermitCreate,
            Permissions? workPermitApprove,
            Permissions? workPermitAudit,
          ) {
            if (workPermitCreate != null &&
                (workPermitCreate.create!.isAllowed! ||
                    workPermitCreate.read!.isAllowed! ||
                    workPermitCreate.update!.isAllowed!)) {
              return true;
            } else if (workPermitApprove != null &&
                (workPermitApprove!.create!.isAllowed! ||
                    workPermitApprove.read!.isAllowed! ||
                    workPermitApprove.update!.isAllowed!)) {
              return true;
            } else if (workPermitAudit != null &&
                (workPermitAudit!.create!.isAllowed! ||
                    workPermitAudit.read!.isAllowed! ||
                    workPermitAudit.update!.isAllowed!)) {
              return true;
            } else {
              return false;
            }
          }

          //Main Module
          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                menuIcon: AppIcons().ic_accepted_workpermit,
                menuLable: AppStrings().accepted_wp,
                isWorkInOffline: false,
                isVisible: getWorkPermitVisibility(
                  workPermitModulesCreate.isNotEmpty
                      ? workPermitModulesCreate.first.permissions
                      : null,
                  workPermitApprove.isNotEmpty
                      ? workPermitApprove.first.permissions
                      : null,
                  workPermitAudit.isNotEmpty
                      ? workPermitAudit.first.permissions
                      : null,
                ),
                multipleEntitlementsPermissions:
                    getMultipleEntitlementsForWorkPermit(workPermitModules),
                id: 2,
              );

          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Create Worker
        if (inductionTrainingCreate.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = inductionTrainingCreate.first;
          for (var element in inductionTrainingCreate) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                menuIcon: AppIcons().ic_add_labor,
                menuLable: AppStrings().add_labor,
                isWorkInOffline: true,
                isVisible: element.permissions!.create!.isAllowed!
                    ? true
                    : false,
                id: 3,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Capture Safety Observation
        if (safetyActionable.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions? element = safetyActionable.firstWhereOrNull(
            (element) =>
                element.entitlementCode == EntitlementsCode.SAFETY_ACTIONABLE,
          );
          for (var element in safetyActionable) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          if (element != null) {
            EntitlementPermissionsUiModel entitlementPermissionsUiModel =
                EntitlementPermissionsUiModel(
                  entitlementCodeUiList: entitlementCodeUiList,
                  entitlementName: element.entitlementName,
                  moduleCode: element.moduleCode,
                  moduleName: element.moduleName,
                  isCreate: element.permissions!.create!.isAllowed,
                  isDelete: element.permissions!.delete!.isAllowed,
                  isDownload: element.permissions!.download!.isAllowed,
                  isRead: element.permissions!.read!.isAllowed,
                  isUpdate: element.permissions!.update!.isAllowed,
                  menuIcon: AppIcons().ic_create_safety_actionable,
                  menuLable: AppStrings().create_safety_actionable,
                  isWorkInOffline: true,
                  isVisible: element.permissions!.create!.isAllowed!
                      ? true
                      : false,
                  id: 4,
                );
            entitlementPermissionsUiModelQuickActionsList.add(
              entitlementPermissionsUiModel,
            );
          }
        }

        //Capture Incident Report
        if (incidentReportCreateOnly.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions? element = incidentReportCreateOnly
              .firstWhereOrNull(
                (element) =>
                    element.entitlementCode == EntitlementsCode.INCIDENT_REPORT,
              );
          for (var element in incidentReportCreateOnly) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          getMultipleEntitlementsForIncidentReport(
            List<EntitlementPermissions> incidentReportModules,
          ) {
            if (incidentReportModules.isNotEmpty) {
              List<EntitlementPermissionsUiModel>?
              multipleEntitlementsPermissions = [];

              for (var incidentReportModulesListElement
                  in incidentReportModules) {
                EntitlementPermissionsUiModel multipleEntitlementPermissions =
                    EntitlementPermissionsUiModel(
                      entitlementCodeUiList: entitlementCodeUiList,
                      entitlementName:
                          incidentReportModulesListElement.entitlementName,
                      multiModuleEntitlementCode:
                          incidentReportModulesListElement.entitlementCode,
                      moduleCode: incidentReportModulesListElement.moduleCode,
                      moduleName: incidentReportModulesListElement.moduleName,
                      isCreate: incidentReportModulesListElement
                          .permissions!
                          .create!
                          .isAllowed,
                      isDelete: incidentReportModulesListElement
                          .permissions!
                          .delete!
                          .isAllowed,
                      isDownload: incidentReportModulesListElement
                          .permissions!
                          .download!
                          .isAllowed,
                      isRead: incidentReportModulesListElement
                          .permissions!
                          .read!
                          .isAllowed,
                      isUpdate: incidentReportModulesListElement
                          .permissions!
                          .update!
                          .isAllowed,
                    );

                multipleEntitlementsPermissions.add(
                  multipleEntitlementPermissions,
                );
              }

              return multipleEntitlementsPermissions;
            } else {
              return null;
            }
          }

          if (element != null) {
            EntitlementPermissionsUiModel entitlementPermissionsUiModel =
                EntitlementPermissionsUiModel(
                  entitlementCodeUiList: entitlementCodeUiList,
                  entitlementName: element.entitlementName,
                  moduleCode: element.moduleCode,
                  moduleName: element.moduleName,
                  isCreate: element.permissions!.create!.isAllowed,
                  isDelete: element.permissions!.delete!.isAllowed,
                  isDownload: element.permissions!.download!.isAllowed,
                  isRead: element.permissions!.read!.isAllowed,
                  isUpdate: element.permissions!.update!.isAllowed,
                  menuIcon: AppIcons().ic_create_incident_report,
                  menuLable: AppStrings().create_incident_report,
                  isWorkInOffline: false,
                  multipleEntitlementsPermissions:
                      getMultipleEntitlementsForIncidentReport(
                        incidentReportModules,
                      ),
                  isVisible: element.permissions!.create!.isAllowed!
                      ? true
                      : false,
                  id: 5,
                );
            entitlementPermissionsUiModelQuickActionsList.add(
              entitlementPermissionsUiModel,
            );
          }
        }

        //Create TBT
        if (workOffline.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions? element = workOffline.firstWhereOrNull(
            (element) =>
                element.entitlementCode == EntitlementsCode.TOOLBOX_TRAINING,
          );
          for (var element in workOffline) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          getMultipleEntitlementsForTBTAndEvents(
            List<EntitlementPermissions> tbtAndEventModules,
          ) {
            if (incidentReportModules.isNotEmpty) {
              List<EntitlementPermissionsUiModel>?
              multipleEntitlementsPermissions = [];

              for (var tbtAndEventModulesListElement in tbtAndEventModules) {
                EntitlementPermissionsUiModel multipleEntitlementPermissions =
                    EntitlementPermissionsUiModel(
                      entitlementCodeUiList: entitlementCodeUiList,
                      entitlementName:
                          tbtAndEventModulesListElement.entitlementName,
                      multiModuleEntitlementCode:
                          tbtAndEventModulesListElement.entitlementCode,
                      moduleCode: tbtAndEventModulesListElement.moduleCode,
                      moduleName: tbtAndEventModulesListElement.moduleName,
                      isCreate: tbtAndEventModulesListElement
                          .permissions!
                          .create!
                          .isAllowed,
                      isDelete: tbtAndEventModulesListElement
                          .permissions!
                          .delete!
                          .isAllowed,
                      isDownload: tbtAndEventModulesListElement
                          .permissions!
                          .download!
                          .isAllowed,
                      isRead: tbtAndEventModulesListElement
                          .permissions!
                          .read!
                          .isAllowed,
                      isUpdate: tbtAndEventModulesListElement
                          .permissions!
                          .update!
                          .isAllowed,
                    );

                multipleEntitlementsPermissions.add(
                  multipleEntitlementPermissions,
                );
              }

              return multipleEntitlementsPermissions;
            } else {
              return null;
            }
          }

          if (element != null) {
            EntitlementPermissionsUiModel
            entitlementPermissionsUiModel = EntitlementPermissionsUiModel(
              entitlementCodeUiList: entitlementCodeUiList,
              entitlementName: element.entitlementName,
              moduleCode: element.moduleCode,
              moduleName: element.moduleName,
              isCreate: element.permissions!.create!.isAllowed,
              isDelete: element.permissions!.delete!.isAllowed,
              isDownload: element.permissions!.download!.isAllowed,
              isRead: element.permissions!.read!.isAllowed,
              isUpdate: element.permissions!.update!.isAllowed,
              menuIcon: AppIcons().ic_create_tbt,
              menuLable: AppStrings().create_tbt,
              isWorkInOffline: true,
              multipleEntitlementsPermissions:
                  getMultipleEntitlementsForTBTAndEvents(tbtAndEventsModules),
              isVisible: element.permissions!.create!.isAllowed! ? true : false,
              id: 7,
            );
            entitlementPermissionsUiModelQuickActionsList.add(
              entitlementPermissionsUiModel,
            );
          }
        }

        //Scan QR
        if (mobileAttendance.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions mobileQRScan = mobileAttendance.first;

          for (var mobileQRScan in mobileAttendance) {
            entitlementCodeUiList.add(mobileQRScan.entitlementCode!);
          }

          EntitlementPermissions? elementSearchAndCreateAttendance;
          EntitlementPermissions? todaysMobileWorkForce;
          EntitlementPermissions? mobileAttendanceQRScan;

          if (mobileAttendanceQRScanOnly.isNotEmpty) {
            mobileAttendanceQRScan = mobileAttendanceQRScanOnly.first;
          }

          if (searchAndCreateMobileAttendance.isNotEmpty) {
            elementSearchAndCreateAttendance =
                searchAndCreateMobileAttendance.first;
          }

          if (todaysWorkForce.isNotEmpty) {
            todaysMobileWorkForce = todaysWorkForce.first;
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: mobileQRScan.entitlementName,
                moduleCode: mobileQRScan.moduleCode,
                moduleName: mobileQRScan.moduleName,
                isCreate: mobileAttendanceQRScan != null
                    ? mobileAttendanceQRScan.permissions?.create?.isAllowed
                    : false,
                isDelete: mobileQRScan.permissions!.delete!.isAllowed,
                isDownload: mobileQRScan.permissions!.download!.isAllowed,
                isRead: mobileQRScan.permissions!.read!.isAllowed,
                isUpdate: mobileQRScan.permissions!.update!.isAllowed,
                isSearchAndUpdate: elementSearchAndCreateAttendance != null
                    ? elementSearchAndCreateAttendance
                          .permissions!
                          .create!
                          .isAllowed!
                    : false,
                isMobileWorkForce: todaysMobileWorkForce != null
                    ? todaysMobileWorkForce.permissions!.read!.isAllowed!
                    : false,
                multipleEntitlementsPermissions:
                    getMultipleEntitlementsForModules(labourDigitalProfile),
                menuIcon: AppIcons().ic_scan_qr_code,
                menuLable: AppStrings().scan_id_qr,
                isWorkInOffline: true,
                // isVisible: false,
                isVisible:
                    (mobileAttendanceQRScan?.permissions?.create?.isAllowed ??
                        false) ||
                    (elementSearchAndCreateAttendance
                            ?.permissions
                            ?.create
                            ?.isAllowed ??
                        false),
                // isVisible: _getModuleVisibility(
                //     isCreate: element.permissions!.create!.isAllowed,
                //     isDelete: element.permissions!.delete!.isAllowed,
                //     isUpdate: element.permissions!.update!.isAllowed,
                //     isRead: element.permissions!.read!.isAllowed,
                //     isDownload:
                //         element.permissions!.download!.isAllowed),
                id: 8,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Mobile Work Force Report
        if (todaysWorkForce.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = todaysWorkForce.first;
          for (var element in todaysWorkForce) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissions?
          elementSearchAndCreateAttendanceForMobileWorkForce;
          EntitlementPermissions? todaysMobileWorkForce;

          if (searchAndCreateMobileAttendance.isNotEmpty) {
            elementSearchAndCreateAttendanceForMobileWorkForce =
                searchAndCreateMobileAttendance.first;
          }
          if (todaysWorkForce.isNotEmpty) {
            todaysMobileWorkForce = todaysWorkForce.first;
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                isSearchAndUpdate:
                    elementSearchAndCreateAttendanceForMobileWorkForce != null
                    ? elementSearchAndCreateAttendanceForMobileWorkForce!
                          .permissions!
                          .create!
                          .isAllowed!
                    : false,
                isMobileWorkForce: todaysMobileWorkForce != null
                    ? todaysMobileWorkForce.permissions!.read!.isAllowed!
                    : false,
                menuIcon: AppIcons().ic_work_force,
                menuLable: AppStrings().todays_work_force,
                isWorkInOffline: true,
                // isVisible: false,
                isVisible: todaysMobileWorkForce != null
                    ? todaysMobileWorkForce.permissions!.read!.isAllowed!
                    : false,
                // isVisible: _getModuleVisibility(
                //     isCreate: element.permissions!.create!.isAllowed,
                //     isDelete: element.permissions!.delete!.isAllowed,
                //     isUpdate: element.permissions!.update!.isAllowed,
                //     isRead: element.permissions!.read!.isAllowed,
                //     isDownload:
                //         element.permissions!.download!.isAllowed),
                id: 11,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Project Worker
        if (projectLabours.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions? element = projectLabours.firstWhereOrNull(
            (element) =>
                element.entitlementCode == EntitlementsCode.PROJECT_LABOUR,
          );
          for (var element in projectLabours) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          if (element != null) {
            EntitlementPermissionsUiModel entitlementPermissionsUiModel =
                EntitlementPermissionsUiModel(
                  entitlementCodeUiList: entitlementCodeUiList,
                  entitlementName: element.entitlementName,
                  moduleCode: element.moduleCode,
                  moduleName: element.moduleName,
                  isCreate: element.permissions!.create!.isAllowed,
                  isDelete: element.permissions!.delete!.isAllowed,
                  isDownload: element.permissions!.download!.isAllowed,
                  isRead: element.permissions!.read!.isAllowed,
                  isUpdate: element.permissions!.update!.isAllowed,
                  multipleEntitlementsPermissions:
                      getMultipleEntitlementsForModules(labourDigitalProfile),
                  menuIcon: AppIcons().ic_project_labour,
                  menuLable: AppStrings().project_labours,
                  isWorkInOffline: false,
                  isVisible:
                      (element.permissions!.read!.isAllowed! ||
                          element.permissions!.create!.isAllowed!)
                      ? true
                      : false,
                  id: 9,
                );
            entitlementPermissionsUiModelQuickActionsList.add(
              entitlementPermissionsUiModel,
            );
          }
        }

        //Mobile Dashboard
        if (mobileDashboard.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = mobileDashboard.first;
          for (var element in mobileDashboard) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                menuIcon: AppIcons().ic_dashboard,
                menuLable: AppStrings().dashboard_id,
                isWorkInOffline: false,
                // isVisible: false,
                isVisible: (element.permissions!.read!.isAllowed!),
                id: 10,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Visitor Scan
        if (visitorScan.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = visitorScan.first;
          for (var element in visitorScan) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                isSearchAndUpdate: false,
                isMobileWorkForce: false,
                menuIcon: AppIcons().ic_visitor_scan,
                menuLable: AppStrings().visitor_scan,
                isWorkInOffline: false,
                // isVisible: false,
                isVisible:
                    (element.permissions!.create!.isAllowed! ||
                    element.permissions!.update!.isAllowed!),
                id: 12,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Face Scan
        if (faceScan.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = faceScan.first;
          for (var element in faceScan) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                isSearchAndUpdate: false,
                isMobileWorkForce: false,
                menuIcon: AppIcons().ic_face_scan,
                menuLable: AppStrings().face_scan,
                isWorkInOffline: false,
                // isVisible: false,
                isVisible:
                    (element.permissions!.create!.isAllowed! ||
                    element.permissions!.update!.isAllowed!),
                id: 13,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        //Offline Sync
        if (workOffline.isNotEmpty) {
          List<String> entitlementCodeUiList = [];
          EntitlementPermissions element = workOffline.first;
          for (var element in workOffline) {
            entitlementCodeUiList.add(element.entitlementCode!);
          }

          EntitlementPermissionsUiModel entitlementPermissionsUiModel =
              EntitlementPermissionsUiModel(
                entitlementCodeUiList: entitlementCodeUiList,
                entitlementName: element.entitlementName,
                moduleCode: element.moduleCode,
                moduleName: element.moduleName,
                isCreate: element.permissions!.create!.isAllowed,
                isDelete: element.permissions!.delete!.isAllowed,
                isDownload: element.permissions!.download!.isAllowed,
                isRead: element.permissions!.read!.isAllowed,
                isUpdate: element.permissions!.update!.isAllowed,
                menuIcon: AppIcons().ic_sync_offline,
                menuLable: AppStrings().sync_offline,
                customOfflineSyncModule: CustomOfflineSyncModule(
                  isWorkPermit: workPermit.isNotEmpty
                      ? workPermit.first.permissions!.create!.isAllowed!
                      : false,
                  isCheckList: checkList.isNotEmpty
                      ? checkList.first.permissions!.create!.isAllowed!
                      : false,
                  isProjectScoring: projectScoring.isNotEmpty
                      ? projectScoring.first.permissions!.create!.isAllowed!
                      : false,
                  //isCheckList: false,
                  isQRCodeScan: mobileAttendance.isNotEmpty
                      ? mobileAttendance.first.permissions!.create!.isAllowed
                      : false,
                  isInductionTraining: inductionTraining.isNotEmpty
                      ? inductionTraining.first.permissions!.create!.isAllowed!
                      : false,
                  isSearchAndMarkAttendance:
                      searchAndCreateMobileAttendance.isNotEmpty
                      ? searchAndCreateMobileAttendance
                            .first
                            .permissions!
                            .create!
                            .isAllowed
                      : false,
                  isToolBoxTraining: toolboxTraining.isNotEmpty
                      ? toolboxTraining.first.permissions!.create!.isAllowed!
                      : false,
                  isTask: task.isNotEmpty
                      ? task.first.permissions!.create!.isAllowed!
                      : false,
                  isSafetyObservation: safetyActionable.isNotEmpty
                      ? safetyActionable.first.permissions!.create!.isAllowed!
                      : false,
                ),
                isWorkInOffline: GetModuleVisibility().getModuleVisibility(
                  isCreate: element.permissions!.create!.isAllowed,
                  isDelete: element.permissions!.delete!.isAllowed,
                  isUpdate: element.permissions!.update!.isAllowed,
                  isRead: element.permissions!.read!.isAllowed,
                  isDownload: element.permissions!.download!.isAllowed,
                ),
                //isVisible: false,
                isVisible: getOfflineSyncVisibility(
                  isTask: task.isNotEmpty
                      ? task.first.permissions!.create!.isAllowed!
                      : false,
                  isWorkPermitCreate: workPermit.isNotEmpty
                      ? workPermit.first.permissions!.create!.isAllowed!
                      : false,
                  isInductionTrainingCreate: inductionTraining.isNotEmpty
                      ? inductionTraining.first.permissions!.create!.isAllowed!
                      : false,
                  isCheckListCreate: checkList.isNotEmpty
                      ? checkList.first.permissions!.create!.isAllowed!
                      : false,
                  isProjectScoringCreate: projectScoring.isNotEmpty
                      ? projectScoring.first.permissions!.create!.isAllowed!
                      : false,
                  isWorkInspectionCreate: workInspection.isNotEmpty
                      ? workInspection.first.permissions!.create!.isAllowed!
                      : false,
                  isMaterialInspectionCreate: materialInspection.isNotEmpty
                      ? materialInspection.first.permissions!.create!.isAllowed!
                      : false,
                  isQualityInspectionCreate: qualityInspection.isNotEmpty
                      ? qualityInspection.first.permissions!.create!.isAllowed!
                      : false,
                  isHomeInspectionCreate: homeInspection.isNotEmpty
                      ? homeInspection.first.permissions!.create!.isAllowed!
                      : false,

                  //isCheckListCreate: false,
                  isToolboxTrainingCreate: toolboxTraining.isNotEmpty
                      ? toolboxTraining.first.permissions!.create!.isAllowed
                      : false,
                  isMarkMobileAttendance: mobileAttendance.isNotEmpty
                      ? mobileAttendance.first.permissions!.create!.isAllowed
                      : false,
                  isMobileAttendanceSearchAndMark:
                      searchAndCreateMobileAttendance.isNotEmpty
                      ? searchAndCreateMobileAttendance
                            .first
                            .permissions!
                            .create!
                            .isAllowed
                      : false,
                ),
                id: 6,
              );
          entitlementPermissionsUiModelQuickActionsList.add(
            entitlementPermissionsUiModel,
          );
        }

        return entitlementPermissionsUiModelQuickActionsList;
      } else {
        return null;
      }
    } catch (e) {
      CustomLogger.logPrint('quick actions mapper exceptions');
      return [];
    }
  }
}

class GeofencingMapper {
  GeofencingUiModel getGeofencingMapper({
    required GeofencingApiModel? apiModel,
    required int? statusCode,
  }) {
    if (statusCode == 200 || statusCode == 201) {
      if (apiModel != null) {
        return GeofencingUiModel(
          success: apiModel.success ?? false,
          isWithinGeofence: apiModel.isWithinGeofence,
          distance: apiModel.distance,
          allowedRadius: apiModel.allowedRadius,
          message: apiModel.message,
          distanceWarning: apiModel.distanceWarning,
          geofencingActive: apiModel.geofencingActive,
          statusCode: statusCode,
        );
      } else {
        return GeofencingUiModel(
          success: false,
          message: AppStrings().data_not_found,
          statusCode: statusCode,
        );
      }
    } else {
      return GeofencingUiModel(
        success: false,
        message: AppStrings().data_not_found,
        statusCode: statusCode,
      );
    }
  }
}
