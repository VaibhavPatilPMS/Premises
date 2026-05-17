import 'package:hive_ce/hive_ce.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/hive_local_db/hive_local_db.dart';

class HiveDashboardService {
  static Box entitlementBox = HiveBoxes.getEntitlementsBox();
  static Box pendingTaskBox = HiveBoxes.getPendingTaskBox();
  static Box globalConfigurations = HiveBoxes.getGlobalConfigurationsBox();
  static Box offlineSyncStatusBox = HiveBoxes.getOfflineSyncStatusBox();

  // To add Entitlements
  static putEntitlements(String? projectCode,
      EntitlementPermissionsApiModel? entitlementPermissionsApiModel) async {
    try {
      await entitlementBox.put(projectCode, entitlementPermissionsApiModel);
    } catch (e) {
      //CustomLogger.logPrint('exceptions putEntitlements ${e.toString()}');
    }
  }

  // To Get Entitlements
  static Future<EntitlementPermissionsApiModel?> getProjectEntitlements(
      String? projectCode) async {
    try {
      return await entitlementBox.get(projectCode);
    } catch (e) {
      //CustomLogger.logPrint('exceptions getProjectEntitlements ${e.toString()}');
      return null;
    }
  }

  // To add Global Configurations
  static putGlobalConfigurations(String? projectCode,
      GlobalConfigurationsApiModel? globalConfigurationsApiModel) async {
    try {
      await globalConfigurations.put(projectCode, globalConfigurationsApiModel);
    } catch (e) {
      //CustomLogger.logPrint('exceptions putGlobalConfigurations ${e.toString()}');
    }
  }

  // To Get GlobalConfigurations
  static Future<GlobalConfigurationsApiModel?> getGlobalConfigurations(
      String? projectCode) async {
    try {
      return await globalConfigurations.get(projectCode);
    } catch (e) {
      //CustomLogger.logPrint('exceptions getGlobalConfigurations ${e.toString()}');
      return null;
    }
  }

  // To add Global Configurations
  static putOfflineSyncStatusProjectWise(
      String? projectCode, OfflineSyncModel? offlineSyncModel) async {
    try {
      await offlineSyncStatusBox.put(projectCode, offlineSyncModel);
    } catch (e) {
      //CustomLogger.logPrint('exceptions putOfflineSyncStatusProjectWise ${e.toString()}');
    }
  }

  // To Get GlobalConfigurations
  static Future<OfflineSyncModel?> getOfflineSyncStatusProjectWise(
      String? projectCode) async {
    try {
      return await offlineSyncStatusBox.get(projectCode);
    } catch (e) {
      //CustomLogger.logPrint('exceptions getOfflineSyncStatusProjectWise ${e.toString()}');
      return null;
    }
  }

  // To add pending task
  static putPendingTask(
      String? projectCode, PendingTasksApiModel? pendingTasksApiModel) async {
    try {
      await pendingTaskBox.put(projectCode, pendingTasksApiModel);
    } catch (e) {
      //CustomLogger.logPrint('exceptions putPendingTask ${e.toString()}');
    }
  }

  // To Get Pending Task
  static Future<PendingTasksApiModel?> getPendingTask(
      String? projectCode) async {
    try {
      return await pendingTaskBox.get(projectCode);
    } catch (e) {
      //CustomLogger.logPrint('exceptions getPendingTask ${e.toString()}');
      return null;
    }
  }

  static clearAllBoxes() {
    entitlementBox.clear();
    globalConfigurations.clear();
    offlineSyncStatusBox.clear();
    pendingTaskBox.clear();
  }
}
