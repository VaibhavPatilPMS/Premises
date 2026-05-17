import 'package:premises/common/models/models.dart';
import 'package:premises/common/resources/app_strings.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/utils/utils.dart';
import 'user_management.dart';

class UserLoginResponseMapper {
  getUserLoginResponseMapper(
      {UserLoginApiModel? userLoginApiModel, required int? statusCode}) {
    try {
      if (statusCode == 200 || statusCode == 201) {
        UserLoginApiModel? userResponseModel = userLoginApiModel;
        userResponseModel?.authentication = userLoginApiModel?.authentication;
        userResponseModel?.userDetails = userLoginApiModel?.userDetails;

        List<ProjectDetailsUiModel>? getUserProjects(
            List<UsersProjectListApiModel>? projects) {
          if (projects != null && projects.isNotEmpty) {
            List<UsersProjectListApiModel>? activeProjectsList =
                projects.where((element) => element.isActive!).toList();

            activeProjectsList
                .sort((a, b) => a.projectName!.compareTo(b.projectName!));

            List<ProjectDetailsUiModel>? userAssignedProjects = [];
            for (int i = 0; i < activeProjectsList.length; i++) {
              var element = activeProjectsList[i];
              ProjectDetailsUiModel projectUiModel = ProjectDetailsUiModel(
                  projectName: element.projectName,
                  projectCode: element.projectCode,
                  roleCode: element.roleCode,
                  projectID: '',
                  isCheck: i == 0 ? true : false,
                  isActive: element.isActive ?? false,
                  roleName: element.roleName!.trim());
              userAssignedProjects.add(projectUiModel);
            }
            return userAssignedProjects;
          }
          return null;
        }

        String getUserAssignedProjects(
            List<UsersProjectListApiModel>? projects) {
          List<UsersProjectListApiModel>? activeProjectsList =
              projects!.where((element) => element.isActive!).toList();

          activeProjectsList
              .sort((a, b) => a.projectName!.compareTo(b.projectName!));
          String assignedProjects;
          StringBuffer buffer = StringBuffer();
          if (activeProjectsList.length == 1) {
            return projects.first.projectName!;
          } else {
            for (var element in activeProjectsList) {
              if (element.projectName != null &&
                  element.projectName!.isNotEmpty) {
                buffer.write(
                    '${element.projectName!.toString().toBeginningOfSentence()},');
              }
            }
          }
          assignedProjects = buffer.toString();
          return assignedProjects;
        }

        getUserProfilePicture(CommonFileObjectApiAndRequestModel? profilePic) {
          if (profilePic != null && profilePic.filename != null) {
            return FilePathUrls.getUserProfilePic + profilePic.filename!;
          } else {
            return null;
          }
        }

        getUserProfilePictureObject(
            CommonFileObjectApiAndRequestModel? profilePic) {
          if (profilePic != null && profilePic.filename != null) {
            CommonFileObjectApiAndRequestModel userProfilePic =
                CommonFileObjectApiAndRequestModel(
              filename: profilePic.filename,
              destination: profilePic.destination,
              size: profilePic.size,
              encoding: profilePic.encoding,
              fieldname: profilePic.fieldname,
              mimetype: profilePic.mimetype,
              path: profilePic.path,
              originalname: profilePic.originalname,
            );
            return userProfilePic;
          } else {
            return null;
          }
        }

        UserUiModel userUiModel = UserUiModel(
          accessToken: userResponseModel?.accessToken,
          refreshToken: userResponseModel?.refreshToken,
          strategy: userResponseModel?.authentication?.strategy,
          username: userResponseModel?.userDetails?.username,
          lastName: userResponseModel?.userDetails?.lastName,
          firstName: userResponseModel?.userDetails?.firstName,
          isMobileOtpVerified:
              userResponseModel?.userDetails?.isMobileOtpVerified,
          createdAt: userResponseModel?.userDetails?.createdAt,
          email: userResponseModel?.userDetails?.email,
          id: userResponseModel?.userDetails?.id,
          idProofType: userResponseModel?.userDetails?.idProofType,
          isAdmin: userResponseModel?.userDetails?.isAdmin,
          isActive: userResponseModel?.userDetails?.isActive,
          phoneNumber: userResponseModel?.userDetails?.phoneNumber,
          profilePic:
              getUserProfilePicture(userResponseModel?.userDetails?.profilePic),
          profilePicObject: getUserProfilePictureObject(
              userResponseModel?.userDetails?.profilePic),
          registrationTokens:
              userResponseModel?.userDetails?.registrationTokens,
          updatedAt: userResponseModel?.userDetails?.updatedAt,
          type: userResponseModel?.userDetails?.type,
          designation: userResponseModel?.userDetails?.designation,
          emergencyContactName:
              userResponseModel?.userDetails?.emergencyContactName,
          emergencyContactNumber:
              userResponseModel?.userDetails?.emergencyContactNumber,
          emergencyContactRelation:
              userResponseModel?.userDetails?.emergencyContactRelation,
          organizationName: userResponseModel?.userDetails?.organizationName,
          temporaryPassword: userResponseModel?.userDetails?.temporaryPassword,
          clientName: userResponseModel?.clientName,
          assignedProjects:
              getUserProjects(userLoginApiModel?.userDetails?.projects),
          userAssignedProjects:
              getUserAssignedProjects(userLoginApiModel?.userDetails?.projects),
        );

        return UserLoginUiModel(
            data: userUiModel,
            message: '',
            isUserLoginSupported:
                userResponseModel!.userDetails!.isAdmin == false ? true : false,
            statusCode: statusCode,
            isActive: userResponseModel.userDetails!.isActive,
            success: statusCode == 200 || statusCode == 201 ? true : false);
      } else {
        return UserLoginUiModel(
            data: null,
            message: 'Invalid login',
            isUserLoginSupported: false,
            isActive: false,
            statusCode: statusCode,
            success: statusCode == 200 || statusCode == 201 ? true : false);
      }
    } catch (msg) {
      CustomLogger.logPrint('catch errro $msg');
    }
  }
}

