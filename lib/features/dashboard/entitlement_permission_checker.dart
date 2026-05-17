import 'package:collection/collection.dart';
import 'package:premises/common/models/models.dart';

class EntitlementPermissionChecker {
  // Check if user has create permission for specific entitlement
  bool hasCreatePermissionForSingleModule(
      List<EntitlementPermissionsUiModel> entitlementsList,
      String entitlementCode) {
    final entitlement = entitlementsList.firstWhere(
      (e) => e.multiModuleEntitlementCode == entitlementCode,
      orElse: () => EntitlementPermissionsUiModel(),
    );

    return entitlement.isCreate ?? false;
  }

  // Check if user has create permission for specific entitlement
  bool hasCreatePermissionForMultipleModule(
      List<EntitlementPermissionsUiModel> entitlementsList,
      String entitlementCode) {
    final entitlement = entitlementsList.firstWhereOrNull(
      (e) =>
          e.multipleEntitlementsPermissions
              ?.firstWhereOrNull((element) =>
                  element.multiModuleEntitlementCode == entitlementCode)
              ?.isCreate ??
          false,
    );

    return entitlement?.isCreate ?? false;
  }
}
