import 'user_management.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/network/network.dart';


class UserLoginUseCase
    extends UseCase<UserLoginRequestModel, ResponseModel<UserLoginUiModel>> {
  final UserManagementRepository? _repository;

  final UserLoginResponseMapper? _mapper;

  UserLoginUseCase(this._repository, this._mapper);

  @override
  Future<ResponseModel<UserLoginUiModel>> execute({
    RequestModel<UserLoginRequestModel>? request,
  }) async {
    return await _repository!.userLogin(request!.model).then((value) {
      // Create ui model from api model using mapper.
      UserLoginUiModel? uiModel = _mapper!.getUserLoginResponseMapper(
          statusCode: value.response.statusCode, userLoginApiModel: value.data);
      // Create response model with UiModel for provider.
      return ResponseModel<UserLoginUiModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: value.response.statusCode,
        isSuccess: uiModel?.success,
      );
    }).catchError((Object obj) {
      return ErrorBuilder<UserLoginUiModel>().getErrorResponseModel(obj);
    });
  }
}

class ForgetPasswordUseCase extends UseCase<ForgetPasswordRequestModel,
    ResponseModel<CommonResponseUiModel>> {
  final UserManagementRepository? _repository;

  final ForgetPasswordResponseMapper? _mapper;

  ForgetPasswordUseCase(this._repository, this._mapper);

  @override
  Future<ResponseModel<CommonResponseUiModel>> execute({
    RequestModel<ForgetPasswordRequestModel>? request,
  }) async {
    return await _repository!.forgetPassword(request!.model).then((value) {
      // Create ui model from api model using mapper.
      CommonResponseUiModel? uiModel = _mapper!.getForgetPasswordResponseMapper(
          statusCode: value.response.statusCode,
          forgetPasswordApiModel: value.data);
      // Create response model with UiModel for provider.
      return ResponseModel<CommonResponseUiModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: value.response.statusCode,
        isSuccess: uiModel?.success,
      );
    }).catchError((Object obj) {
      return ErrorBuilder<CommonResponseUiModel>().getErrorResponseModel(obj);
    });
  }
}

class ChangePasswordUseCase extends UseCase<ChangePasswordRequestModel,
    ResponseModel<CommonResponseUiModel>> {
  final UserManagementRepository? _repository;

  final ChangePasswordResponseMapper? _mapper;

  ChangePasswordUseCase(this._repository, this._mapper);

  @override
  Future<ResponseModel<CommonResponseUiModel>> execute({
    RequestModel<ChangePasswordRequestModel>? request,
  }) async {
    return await _repository!.changePassword(request!.model).then((value) {
      // Create ui model from api model using mapper.
      CommonResponseUiModel? uiModel = _mapper!.getChangePasswordResponseMapper(
          statusCode: value.response.statusCode,
          changePasswordApiModel: value.data);
      // Create response model with UiModel for provider.
      return ResponseModel<CommonResponseUiModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: value.response.statusCode,
        isSuccess: uiModel?.success,
      );
    }).catchError((Object obj) {
      return ErrorBuilder<CommonResponseUiModel>().getErrorResponseModel(obj);
    });
  }
}

class UpdateProfileUseCase extends UseCase<UpdateProfileRequestModel,
    ResponseModel<UserLoginUiModel>> {
  final UserManagementRepository? _repository;

  final UpdateProfileResponseMapper? _mapper;

  UpdateProfileUseCase(this._repository, this._mapper);

  @override
  Future<ResponseModel<UserLoginUiModel>> execute({
    RequestModel<UpdateProfileRequestModel>? request,
  }) async {
    return await _repository!.updateUserProfile(request!.model).then((value) {
      // Create ui model from api model using mapper.
      UserLoginUiModel? uiModel = _mapper!.getUpdateProfileResponseMapper(
          statusCode: value.response.statusCode, userDetails: value.data);
      // Create response model with UiModel for provider.
      return ResponseModel<UserLoginUiModel>(
        data: uiModel,
        message: uiModel?.message,
        statusCode: value.response.statusCode,
        isSuccess: uiModel?.success,
      );
    }).catchError((Object obj) {
      return ErrorBuilder<UserLoginUiModel>().getErrorResponseModel(obj);
    });
  }
}


