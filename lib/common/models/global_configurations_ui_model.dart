import '../base/base.dart';

class GlobalConfigurationsUiModel extends UiModel {
  bool? success;
  @override
  String? message;
  String? projectCode;
  String? projectId;
  List<GlobalConfigurationsUiDataModel>? data;

  GlobalConfigurationsUiModel(
      {this.projectCode,
      this.message,
      this.data,
      this.projectId,
      this.success});
}

class GlobalConfigurationsUiDataModel {
  String? sId;
  bool? value;
  bool? isActive;
  String? configurationTypeCode;
  String? configurationCode;
  String? checker;
  String? maker;
  bool? ocrAccessKey;
  dynamic hoursLimit;
  ConfigurationUIModel? configuration;

  GlobalConfigurationsUiDataModel(
      {this.sId,
      this.value,
      this.isActive,
      this.ocrAccessKey,
      this.checker,
      this.maker,
      this.configurationTypeCode,
      this.configurationCode,
      this.hoursLimit,
      this.configuration});
}

class ConfigurationUIModel {
  String? type;
  String? lable;
  bool? value;

  ConfigurationUIModel({this.lable, this.type, this.value});
}
