import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:retrofit/dio.dart';
import 'package:premises/app_config.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/features/user_management/user_management.dart';
import 'api_cache_manager.dart';
import 'network.dart';
// import 'dart:convert';
// import 'package:premises/common/models/models.dart';
// import 'package:premises/common/resources/resources.dart';
// import 'package:premises/common/models/models.dart';
// import 'package:premises/application/app_data.dart';

class ApiClient {
  late Dio _dio;
  late RetrofitService _service;

  static final HttpClient _httpClient = HttpClient()
    ..idleTimeout = ApiTimeOutDuration.apiTimeOutDuration
    ..maxConnectionsPerHost = 5
    ..connectionTimeout = ApiTimeOutDuration.apiTimeOutDuration;

  void _configureDio() {
    _dio.options.sendTimeout = ApiTimeOutDuration.apiTimeOutDuration;
    _dio.options.connectTimeout = ApiTimeOutDuration.apiTimeOutDuration;
    _dio.options.receiveTimeout = ApiTimeOutDuration.apiTimeOutDuration;
    _dio.options.headers.addAll({
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
    });
    _dio.options.followRedirects = true;
    _dio.options.maxRedirects = 3;
    _dio.options.persistentConnection = true;
    _dio.options.responseType = ResponseType.json;
    _dio.options.contentType = Headers.jsonContentType;

    _dio.transformer = BackgroundTransformer();
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () => _httpClient,
    );
  }

  void _addInterceptors() {
    // Add cache interceptor for GET requests
    _dio.interceptors.add(ApiCacheManager.cacheInterceptor);
    _dio.interceptors.add(CustomInterceptors(dio: _dio));
  }

  ApiClient() {
    _dio = Dio();
    _configureDio();
    _addInterceptors();
    _service = RetrofitService(_dio, baseUrl: Environment.baseUrl);
  }

  Future<HttpResponse<UserLoginApiModel>> userLogin({
    required UserLoginRequestModel requestModel,
  }) async {
    return await _service.userLogin(requestModel: requestModel);
  }

  Future<HttpResponse<ForgetPasswordApiModel>> forgetPassword({
    required ForgetPasswordRequestModel requestModel,
  }) async {
    return await _service.forgetPassword(requestModel: requestModel);
  }

  //change password details
  Future<HttpResponse<ChangePasswordApiModel>> changePassword({
    required ChangePasswordRequestModel requestModel,
  }) async {
    return await _service.changePassword(
      requestModel: requestModel,
      authorization: requestModel.authorization,
    );
  }

  Future<HttpResponse<UserDetails>> updateUserProfile({
    required UpdateProfileRequestModel requestModel,
  }) async {
    return await _service.updateProfile(
      contentType: ContentType.multipart_form_data,
      requestModel: requestModel.formData,
      authorization: requestModel.authorization,
      userID: requestModel.userid,
    );
  }

  

  // Just for reference
  // Future<HttpResponse<IncidentApiModel>> getIncidentReportList({
  //   required IncidentReportListRequestModel requestModel,
  // }) async {
  //   if (requestModel.isForMeTab != null && requestModel.isForMeTab!) {
  //     return await _service.getIncidentListForMe(
  //       authorization: requestModel.authorization,
  //       skip: requestModel.skip,
  //       limit: requestModel.limit,
  //       projectCode: requestModel.projectCode,
  //       incidentCode: requestModel.searchId,
  //       fromDate: requestModel.fromDate,
  //       toDate: requestModel.toDate,
  //       severityLevel: requestModel.severityLevel,
  //       incidentDateFrom: requestModel.incidentFromDate,
  //       incidentDateTo: requestModel.incidentToDate,
  //       //userId: requestModel.userid,
  //       username: requestModel.username,
  //       status: requestModel.status != null ? requestModel.status : null,
  //     );
  //   } else {
  //     return await _service.getAccidentReportByProjectUser(
  //       authorization: requestModel.authorization,
  //       skip: requestModel.skip,
  //       limit: requestModel.limit,
  //       projectCode: requestModel.projectCode,
  //       incidentCode: requestModel.searchId,
  //       fromDate: requestModel.fromDate,
  //       toDate: requestModel.toDate,
  //       severityLevel: requestModel.severityLevel,
  //       incidentDateFrom: requestModel.incidentFromDate,
  //       incidentDateTo: requestModel.incidentToDate,
  //       userId: requestModel.isAllTab! ? null : requestModel.userid,
  //       status: requestModel.status != null ? requestModel.status : null,
  //     );
  //   }
  // }

  // Future<HttpResponse<ProjectActiveLaborsListApiModel>> getProjectLabors({
  //   required ActiveProjectLaboursRequestModel requestModel,
  // }) async {
  //   return await _service.getProjectLabors(
  //     authorization: requestModel.authorization,
  //     skip: requestModel.skip,
  //     limit: requestModel.limit,
  //     projectCode: requestModel.projectCode,
  //     //isActive: requestModel.isActive,
  //     sortBy: 'createdAt',
  //     requiredData: [
  //       'labourCode',
  //       'firstName',
  //       'middleName',
  //       'lastName',
  //       'contactNumber',
  //       'contractorFirmDetails.contractorFirm',
  //       'profilePhoto',
  //       'isActive',
  //       'activationStatusHistory.deActivationReason',
  //       'activationStatusHistory.deactivationRemark',
  //     ],
  //     labourCode: requestModel.labourCode,
  //     contactNumber: requestModel.contactNumber,
  //     contractorFirmCode: requestModel.contractorFirmCode,
  //     contractorGroupName: requestModel.contractorGroupName,
  //     labourName: requestModel.labourName,
  //     trade: requestModel.trade,
  //     isActive: requestModel.isActive,
  //   );
  // }
}
