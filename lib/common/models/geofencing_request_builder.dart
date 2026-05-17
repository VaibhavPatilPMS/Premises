import 'package:premises/common/models/models.dart';
import 'package:premises/common/utils/utils.dart';

import '../base/base.dart';

class GeofencingRequestBuilder {
  Future<RequestModel<GeofencingRequestModel>> getCommonRequestModel(
      UserLocationDetails? userLocationDetails, String? moduleName) async {
    GeofencingDataRequestModel requestModel = GeofencingDataRequestModel(
      action: "validate",
      moduleName: moduleName,
      userLatitude: userLocationDetails?.latitude,
      userLongitude: userLocationDetails?.longitude,
      userAltitude: userLocationDetails?.altitude,
    );
    GeofencingRequestModel geofencingRequestModel = GeofencingRequestModel(
      data: requestModel,
    );
    await geofencingRequestModel.setAuth();
    return RequestModel(geofencingRequestModel);
  }
}