class ForgetPasswordResponseMapper {
  getForgetPasswordResponseMapper(
      {ForgetPasswordApiModel? forgetPasswordApiModel,
      required int? statusCode}) {
    if ((statusCode == 200 || statusCode == 201)) {
      return CommonResponseUiModel(
        success: true,
        statusCode: statusCode,
        message: AppStrings().message_forget_password,
      );
    } else {
      return CommonResponseUiModel(
        success: false,
        statusCode: statusCode,
        message: forgetPasswordApiModel!.message ?? '',
      );
    }
  }
}

class ChangePasswordResponseMapper {
  getChangePasswordResponseMapper(
      {ChangePasswordApiModel? changePasswordApiModel,
      required int? statusCode}) {
    if ((statusCode == 200 || statusCode == 201)) {
      return CommonResponseUiModel(
        success: true,
        statusCode: statusCode,
        message: AppStrings().message_changePassword,
      );
    } else {
      return CommonResponseUiModel(
        success: false,
        statusCode: statusCode,
        message: changePasswordApiModel!.msg ?? '',
      );
    }
  }
}

class UpdateProfileResponseMapper {
  getUpdateProfileResponseMapper(
      {UserDetails? userDetails, required int? statusCode}) {
    try {
      if (statusCode == 200 || statusCode == 201) {
        List<ProjectDetailsUiModel>? getUserProjects(
            List<UsersProjectListApiModel>? projects) {
          List<ProjectDetailsUiModel>? userAssignedProjects = [];
          List<UsersProjectListApiModel>? activeProjectsList =
              projects!.where((element) => element.isActive!).toList();

          for (int j = 0; j < activeProjectsList.length; j++) {
            var element = activeProjectsList[j];
            ProjectDetailsUiModel projectUiModel = ProjectDetailsUiModel(
                projectName: element.projectName,
                projectCode: element.projectCode,
                roleCode: element.roleCode,
                projectID: '',
                isCheck: j == 0 ? true : false,
                isActive: element.isActive ?? false,
                roleName: element.roleName!.trim());
            userAssignedProjects.add(projectUiModel);
          }
          return userAssignedProjects;
        }

        String getUserAssignedProjects(
            List<UsersProjectListApiModel>? projects) {
          List<UsersProjectListApiModel>? activeProjectsList =
              projects!.where((element) => element.isActive!).toList();

          activeProjectsList
              .sort((a, b) => a.projectName!.compareTo(b.projectName!));
          String assignedProjects;
          StringBuffer buffer = StringBuffer();
          if (activeProjectsList.length == 1) {
            return projects.first.projectName!;
          } else {
            for (var element in activeProjectsList) {
              if (element.projectName != null &&
                  element.projectName!.isNotEmpty) {
                buffer.write(
                    '${element.projectName!.toString().toBeginningOfSentence()},');
              }
            }
          }
          assignedProjects = buffer.toString();
          return assignedProjects;
        }

        getUserProfilePicture(CommonFileObjectApiAndRequestModel? profilePic) {
          if (profilePic != null && profilePic.filename != null) {
            return FilePathUrls.getUserProfilePic + profilePic.filename!;
          } else {
            return null;
          }
        }

        getUserProfilePictureObject(
            CommonFileObjectApiAndRequestModel? profilePic) {
          if (profilePic != null && profilePic.filename != null) {
            CommonFileObjectApiAndRequestModel userProfilePic =
                CommonFileObjectApiAndRequestModel(
              filename: profilePic.filename,
              destination: profilePic.destination,
              size: profilePic.size,
              encoding: profilePic.encoding,
              fieldname: profilePic.fieldname,
              mimetype: profilePic.mimetype,
              path: profilePic.path,
              originalname: profilePic.originalname,
            );
            return userProfilePic;
          } else {
            return null;
          }
        }

        UserUiModel userUiModel = UserUiModel(
          accessToken: AppData().userDetailsUiModel!.accessToken,
          strategy: AppData().userDetailsUiModel!.strategy,
          username: userDetails?.username,
          lastName: userDetails?.lastName,
          firstName: userDetails?.firstName,
          createdAt: userDetails?.createdAt,
          isMobileOtpVerified: userDetails?.isMobileOtpVerified,
          email: userDetails?.email,
          id: userDetails?.id,
          idProofType: userDetails?.idProofType,
          isAdmin: userDetails?.isAdmin,
          isActive: userDetails?.isActive,
          phoneNumber: userDetails?.phoneNumber,
          profilePic: getUserProfilePicture(userDetails?.profilePic),
          profilePicObject:
              getUserProfilePictureObject(userDetails?.profilePic),
          registrationTokens: userDetails?.registrationTokens,
          updatedAt: userDetails?.updatedAt,
          type: userDetails?.type,
          designation: userDetails?.designation,
          emergencyContactName: userDetails?.emergencyContactName,
          emergencyContactNumber: userDetails?.emergencyContactNumber,
          emergencyContactRelation: userDetails?.emergencyContactRelation,
          organizationName: userDetails?.organizationName,
          temporaryPassword: userDetails?.temporaryPassword,
          assignedProjects: getUserProjects(userDetails?.projects),
          userAssignedProjects: getUserAssignedProjects(userDetails?.projects),
        );

        return UserLoginUiModel(
            data: userUiModel,
            message: '',
            isUserLoginSupported: true,
            statusCode: statusCode,
            success: statusCode == 200 || statusCode == 201 ? true : false);
      } else {
        return UserLoginUiModel(
            data: null,
            message: 'Invalid login',
            isUserLoginSupported: false,
            statusCode: statusCode,
            success: statusCode == 200 || statusCode == 201 ? true : false);
      }
    } catch (msg) {}
  }
}

