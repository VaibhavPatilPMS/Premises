import 'package:premises/application/application.dart';
import 'package:premises/common/base/base.dart';
import 'models.dart';

class CommonRequestBuilder {
  Future<RequestModel<CommonRequestModel>> getCommonRequestModel() async {
    CommonRequestModel requestModel = CommonRequestModel();

    await requestModel.setAuth();

    requestModel = CommonRequestModel(
      authorization: requestModel.authorization,
      projectid: requestModel.projectid,
      userid: requestModel.userid,
      projectcode: requestModel.projectCode,
      userName: requestModel.username,
      projectSId: requestModel.projectSId,
      roleCode: AppData().userCurrentSelectedProject?.roleCode,
    );
    await requestModel.setAuth();
    return RequestModel(requestModel);
  }
}
