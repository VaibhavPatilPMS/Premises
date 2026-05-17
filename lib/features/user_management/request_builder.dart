import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as doi;
import 'package:http_parser/http_parser.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/base/request_model.dart';
import 'package:premises/features/user_management/request_models.dart';

class UserManagementRequestBuilder {
  UserLoginRequestModel getLoginRequestModel({
    String? userName,
    String? password,
  }) {
    return UserLoginRequestModel(
        username: userName, password: password, strategy: 'local');
  }

  ForgetPasswordRequestModel getForgetRequestModel({
    String? userName,
  }) {
    return ForgetPasswordRequestModel(username: userName);
  }

  Future<RequestModel<ChangePasswordRequestModel>>
      getChangePasswordRequestModel({
    String? currentpassword,
    String? newpassword,
    String? confirmedpassword,
  }) async {
    ChangePasswordRequestModel changePasswordRequestModel =
        ChangePasswordRequestModel(
            username: AppData().userName,
            currentpassword: currentpassword,
            newpassword: newpassword,
            confirmedpassword: confirmedpassword);

    await changePasswordRequestModel.setAuth();
    return RequestModel(changePasswordRequestModel);
  }

  Future<RequestModel<UpdateProfileRequestModel>> getUpdateProfileRequestModel({
    String? contactEmailId,
    File? profilePicFile,
  }) async {
    FormData formData = FormData();
    if (contactEmailId != null) {
      formData = FormData.fromMap({
        ApiParams.EMAIL: contactEmailId,
      });
      if (profilePicFile != null) {
        formData.files.add(MapEntry(
          ApiParams.PROFILE_PIC,
          doi.MultipartFile.fromFileSync(profilePicFile.path,
              contentType: MediaType.parse(ContentType.image_jpeg),
              filename: "${randomAlphaNumeric(10)}.jpg"),
        ));
      }
    } else {
      formData.files.add(MapEntry(
        ApiParams.PROFILE_PIC,
        doi.MultipartFile.fromFileSync(profilePicFile!.path,
            contentType: MediaType.parse(ContentType.image_jpeg),
            filename: "${randomAlphaNumeric(10)}.jpg"),
      ));
    }
    UpdateProfileRequestModel updateProfileRequestModel =
        UpdateProfileRequestModel(
      formData: formData,
    );

    await updateProfileRequestModel.setAuth();
    return RequestModel(updateProfileRequestModel);
  }

  Future<RequestModel<UpdateProfileRequestModel>> updateAndSetFCMToken({
    String? fcmToken,
  }) async {
    FormData formData = FormData();
    formData = FormData.fromMap({
      'registrationTokens': fcmToken,
    });
    UpdateProfileRequestModel updateProfileRequestModel =
        UpdateProfileRequestModel(
      formData: formData,
    );

    await updateProfileRequestModel.setAuth();
    return RequestModel(updateProfileRequestModel);
  }

  Future<RequestModel<EmergencyContactsRequestModel>>
      getEmergencyContactsListRequestModel({
    int? limit,
    int? skip,
    String? searchtxt,
  }) async {
    EmergencyContactsRequestModel requestModel = EmergencyContactsRequestModel(
      limit: limit ?? 10,
      skip: skip,
      searchtxt: searchtxt == '' ? null : searchtxt,
    );
    await requestModel.setAuth();

    return RequestModel(requestModel);
  }

  Future<RequestModel<TrainingVideosRequestModel>>
      getTrainingVideoListRequestModel({
    int? limit,
    int? skip,
    String? searchtxt,
  }) async {
    TrainingVideosRequestModel requestModel = TrainingVideosRequestModel(
      limit: limit ?? 10,
      skip: skip,
      searchtxt: searchtxt == '' ? null : searchtxt,
    );
    await requestModel.setAuth();

    return RequestModel(requestModel);
  }
}
