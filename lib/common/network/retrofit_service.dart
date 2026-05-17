import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/models/geofencing_api_model.dart';
import 'package:premises/common/models/geofencing_request_model.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/features/user_management/user_management.dart';

part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String baseUrl}) = _RetrofitService;

  // User Management
  @POST(Apis.userLogin)
  Future<HttpResponse<UserLoginApiModel>> userLogin({
    @Body() required UserLoginRequestModel requestModel,
  });

  @POST(Apis.forgetPassword)
  Future<HttpResponse<ForgetPasswordApiModel>> forgetPassword({
    @Body() required ForgetPasswordRequestModel requestModel,
  });

  @POST(Apis.changePassword)
  Future<HttpResponse<ChangePasswordApiModel>> changePassword({
    @Header(ApiParams.AUTHORIZATION) String? authorization,
    @Body() required ChangePasswordRequestModel requestModel,
  });

  @PATCH(Apis.updateUserProfile)
  Future<HttpResponse<UserDetails>> updateProfile({
    @Header(ApiParams.CONTENT_TYPE) required String contentType,
    @Header(ApiParams.AUTHORIZATION) String? authorization,
    @Path(ApiParams.USER_ID) String? userID,
    @Body() required FormData? requestModel,
  });

  @POST(Apis.geofencing)
  Future<HttpResponse<GeofencingApiModel>> checkGeofencing({
    @Header(ApiParams.AUTHORIZATION) String? authorization,
    @Path(ApiParams.PROJECT_CODE) String? projectCode,
    @Body() required GeofencingDataRequestModel? requestModel,
  });

  // Just for reference
  // @GET(Apis.getUserAssignedProjects)
  // Future<HttpResponse<UserAssignedProjects>> getUserAssignedProjects({
  //   @Header(ApiParams.AUTHORIZATION) String? authorization,
  // });

  // @GET(Apis.getEmergencyContacts)
  // Future<HttpResponse<EmergencyContactApiModel>> getEmergencyContacts({
  //   @Header(ApiParams.AUTHORIZATION) String? authorization,
  //   @Path(ApiParams.PROJECT_CODE) String? projectCode,
  //   @Query(ApiParams.searchTxt) String? searchtxt,
  //   @Query(ApiParams.SKIP) int? skip,
  //   @Query(ApiParams.LIMIT) int? limit,
  // });

  // @GET(Apis.getToolboxTrainingTbtAll)
  // Future<HttpResponse<ToolboxTrainingApiListModel>> getAllToolboxTrainings({
  //   @Header(ApiParams.AUTHORIZATION) String? authorization,
  //   @Path(ApiParams.PROJECT_CODE) String? projectCode,
  //   @Query(ApiParams.SKIP) int? skip,
  //   @Query(ApiParams.LIMIT) int? limit,
  //   @Query(ApiParams.TOOLBOX_TRAINING_CODE) String? toolboxtrainingCode,
  //   @Query(ApiParams.TOOLBOX_TRAINING_NAME) String? toolboxtrainingName,
  //   @Query(ApiParams.SELECT) List<String>? requiredData,
  //   //For Filters
  //   @Query(ApiParams.TBT_ACTIVITY_ID) String? activityid,
  //   @Query(ApiParams.STATUS) String? status,
  //   @Query(ApiParams.TBT_TO_DATE) String? todate,
  //   @Query(ApiParams.TBT_FROM_DATE) String? fromdate,
  // });

  // @GET(Apis.violationAllTabList)
  // Future<HttpResponse<MakerListApiModel>> getAllTabViolationList({
  //   @Header(ApiParams.AUTHORIZATION) String? authorization,
  //   @Path(ApiParams.PROJECT_CODE) required String? projectCode,
  //   @Query(ApiParams.SKIP) int? skip,
  //   @Query(ApiParams.LIMIT) int? limit,
  //   @Query(ApiParams.SELECT) List? select,
  //   @Query(ApiParams.SOURCE) String? source,
  //   @Query("caseCodeId") String? caseCodeId,
  //   @Query("recordId") String? recordId,
  //   @Query("createdAtFrom") String? createdAtFrom,
  //   @Query("createdAtTo") String? createdAtTo,
  //   @Query("minAmount") String? minAmount,
  //   @Query("maxAmount") String? maxAmount,
  //   @Query("safetyactionableCode") String? safetyactionableCode,
  //   @Query("noticeId") String? noticeId,
  //   @Query("locationOfViolation") String? locationOfViolation,
  //   @Query("status") List<String>? status,
  //   @Query("action") List<String>? action,
  //   @Query("severityOfViolation") String? severityOfViolation,
  //   @Query("contractorfirmName") String? contractorfirm,
  // });
}
