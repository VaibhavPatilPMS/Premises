import 'package:premises/common/base/base.dart';

class EntitlementUiModel extends UiModel {
  bool? success;
  @override
  String? message;
  String? projectCode;
  String? projectId;
  EntitlementDataUiModel? data;

  EntitlementUiModel({
    this.projectCode,
    this.message,
    this.data,
    this.projectId,
    this.success,
  });
}

class EntitlementDataUiModel {
  String? sId;
  String? roleCode;
  String? roleName;
  List<EntitlementPermissionsUiModel>? entitlementPermissionsDashboardMenuList;
  List<EntitlementPermissionsUiModel>? entitlementPermissionsQuickActionsList;
  String? projectImagePath;

  EntitlementDataUiModel({
    this.sId,
    this.roleCode,
    this.roleName,
    this.entitlementPermissionsDashboardMenuList,
    this.entitlementPermissionsQuickActionsList,
    this.projectImagePath,
  });
}

class EntitlementPermissionsUiModel {
  bool? isCreate;
  bool? isDelete;
  bool? isUpdate;
  bool? isRead;
  bool? isDownload;
  bool? isSearchAndUpdate;
  List<String>? entitlementCodeUiList;
  String? entitlementName;
  String? moduleCode;
  String? moduleName;
  int? id;
  String? menuIcon;
  String? menuLable;
  bool? isWorkInOffline;
  bool? isVisible;
  List<EntitlementPermissionsUiModel>? multipleEntitlementsPermissions;
  String? multiModuleEntitlementCode;
  CustomOfflineSyncModule? customOfflineSyncModule;
  bool? isMobileWorkForce;

  EntitlementPermissionsUiModel({
    this.isCreate,
    this.isDelete,
    this.isUpdate,
    this.isRead,
    this.isDownload,
    this.entitlementCodeUiList,
    this.entitlementName,
    this.moduleCode,
    this.moduleName,
    this.id,
    this.menuIcon,
    this.menuLable,
    this.isWorkInOffline,
    this.multipleEntitlementsPermissions,
    this.multiModuleEntitlementCode,
    this.customOfflineSyncModule,
    this.isSearchAndUpdate,
    this.isVisible,
    this.isMobileWorkForce,
  });
}

class CustomOfflineSyncModule {
  final bool? isWorkPermit;
  final bool? isCheckList;
  final bool? isSafetyObservation;
  final bool? isProjectScoring;
  final bool? isWorkInspection;
  final bool? isMaterialInspection;
  final bool? isQualityInspection;
  final bool? isHomeInspection;
  final bool? isQRCodeScan;
  final bool? isInductionTraining;
  final bool? isSearchAndMarkAttendance;
  final bool? isToolBoxTraining;
  final bool? isTask;

  CustomOfflineSyncModule({
    this.isWorkPermit = false,
    this.isCheckList = false,
    this.isSafetyObservation = false,
    this.isQRCodeScan = false,
    this.isProjectScoring = false,
    this.isWorkInspection = false,
    this.isMaterialInspection = false,
    this.isQualityInspection = false,
    this.isHomeInspection = false,
    this.isInductionTraining = false,
    this.isSearchAndMarkAttendance = false,
    this.isToolBoxTraining = false,
    this.isTask = false,
  });

  bool isAnyModuleEnabled() {
    return isWorkPermit! ||
        isCheckList! ||
        isSafetyObservation! ||
        isProjectScoring! ||
        isWorkInspection! ||
        isMaterialInspection! ||
        isQualityInspection! ||
        isHomeInspection! ||
        isQRCodeScan! ||
        isInductionTraining! ||
        isSearchAndMarkAttendance! ||
        isToolBoxTraining! ||
        isTask!;
  }
}
