import 'package:premises/common/base/base.dart';
import 'package:retrofit/dio.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/network/network.dart';
import 'package:premises/features/dashboard/dashboard.dart';

class ProjectEntitlementsUseCase
    extends UseCase<CommonRequestModel, ResponseModel<EntitlementUiModel>> {
  final DashboardRepository? _repository;
  final EntitlementsMapper? _mapper;
  final NetworkInfoImpl? _networkInfo;

  ProjectEntitlementsUseCase(this._repository, this._mapper, this._networkInfo);

  @override
  Future<ResponseModel<EntitlementUiModel>> execute({
    RequestModel<CommonRequestModel>? request,
  }) async {
    if (_networkInfo!.isConnected) {
      HttpResponse<ProjectImageApiModel?>? projectImageApiModel;

      return await _repository!
          .getProjectEntitlements(request!.model)
          .then((value) async {
        // Create ui model from api model using mapper.
        if (value.response.statusCode == 200 ||
            value.response.statusCode == 201) {
          projectImageApiModel =
              await _repository.getProjectPhoto(request.model);

          OfflineSyncModel? offlineSyncStatusModel =
              await HiveDashboardService.getOfflineSyncStatusProjectWise(
                  request.model.projectcode);

          HiveDashboardService.putEntitlements(
              request.model.projectcode, value.data);

          HiveDashboardService.putOfflineSyncStatusProjectWise(
              request.model.projectcode,
              OfflineSyncModel(
                  projectCode: request.model.projectcode,
                  isOfflineModuleDataSync: offlineSyncStatusModel != null
                      ? offlineSyncStatusModel.isOfflineModuleDataSync
                      : false,
                  isEntitlementsDataSync: true));
        }

        EntitlementUiModel? uiModel = _mapper!.getProjectEntitlementsMapper(
            statusCode: value.response.statusCode,
            entitlementPermissionsApiModel: value.data,
            projectImageData: projectImageApiModel?.data?.data);
        // Create response model with UiModel for provider.

        return ResponseModel<EntitlementUiModel>(
          data: uiModel,
          message: uiModel?.message,
          statusCode: value.response.statusCode,
          isSuccess: uiModel?.success,
        );
      }).catchError((Object obj) {
        return ErrorBuilder<EntitlementUiModel>().getErrorResponseModel(obj);
      });
    } else {
      EntitlementPermissionsApiModel? entitlementPermissionsApiModel =
          await HiveDashboardService.getProjectEntitlements(
              request!.model.projectcode);

      EntitlementUiModel? uiModel = _mapper!.getProjectEntitlementsMapper(
          statusCode: 200,
          entitlementPermissionsApiModel: entitlementPermissionsApiModel,
          projectImageData: null);

      return ResponseModel<EntitlementUiModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: 200,
        isSuccess: uiModel?.success,
      );
    }
  }
}

class GlobalConfigurationsUseCase extends UseCase<CommonRequestModel,
    ResponseModel<GlobalConfigurationsUiModel>> {
  final DashboardRepository? _repository;
  final GlobalConfigurationMapper? _mapper;
  final NetworkInfoImpl? _networkInfo;

  GlobalConfigurationsUseCase(
      this._repository, this._mapper, this._networkInfo);

  @override
  Future<ResponseModel<GlobalConfigurationsUiModel>> execute({
    RequestModel<CommonRequestModel>? request,
  }) async {
    if (_networkInfo!.isConnected) {
      return await _repository!
          .getGlobalConfigurations(request!.model)
          .then((value) {
        // Create ui model from api model using mapper.
        if (value.response.statusCode == 200 ||
            value.response.statusCode == 201) {
          HiveDashboardService.putGlobalConfigurations(
              request.model.projectcode, value.data);
        }
        GlobalConfigurationsUiModel? uiModel = _mapper!
            .getGlobalConfigurationMapper(
                statusCode: value.response.statusCode,
                globalConfigurationsApiModel: value.data);
        // Create response model with UiModel for provider.
        return ResponseModel<GlobalConfigurationsUiModel>(
          data: uiModel,
          message: uiModel?.message,
          statusCode: value.response.statusCode,
          isSuccess: uiModel?.success,
        );
      }).catchError((Object obj) {
        return ErrorBuilder<GlobalConfigurationsUiModel>()
            .getErrorResponseModel(obj);
      });
    } else {
      GlobalConfigurationsApiModel? globalConfigurationsApiModel =
          await HiveDashboardService.getGlobalConfigurations(
              request!.model.projectcode);

      GlobalConfigurationsUiModel? uiModel = _mapper!
          .getGlobalConfigurationMapper(
              statusCode: 200,
              globalConfigurationsApiModel: globalConfigurationsApiModel);
      // Create response model with UiModel for provider.
      return ResponseModel<GlobalConfigurationsUiModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: 200,
        isSuccess: uiModel?.success,
      );
    }
  }
}

