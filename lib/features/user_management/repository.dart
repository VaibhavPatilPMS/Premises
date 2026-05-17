import 'package:retrofit/dio.dart';
import 'package:premises/common/network/network.dart';

import 'user_management.dart';

class UserManagementRepository {
  final ApiClient? _apiClient;

  UserManagementRepository(this._apiClient);

  Future<HttpResponse<UserLoginApiModel>> userLogin(
      UserLoginRequestModel requestModel) async {
    return await _apiClient!.userLogin(requestModel: requestModel);
  }

  Future<HttpResponse<ForgetPasswordApiModel>> forgetPassword(
      ForgetPasswordRequestModel requestModel) async {
    return await _apiClient!.forgetPassword(requestModel: requestModel);
  }

  // change password
  Future<HttpResponse<ChangePasswordApiModel>> changePassword(
      ChangePasswordRequestModel requestModel) async {
    return await _apiClient!.changePassword(requestModel: requestModel);
  }

  Future<HttpResponse<UserDetails>> updateUserProfile(
      UpdateProfileRequestModel requestModel) async {
    return await _apiClient!.updateUserProfile(requestModel: requestModel);
  }
}
