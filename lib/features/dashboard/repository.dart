import 'package:retrofit/dio.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/network/network.dart';
import 'package:premises/features/user_management/user_management.dart';

class DashboardRepository {
  final ApiClient? _apiClient;

  DashboardRepository(this._apiClient);

  Future<HttpResponse<EntitlementPermissionsApiModel>> getProjectEntitlements(
      CommonRequestModel requestModel) async {
    return await _apiClient!.getProjectEntitlements(requestModel: requestModel);
  }

  Future<HttpResponse<ProjectImageApiModel>> getProjectPhoto(
      CommonRequestModel requestModel) async {
    return await _apiClient!.getProjectPhoto(requestModel: requestModel);
  }

  Future<HttpResponse<GlobalConfigurationsApiModel>> getGlobalConfigurations(
      CommonRequestModel requestModel) async {
    return await _apiClient!
        .getGlobalConfigurations(requestModel: requestModel);
  }

  Future<HttpResponse<PendingTasksApiModel>> getDashboardPendingCounts(
      CommonRequestModel requestModel) async {
    return await _apiClient!
        .getDashboardPendingCounts(requestModel: requestModel);
  }

  Future<HttpResponse<UserAssignedProjects>> getUserAssignedProjects(
      CommonRequestModel requestModel) async {
    return await _apiClient!
        .getUserAssignedProjects(requestModel: requestModel);
  }

  Future<HttpResponse<GeofencingApiModel>> checkGeofencing(
      GeofencingRequestModel requestModel) async {
    return await _apiClient!
        .checkGeofencing(requestModel: requestModel);
  }
}
