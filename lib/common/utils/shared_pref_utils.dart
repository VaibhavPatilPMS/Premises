import 'dart:convert';
import 'package:premises/application/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:premises/application/application.dart';
import 'package:premises/features/user_management/user_management.dart';
import 'package:premises/common/models/models.dart';
import 'utils.dart';

class SharedPreferencesUtils {
  SharedPreferences? _sharedPrefsInstanceGlobal;

  Future<bool> getUserLoginStatus() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    bool? loginStatus = _sharedPrefsInstanceGlobal!
        .getBool(SharedPrefConstants.getUserLoginStatus);
    if (loginStatus != null && loginStatus) {
      return true;
    }
    return false;
  }

  Future<bool> setUserLogin(bool isLoggedIn) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return _sharedPrefsInstanceGlobal!
        .setBool(SharedPrefConstants.getUserLoginStatus, isLoggedIn);
  }

  Future<String?> getAuthToken() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? authToken =
        _sharedPrefsInstanceGlobal!.getString(SharedPrefConstants.getAuthToken);
    if (authToken != null && authToken != '') {
      return authToken;
    }
    return null;
  }

  Future<bool?> setAuthToken(String authToken) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getAuthToken, authToken);
  }

  Future<String?> getRefreshToken() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? refreshToken = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.getRefreshToken);
    if (refreshToken != null && refreshToken != '') {
      return refreshToken;
    }
    return null;
  }

  Future<bool?> setRefreshToken(String refreshToken) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getRefreshToken, refreshToken);
  }

  Future<String?> getUserId() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? userId =
        _sharedPrefsInstanceGlobal!.getString(SharedPrefConstants.getUserId);
    if (userId != null && userId != '') {
      return userId;
    }
    return null;
  }

  Future<String?> getUserName() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? userName =
        _sharedPrefsInstanceGlobal!.getString(SharedPrefConstants.getUserName);
    if (userName != null && userName != '') {
      return userName;
    }
    return null;
  }

  Future<bool?> setUserId(String userId) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getUserId, userId);
  }

  Future<bool?> setUserName(String userName) async {
    AppData().userName = userName;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getUserName, userName);
  }

  Future<bool?> setOnlineOfflineModule(bool isOnline) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setBool(SharedPrefConstants.getOnlineOfflineModule, isOnline);
  }

  Future<bool?> getOnlineOfflineModule() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    bool? isOnline = _sharedPrefsInstanceGlobal!
        .getBool(SharedPrefConstants.getOnlineOfflineModule);
    if (isOnline != null) {
      return isOnline;
    }
    return false;
  }

  Future<String?> getProjectId() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? projectId =
        _sharedPrefsInstanceGlobal!.getString(SharedPrefConstants.getProjectId);
    AppData().projectid = projectId;
    if (projectId != null && projectId != '') {
      return projectId;
    }
    return null;
  }

  Future<String?> getProjectName() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? projectName = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.getProjectName);
    AppData().projectName = projectName;
    if (projectName != null && projectName != '') {
      return projectName;
    }
    return null;
  }

  Future<String?> getProjectCode() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? projectCode = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.getProjectCode);
    AppData().projectCode = projectCode;
    if (projectCode != null && projectCode != '') {
      return projectCode;
    }
    return null;
  }

  Future<bool?> setProjectId(String projectId) async {
    AppData().projectid = projectId;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;

    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getProjectId, projectId);
  }

  Future<bool?> setProjectName(String projectName) async {
    AppData().projectName = projectName;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;

    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getProjectName, projectName);
  }

  Future<bool?> setProjectCode(String projectCode) async {
    AppData().projectCode = projectCode;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;

    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getProjectCode, projectCode);
  }

  Future<bool?> setUserDetails(UserUiModel userUiModel) async {
    AppData().userDetailsUiModel = userUiModel;
    AppData().userid = userUiModel.id;
    AppData().userName = userUiModel.username;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.getUserDetails, jsonEncode(userUiModel));
  }

  Future<UserUiModel?> getUserDetails() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? userDetails = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.getUserDetails);
    if (userDetails != null && userDetails != '') {
      UserUiModel userUiModel = UserUiModel.fromJson(jsonDecode(userDetails));
      AppData().userDetailsUiModel = userUiModel;
      AppData().userid = userUiModel.id;
      AppData().userName = userUiModel.username;
      return userUiModel;
    }
    return null;
  }

  Future<bool?> setProjectDetails(AssignedProjectUiModel projects) async {
    AppData().assignedProjects = projects.projects;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!.setString(
        SharedPrefConstants.assignedProjectDetails, jsonEncode(projects));
  }

  Future<List<ProjectDetailsUiModel?>?> getProjectDetails() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? projectDetails = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.assignedProjectDetails);
    if (projectDetails != null && projectDetails != '') {
      AssignedProjectUiModel projectUiModel =
          AssignedProjectUiModel.fromJson(jsonDecode(projectDetails));
      return projectUiModel.projects!;
    }
    return null;
  }

  Future<bool?> setSelectedProjectDetails(
      ProjectDetailsUiModel currentProject) async {
    AppData().userCurrentSelectedProject = currentProject;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    await setProjectId(currentProject.projectID!);
    if (currentProject.sId != null) {
      await setProjectSId(currentProject.sId!);
    }
    await setProjectName(currentProject.projectName!);
    await setProjectCode(currentProject.projectCode!);
    AppData().userCurrentSelectedProject = currentProject;
    return await _sharedPrefsInstanceGlobal!.setString(
        SharedPrefConstants.currentProject, jsonEncode(currentProject));
  }

  Future<ProjectDetailsUiModel?> getSelectedProjectDetails() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? currentProjectDetails = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.currentProject);
    if (currentProjectDetails != null && currentProjectDetails != '') {
      ProjectDetailsUiModel? currentProjectUiModel =
          ProjectDetailsUiModel.fromJson(jsonDecode(currentProjectDetails));
      AppData().userCurrentSelectedProject = currentProjectUiModel;
      return currentProjectUiModel;
    }
    return null;
  }

  Future<String?> getLastCheckupOn() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? lastCheckupOn = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.lastCheckupOn);
    if (lastCheckupOn != null && lastCheckupOn != '') {
      return lastCheckupOn;
    }
    return null;
  }

  Future<bool?> setlastCheckupOn(String lastCheckupOn) async {
    AppData().lastCheckupOn = lastCheckupOn;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.lastCheckupOn, lastCheckupOn);
  }

  Future<DateTime?> getLastSyncedServerDate() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? lastSyncedServerDate = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.lastSyncedServerDate);
    if (lastSyncedServerDate != null && lastSyncedServerDate != '') {
      AppData().lastSyncedServerDate = DateTime.parse(lastSyncedServerDate);
      return DateTime.parse(lastSyncedServerDate);
    }
    return null;
  }

  Future<bool?> setLastSyncedServerDate(DateTime lastSyncedServerDate) async {
    AppData().lastSyncedServerDate = lastSyncedServerDate;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!.setString(
        SharedPrefConstants.lastSyncedServerDate,
        lastSyncedServerDate.toString());
  }

  Future<String?> getUserContactNumber() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? userContactNumber = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.userContactNumber);
    AppData().userContactNumber = userContactNumber;
    if (userContactNumber != null && userContactNumber != '') {
      return userContactNumber;
    }
    return null;
  }

  Future<bool?> setUserContactNumber(String userContactNumber) async {
    AppData().userContactNumber = userContactNumber;
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;

    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.userContactNumber, userContactNumber);
  }

  //visitor pass
  Future<bool> getVisitorOTPVerifiedStatus() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    bool? isVisitorOTPVerified = _sharedPrefsInstanceGlobal!
        .getBool(SharedPrefConstants.isVisitorOTPVerified);
    if (isVisitorOTPVerified != null && isVisitorOTPVerified) {
      AppData().isVisitorOTPVerified = isVisitorOTPVerified;
      return true;
    }
    return false;
  }

  Future<bool> setVisitorOTPVerifiedStatus(bool isVisitorOTPVerified) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    AppData().isVisitorOTPVerified = isVisitorOTPVerified;
    return _sharedPrefsInstanceGlobal!.setBool(
        SharedPrefConstants.isVisitorOTPVerified, isVisitorOTPVerified);
  }

  Future<bool> setVisitorEmailId(String emailId) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    AppData().visitorEmailId = emailId;
    return _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.visitoremailId, emailId);
  }

  Future<String?> getVisitorEmailId() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? emailId = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.visitoremailId);
    AppData().visitorEmailId = emailId;
    if (emailId != null && emailId.isNotEmpty) {
      return emailId;
    }
    return null;
  }

  Future<bool> clearVisitorEmailId() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return _sharedPrefsInstanceGlobal!
        .remove(SharedPrefConstants.visitoremailId);
  }

  Future<bool?> clearSharedPref() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;

    AppData().visitorEmailId = _sharedPrefsInstanceGlobal!
        .getString(SharedPrefConstants.visitoremailId);
    AppData().isVisitorOTPVerified = _sharedPrefsInstanceGlobal!
        .getBool(SharedPrefConstants.isVisitorOTPVerified);

    _sharedPrefsInstanceGlobal!.clear();
    if (AppData().visitorEmailId != null) {
      _sharedPrefsInstanceGlobal!.setString(
          SharedPrefConstants.visitoremailId, AppData().visitorEmailId!);
    }
    if (AppData().isVisitorOTPVerified != null) {
      _sharedPrefsInstanceGlobal!.setBool(
          SharedPrefConstants.isVisitorOTPVerified,
          AppData().isVisitorOTPVerified!);
    }
    return null;
  }

  Future<String?> getProjectSId() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    String? projectSId =
        _sharedPrefsInstanceGlobal!.getString(SharedPrefConstants.projectSId);
    AppData().projectSId = projectSId;
    if (projectSId != null && projectSId != '') {
      return projectSId;
    }
    return null;
  }

  Future<bool?> setProjectSId(String projectSId) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    return await _sharedPrefsInstanceGlobal!
        .setString(SharedPrefConstants.projectSId, projectSId);
  }

  Future<bool?> setOfflineUsageDialog(bool? isDialogShow) async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();
    _sharedPrefsInstanceGlobal = SharedPrefsInstance.instance;
    AppData().isOfflineUsageDialogShow = isDialogShow;
    return await _sharedPrefsInstanceGlobal!.setBool(
        SharedPrefConstants.isOfflineUsageDialogShow, isDialogShow ?? false);
  }

  Future<bool?> getOfflineUsageDialogShown() async {
    SharedPrefsInstance sharedPrefsInstance = SharedPrefsInstance();
    await sharedPrefsInstance.createSharePrefsInstance();

    bool? isOfflineUsageDialogShow = _sharedPrefsInstanceGlobal!
        .getBool(SharedPrefConstants.isOfflineUsageDialogShow);
    if (isOfflineUsageDialogShow != null && isOfflineUsageDialogShow) {
      AppData().isVisitorOTPVerified = isOfflineUsageDialogShow;
      return true;
    }
    return false;

  }
}