class DashboardPendingCountUseCase
    extends UseCase<CommonRequestModel, ResponseModel<PendingTasksUIModel>> {
  final DashboardRepository? _repository;
  final GetDashboardPendingCountsMapper? _mapper;
  final NetworkInfoImpl? _networkInfo;

  DashboardPendingCountUseCase(
      this._repository, this._mapper, this._networkInfo);

  @override
  Future<ResponseModel<PendingTasksUIModel>> execute({
    RequestModel<CommonRequestModel>? request,
  }) async {
    if (_networkInfo!.isConnected) {
      return await _repository!
          .getDashboardPendingCounts(request!.model)
          .then((value) async {
        // Create ui model from api model using mapper.
        if (value.response.statusCode == 200 ||
            value.response.statusCode == 201) {
          HiveDashboardService.putPendingTask(
              request.model.projectcode, value.data);
        }

        PendingTasksUIModel? uiModel = await _mapper!
            .getDashboardPendingCountsMapper(
                statusCode: value.response.statusCode,
                pendingTasksApiModel: value.data,
                projectImageData: null);

        return ResponseModel<PendingTasksUIModel>(
          data: uiModel,
          message: uiModel?.message,
          statusCode: value.response.statusCode,
          isSuccess: uiModel?.success,
        );
      }).catchError((Object obj) {
        return ErrorBuilder<PendingTasksUIModel>().getErrorResponseModel(obj);
      });
    } else {
      PendingTasksApiModel? pendingTasksApiModel =
          await HiveDashboardService.getPendingTask(request!.model.projectcode);

      PendingTasksUIModel? uiModel = await _mapper!
          .getDashboardPendingCountsMapper(
              statusCode: 200,
              pendingTasksApiModel: pendingTasksApiModel,
              projectImageData: null);
      // Create response model with UiModel for provider.
      return ResponseModel<PendingTasksUIModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: 200,
        isSuccess: uiModel?.success,
      );
    }
  }
}

class ProjectListUseCase extends UseCase<CommonRequestModel,
    ResponseModel<List<ProjectDetailsUiModel>>> {
  final DashboardRepository? _repository;
  final GetUserProjectMapper? _mapper;
  final NetworkInfoImpl? _networkInfo;

  final SharedPreferencesUtils _sharedPreferencesUtils =
      SharedPreferencesUtils();

  ProjectListUseCase(this._repository, this._mapper, this._networkInfo);

  @override
  Future<ResponseModel<List<ProjectDetailsUiModel>>> execute({
    RequestModel<CommonRequestModel>? request,
  }) async {
    if (_networkInfo!.isConnected) {
      return await _repository!
          .getUserAssignedProjects(request!.model)
          .then((value) async {
        AppData().youTubeLinkMobile = value.data.youTubeLinkMobile ?? "";
        // Create ui model from api model using mapper.
        List<ProjectDetailsUiModel>? projectList = _mapper!.getUserProjects(
            projects: value.data.data,
            source: RouteName.dashboardScreen,
            clientName: value.data.clientName);
        // Create response model with UiModel for provider.
        if (projectList != null) {
          await _sharedPreferencesUtils.setProjectDetails(
              AssignedProjectUiModel(projects: projectList, success: true));
        }
        return ResponseModel<List<ProjectDetailsUiModel>>(
          data: projectList,
          message: null,
          statusCode: value.response.statusCode,
          isSuccess: projectList != null ? true : false,
        );
      }).catchError((Object obj) {
        return ErrorBuilder<List<ProjectDetailsUiModel>>()
            .getErrorResponseModel(obj);
      });
    } else {
      List<ProjectDetailsUiModel> projectDetails =
          (await _sharedPreferencesUtils.getProjectDetails())!
              .cast<ProjectDetailsUiModel>();
      // Create response model with UiModel for provider.
      return ResponseModel<List<ProjectDetailsUiModel>>(
        data: projectDetails,
        message: null,
        statusCode: 200,
        isSuccess: projectDetails != null ? true : false,
      );
    }
  }
}

class GeofancingUseCase extends UseCase<GeofencingRequestModel,
    ResponseModel<GeofencingUiModel>> {
  final DashboardRepository? _repository;
  final GeofencingMapper? _mapper;
  final NetworkInfoImpl? _networkInfo;

  final SharedPreferencesUtils _sharedPreferencesUtils =
      SharedPreferencesUtils();

  GeofancingUseCase(this._repository, this._mapper, this._networkInfo);

  @override
  Future<ResponseModel<GeofencingUiModel>> execute({
    RequestModel<GeofencingRequestModel>? request,
  }) async {
    if (_networkInfo!.isConnected) {
      return await _repository!
          .checkGeofencing(request!.model)
          .then((value) async {
        // Create ui model from api model using mapper.
        GeofencingUiModel? projectList = _mapper!.getGeofencingMapper(
            apiModel: value.data, statusCode: value.response.statusCode);
        // Create response model with UiModel for provider.
        return ResponseModel<GeofencingUiModel>(
          data: projectList,
          message: null,
          statusCode: value.response.statusCode,
          isSuccess: projectList != null ? true : false,
        );
      }).catchError((Object obj) {
        return ErrorBuilder<GeofencingUiModel>().getErrorResponseModel(obj);
      });
    } else {
      return ResponseModel<GeofencingUiModel>(
        data: null,
        message: null,
        statusCode: 200,
        isSuccess: true,
      );
    }
  }
}