class GetEmergencyContactsResponseMapper {
  getEmergencyContactsResponseMapper(
      {EmergencyContactApiModel? emergencyContactDetails,
      required int? statusCode}) {
    try {
      if (statusCode == 200 || statusCode == 201) {
        if (emergencyContactDetails?.data != null &&
            emergencyContactDetails!.data!.isNotEmpty) {
          getEmergencyContactData(
              List<EmergencyContactDataApiModel>?
                  emergencyContactDataApiModel) {
            List<EmergencyContactDataUiModel>? emergencyContactDataUiModelList =
                [];

            emergencyContactDataApiModel?.forEach((element) {
              EmergencyContactDataUiModel emergencyContactDataUiModel =
                  EmergencyContactDataUiModel(
                sId: element.sId,
                name: element.name.toString().toBeginningOfSentence(),
                contactNumber: element.contactNumber,
                contactNumberType: element.contactNumberType,
                details: element.details != null
                    ? "( ${element.details.toString().toBeginningOfSentence()} )"
                    : '',
              );
              emergencyContactDataUiModelList.add(emergencyContactDataUiModel);
            });
            return emergencyContactDataUiModelList;
          }

          return EmergencyContactUiModel(
              data: getEmergencyContactData(emergencyContactDetails.data),
              success: true,
              message: null,
              statusCode: statusCode,
              total: emergencyContactDetails.total);
        } else {
          return EmergencyContactUiModel(
              success: false,
              message: AppStrings().data_not_found,
              statusCode: statusCode,
              total: null);
        }
      } else {
        return EmergencyContactUiModel(
            success: false,
            message: AppStrings().data_not_found,
            statusCode: statusCode,
            total: null);
      }
    } catch (msg) {}
  }
}

class GetTrainingVideosResponseMapper {
  getTrainingVideosResponseMapper(
      {EmergencyContactApiModel? emergencyContactDetails, //Change this
      required int? statusCode}) {
    try {
      if (statusCode == 200 || statusCode == 201) {
        if (emergencyContactDetails?.data != null &&
            emergencyContactDetails!.data!.isNotEmpty) {
          getTrainingVideosData(
              List<EmergencyContactDataApiModel>?
                  emergencyContactDataApiModel) {
            List<TrainingVideosDataUiModel>? trainingVideosDataUiModelList = [];

            emergencyContactDataApiModel?.forEach((element) {
              TrainingVideosDataUiModel trainingVideosDataUiModel =
                  TrainingVideosDataUiModel(
                sId: element.sId,
                name: element.name.toString().toBeginningOfSentence(),
                contactNumber: element.contactNumber,
                contactNumberType: element.contactNumberType,
                details: element.details != null
                    ? element.details.toString().toBeginningOfSentence()
                    : '',
              );
              trainingVideosDataUiModelList.add(trainingVideosDataUiModel);
            });
            return trainingVideosDataUiModelList;
          }

          return TrainingVideosUiModel(
              data: getTrainingVideosData(emergencyContactDetails.data),
              success: true,
              message: null,
              statusCode: statusCode,
              total: emergencyContactDetails.total);
        } else {
          return TrainingVideosUiModel(
              success: false,
              message: AppStrings().data_not_found,
              statusCode: statusCode,
              total: null);
        }
      } else {
        return TrainingVideosUiModel(
            success: false,
            message: AppStrings().data_not_found,
            statusCode: statusCode,
            total: null);
      }
    } catch (msg) {}
  }
}
