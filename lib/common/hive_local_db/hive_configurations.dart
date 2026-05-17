import 'package:hive_ce/hive_ce.dart';
import '../utils/utils.dart';

class HiveConfigurations {
  static init() async {
    try {
      // Get your application's file path inside phone
      final directoryPath = await FileUtils.getFileDirectoryPath();

      // Initialize hive database in that file
      Hive.init(directoryPath);

      // Hive.registerAdapter(PendingTasksApiModelAdapter()); //0
      // Hive.registerAdapter(PendingTasksDataApiModelAdapter()); //1
      // Hive.registerAdapter(SkillLevelApiModelAdapter()); //2
      // Hive.registerAdapter(SkillLevelDataApiModelAdapter()); //3
      // Hive.registerAdapter(PolicyTypeApiModelAdapter()); //4
      // Hive.registerAdapter(PolicyTypeDataApiModelAdapter()); //5
      // Hive.registerAdapter(OptionalSafetyTypesApiModelAdapter()); //6
      // Hive.registerAdapter(OptionalSafetyTypeApiDataModelAdapter()); //7

      // Opening database to use

      // try {
      //   await Hive.openBox<PendingTasksApiModel>(HiveBox.PENDING_TASK_BOX);
      // } catch (e) {
      //   CustomLogger.logPrint('Error opening PENDING_TASK_BOX: $e');
      // }

      // try {
      //   await Hive.openBox<SkillLevelApiModel>(HiveBox.INDT_SKILL_LEVELS_BOX);
      // } catch (e) {
      //   CustomLogger.logPrint('Error opening INDT_SKILL_LEVELS_BOX: $e');
      // }

      // try {
      //   await Hive.openBox<PolicyTypeApiModel>(HiveBox.INDT_POLICY_TYPES_BOX);
      // } catch (e) {
      //   CustomLogger.logPrint('Error opening INDT_POLICY_TYPES_BOX: $e');
      // }

    } catch (e) {
      CustomLogger.logPrint('Error in Hive Configurations ${e}');
      await deleteAllBoxes();
      await clearAllData();
    }
  }

  static Future<void> deleteBox(String boxName, {String? path}) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.clear();
      await box.close();
    }
    await Hive.deleteBoxFromDisk(boxName, path: path);
  }

  static Future<void> deleteAllBoxes() async {
    try {
      final directoryPath = await FileUtils.getFileDirectoryPath();

      //Induction Trainings
      await deleteBox(HiveBox.INDT_SKILL_LEVELS_BOX, path: directoryPath);
      await deleteBox(HiveBox.INDT_POLICY_TYPES_BOX, path: directoryPath);
      await deleteBox(HiveBox.PENDING_TASK_BOX, path: directoryPath);

    } catch (e) {
      CustomLogger.logPrint('Error deleting Hive Boxes: $e');
    }
  }

  static Future<void> clearAllData() async {
    await Hive.deleteFromDisk();
  }
}
