import 'package:camera/camera.dart';
import 'package:premises/features/offline_sync/offline_sync.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/features/user_management/user_management.dart';

class AppData {
  static final AppData _appData = AppData._internal();

  AppData._internal();

  factory AppData() => _appData;

  List<CameraDescription>? availableCameraList = [];

  UserUiModel? userDetailsUiModel;
  UserLocationDetails? userLocationDetails;
  String? userid;
  String? userName;
  String? projectid;
  String? projectName;
  String? projectCode;
  String? userContactNumber;
  String? projectSId;
  bool? isTraineeSignatureMandatory;
  bool? isWorkPermitMandatory;
  bool? isTBTGroupPhotoGalleryAllowed;
  bool? isInductionProfileGalleryAllowed;
  bool? isSafetyObservationRaiseGalleryAllowed;
  bool? isSafetyObservationResolveGalleryAllowed;
  bool? isSafetyObservationCloseGalleryAllowed;
  bool? ocrAccessKey;
  bool? allowToFetchSignatureFromInductionForTBTTrainee;
  bool? allowToFetchSignatureFromInductionForEventAttendees;
  // List<SignatureConfigurationUIModel> eventSignatureConfigurations = [];
  // List<SignatureConfigurationUIModel> tbtSignatureConfigurations = [];
  bool? isTBTReviewerMandatory = false;
  bool? isSelectAllAllowed = false;
  String? makerStr;
  String? checkerStr;
  String? checkerInitials;
  int? hoursLimit;

  String? firebaseToken;
  List<ProjectDetailsUiModel>? assignedProjects;
  ProjectDetailsUiModel? userCurrentSelectedProject;

  // EntitlementPermissionsUiModel? inductionTrainingEntitlements;
  // EntitlementPermissionsUiModel? tbtEntitlemnets;
  // SafetyScreenArgs? safetyActionableEntitlements;
  // EntitlementPermissionsUiModel? incidentReportEntitlements;
  // EntitlementPermissionsUiModel? workPermitEntitlements;
  // EntitlementPermissionsUiModel? checkListEntitlements;
  // OfflineSyncScreenArguments? customOfflineSyncModule;
  // EntitlementPermissionsUiModel? scanQRCodeEntitlements;
  // EntitlementPermissionsUiModel? workforceEntitlements;
  // EntitlementPermissionsUiModel? violationEntitlements;
  // EntitlementPermissionsUiModel? projectLaborsEntitlements;
  // EntitlementPermissionsUiModel? mobileDashboardEntitlements;
  // EntitlementPermissionsUiModel? taskModuleEntitlements;
  // EntitlementPermissionsUiModel? visitorScanEntitlements;

  String? lastCheckupOn;
  bool? storagePermission = false;
  bool? notificationPermission = false;
  bool? microphonePermission = false;
  DateTime? lastSyncedServerDate;
  String? appVersion;
  String? uniqueDeviceId;
  String? visitorEmailId;
  String? userAssignedProjectsForProfile;
  bool? isVisitorOTPVerified;
  bool? isOfflineUsageDialogShow = false;
  bool? isOnlineModuleEnabled = false;
  bool? isMixpanelSupported = false;
  bool? isFreemiumSupported = false;
  int? currentUserSelectedProjectIndex = 0;
  String? youTubeLinkMobile;
  bool isForceRefreshData = true;
}
