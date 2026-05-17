import 'package:premises/common/models/models.dart';

class CommonRequestModel extends AuthorizationRequestModel {
  @override
  String? authorization;
  @override
  String? userid;
  @override
  String? projectid;
  String? projectcode;
  String? userName;
  String? roleCode;
  String? projectSId;

  CommonRequestModel(
      {this.authorization,
      this.userid,
      this.projectid,
      this.projectcode,
      this.userName,
      this.projectSId,
      this.roleCode});

  @override
  setAuth() async {
    return await super.setAuth();
  }
}
