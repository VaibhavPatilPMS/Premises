import 'package:json_annotation/json_annotation.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/utils/permission_utils.dart';
import 'package:premises/common/utils/utils.dart';

part 'authorization.g.dart';

@JsonSerializable()
class AuthorizationRequestModel extends LocationRequestModel {
  String? authorization;
  String? userid;
  String? username;
  String? projectid;
  String? projectName;
  String? projectCode;
  String? userContactNumber;
  String? deviceUniqueId;
  String? roleCode;
  String? projectSId;
  LocationRequestModel? locationDetails;

  AuthorizationRequestModel();

  @override
  setLocationDetails() async {
    return await super.setLocationDetails();
  }

  setAuth() async {
    authorization = _getAuthToken();
    userid = _getUserId();
    username = _getUserName();
    projectid = _getProjectId();
    projectName = _getProjectName();
    projectCode = _getProjectCode();
    projectSId = _getProjectSId();

    userContactNumber = _getUserContactNumber();
    deviceUniqueId = await _getDeviceUniqueId();
    roleCode = AppData().userCurrentSelectedProject?.roleCode;
    //New Changes
    AppData().userid = _getUserId();
    AppData().userName = _getUserName();
    AppData().projectid = _getProjectId();
    AppData().projectName = _getProjectName();
    AppData().projectCode = _getProjectCode();
    AppData().projectSId = _getProjectSId();
  }

  String? _getUserId() {
    String? userId =
        SharedPrefsInstance.instance!.getString(SharedPrefConstants.getUserId);
    return userId;
  }

  String? _getUserName() {
    String? userName = SharedPrefsInstance.instance!
        .getString(SharedPrefConstants.getUserName);
    return userName;
  }

  String? _getAuthToken() {
    String? token = SharedPrefsInstance.instance!
        .getString(SharedPrefConstants.getAuthToken);

    return token != null ? ApiParams.BEARER + token : null;
  }

  String? _getProjectId() {
    String? projectId = SharedPrefsInstance.instance!
        .getString(SharedPrefConstants.getProjectId);
    return projectId;
  }

  String? _getProjectName() {
    String? projectName = SharedPrefsInstance.instance!
        .getString(SharedPrefConstants.getProjectName);
    return projectName;
  }

  String? _getProjectCode() {
    String? projectCode = SharedPrefsInstance.instance!
        .getString(SharedPrefConstants.getProjectCode);
    return projectCode;
  }

  String? _getProjectSId() {
    String? projectCode =
        SharedPrefsInstance.instance!.getString(SharedPrefConstants.projectSId);
    return projectCode;
  }

  String? _getUserContactNumber() {
    String? userContactNumber = SharedPrefsInstance.instance!
        .getString(SharedPrefConstants.userContactNumber);
    return userContactNumber;
  }

  Future<String?> _getDeviceUniqueId() async {
    String? deviceId = await DeviceUtils.getDeviceDetails();
    return deviceId;
  }

  factory AuthorizationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthorizationRequestModelToJson(this);
}

@JsonSerializable()
class LocationRequestModel {
  String? location_address;
  String? latitude;
  String? longitude;
  String? altitude;

  LocationRequestModel();

  setLocationDetails() async {
    UserLocationDetails? userLocationDetails =
        await LocationUtils().getLocationDetails();
    location_address = userLocationDetails?.userAddress;
    latitude = userLocationDetails?.latitude.toString();
    longitude = userLocationDetails?.longitude.toString();
    altitude = userLocationDetails?.altitude.toString();
  }

  factory LocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationRequestModelToJson(this);
}
