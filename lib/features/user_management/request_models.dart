import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:premises/common/models/authorization.dart';

part 'request_models.g.dart';

@JsonSerializable()
class UserLoginRequestModel {
  String? username;
  String? password;
  String? strategy;

  //String? source;

  UserLoginRequestModel({this.username, this.password, this.strategy});

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRequestModelToJson(this);
}

@JsonSerializable()
class ForgetPasswordRequestModel {
  String? username;

  ForgetPasswordRequestModel({this.username});

  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestModelToJson(this);
}

@JsonSerializable()
class ChangePasswordRequestModel extends AuthorizationRequestModel {
  ChangePasswordRequestModel({
    this.username,
    this.currentpassword,
    this.newpassword,
    this.confirmedpassword,
  });

  @override
  String? username;
  String? currentpassword;
  String? newpassword;
  String? confirmedpassword;

  @override
  setAuth() async {
    return await super.setAuth();
  }

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordRequestModelToJson(this);
}

class UpdateProfileRequestModel extends AuthorizationRequestModel {
  FormData? formData;

  UpdateProfileRequestModel({this.formData});
}

class EmergencyContactsRequestModel extends AuthorizationRequestModel {
  int? skip;
  int? limit;
  String? searchtxt;

  EmergencyContactsRequestModel({this.skip, this.limit, this.searchtxt});

  @override
  setAuth() async {
    return await super.setAuth();
  }
}

class TrainingVideosRequestModel extends AuthorizationRequestModel {
  int? skip;
  int? limit;
  String? searchtxt;

  TrainingVideosRequestModel({this.skip, this.limit, this.searchtxt});

  @override
  setAuth() async {
    return await super.setAuth();
  }
}
