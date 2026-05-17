import 'package:premises/common/models/models.dart';

class CommonResponseMapper {
  getCommonResponseMapper(
      {required int? statusCode, int? customStatusCode, String? message}) {
    if ((statusCode == 200 || statusCode == 201)) {
      return CommonResponseUiModel(
        success: true,
        statusCode: customStatusCode ?? statusCode,
        message: message ?? '',
      );
    } else {
      return CommonResponseUiModel(
        success: false,
        statusCode: customStatusCode ?? statusCode,
        message: message ?? '',
      );
    }
  }
}
