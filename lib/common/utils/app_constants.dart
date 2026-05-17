// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:premises/app_config.dart';
import 'package:premises/application/application.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class PageLimit {
  static const int LIMIT = 10;
}

class FreemiumUserRoles {
  static const String MOBILE_ADMIN = 'PAT';
  static const String MOBILE_USER = 'MUT';
}

class AppEnvironments {
  static const int APP_DEVELOPMENT = 1;
  static const int APP_QA = 2;
  static const int APP_UAT = 3;
  static const int APP_PRODUCTION = 4;
}

class IconAssetType {
  static const int SVG_ICON = 1;
  static const int ASSET_ICON = 2;
}

class FontFamily {
  static const fontFamily = "Outfit";
}

class SplashScreenTime {
  static const int DEFAULT_TIME = 4;
}

class ApiTimeOutDuration {
  static const Duration apiTimeOutDuration = Duration(seconds: 45);
}

class FileSizeLimit {
  static const int singleFileSize = 5; //in mb
  static const int bulkFileSize = 25; //in mb
}

class HiveBox {
  static const String PENDING_TASK_BOX = 'pending_task_box';
  static const String INDT_SKILL_LEVELS_BOX = 'skill_levels_box';
  static const String INDT_POLICY_TYPES_BOX = 'policy_types_box';
}

class ToastType {
  static const int TOAST_SUCCESS = 1;
  static const int TOAST_ERROR = 2;
  static const int TOAST_WARNING = 3;
  static const int TOAST_GENERAL = 4;
}

class CachedNetworkImageHeader {
  static var headers = {
    'Authorization': SharedPrefsInstance.instance!.getString(
      SharedPrefConstants.getAuthToken,
    )!,
  };
}

class ContentType {
  static const String multipart_form_data = 'multipart/form-data';
  static const String image_jpeg = 'image/jpeg';
  static const String video_mp4 = 'video/mp4';
  static const String pdf = 'application/pdf';
  static const String doc = 'application/doc';
  static const String docx = 'application/docx';
}

class CalendarType {
  static const int DATE_PICKER = 1;
  static const int DATE_TIME_PICKER = 2;
  static const int DATE_TIME_RANGE_PICKER = 3;
  static const int DATE_RANGE_PICKER = 4;
  static const int BIRTH_DATE_PICKER = 5;
  static const int MOBILE_DASHBOARD_DATE_RANGE_PICKER = 6;
  static const int DATE_TIME_PICKER_TASK_MODULE = 7;
  static const int DATE_TIME_PICKER_EVENT_MODULE = 8;
  static const int DATE_TIME_PICKER_EVENT_COMPLETE = 9;
}

enum WpStatus {
  OPEN,
  INREVIEW,
  REJECTED,
  SUSPENDED,
  ACCEPTED,
  EDIT,
  RESUBMITTED,
  AUDIT_ACCEPTED,
  AUDIT_REJECTED,
  CLOSED,
  REASSIGN_CHECKERS_OPEN,
  REASSIGN_CHECKERS_INREVIEW,
  DRAFT,
  COMPLETED,
  INPROGRESS,
  CANCELLED,
  REOPEN,
}

class FormTextStyles {
  static var textFormFieldHintStyle = TextStyle(
    fontFamily: FontFamily.fontFamily,
    fontSize: TextSize().small,
    fontWeight: FontWeight.w400,
    color: AppColors.text_grey_g2,
  );

  static var textFormFieldInputTextStyle = TextStyle(
    fontFamily: FontFamily.fontFamily,
    fontSize: TextSize().small,
    fontWeight: FontWeight.w400,
    color: AppColors.text_grey,
  );

  static var textFormFieldErrorStyle = TextStyle(
    fontFamily: FontFamily.fontFamily,
    fontSize: TextSize().xsmall,
    fontWeight: FontWeight.w400,
    color: AppColors.text_asteriskColor_color,
  );
}

class SharedPrefConstants {
  static var getUserLoginStatus = "isLoggedIn";
  static var getAuthToken = "accessToken";
  static var getRefreshToken = "refreshToken";
  static var getUserId = "userId";
  static var getUserName = "userName";
  static var getOnlineOfflineModule = "isOnline";
  static var getProjectId = "projectId";
  static var getProjectName = "projectName";
  static var getProjectCode = "projectCode";
  static var getUserDetails = "userDetails";
  static var assignedProjectDetails = "assignedProjects";
  static var currentProject = "currentProject";
  static var lastCheckupOn = "lastCheckupOn";
  static var lastSyncedServerDate = "serverDate";
  static var userContactNumber = "userContactNumber";
  static var isVisitorOTPVerified = "isVisitorOTPVerified";
  static var visitoremailId = "visitoremailId";
  static var projectSId = "projectSId";
  static var isOfflineUsageDialogShow = "isOfflineUsageDialogShow";
}

class FilterConstants {
  //MAP
  static const String FILTER_LIST_KEY = 'FILTER_LIST';
  static const String FROM_DATE_KEY = 'FROM_DATE';
  static const String FROM_DATE_ALERT_KEY = 'FROM_DATE_ALERT';
  static const String TO_DATE_KEY = 'TO_DATE';
  static const String TO_DATE_ALERT_KEY = 'TO_DATE_ALERT';
  static const String MIN_AMOUNT = 'MIN_AMOUNT';
  static const String MAX_AMOUNT = 'MAX_AMOUNT';

  //FLAGS
  static const String INCIDENT_LIST = 'IncidentList';
  static const String INJURED_PEOPLE = 'InjuredPeople';
  static const String SAFETY_ACTIONABLE_ASSIGNOR = 'SafetyActionableAssignor';
  static const String SAFETY_ACTIONABLE_ASSIGNEE = 'SafetyActionableAssignee';
  static const String WORK_PERMIT = 'WorkPermit';
  static const String CEHCKLIST = 'Checklist';
  static const String ON_DEMAND_CHECKLIST = 'OnDemandCheckList';
  static const String VIOLATION_NOTE = 'ViolationNote';
  static const String PROJECT_LABOR = 'ProjectLabor';
  static const String PROJECT_LABOR_ACTIVE = 'ProjectLaborActive';
  static const String WORK_FORCE = 'WorkForce';
  static const String TASKBYME = 'TaskByMe';
  static const String TASKFORME = 'TaskForMe';
  static const String TASKALERT = 'TaskAlert';
  static const String ALLTASK = 'AllTask';
  static const String OHS_DOCUMENT = 'OHS_Document';
  static const String STATUS = 'STATUS';
}

class FilePathUrls {
  static String getInducteeProfilePicAdmin =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/inducteephotos/';

  static String getPPEPicAdmin =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/inducteeppepics/';

  String getInducteeIdProofPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/inducteeidproofphotos/';

  static String getInducteeIdProofPhotosAdmin =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/inducteeidproofphotos/';

  String contractorWorkOrderPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/contractorworkorderphotos/';

  String rcaDocumentURLProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/rcaDocuments/';

  String caDocumentsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/cadocuments/';

  String caPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/caphotos/';

  String paDocumentsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/padocuments/';

  String paPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/paphotos/';

  String getWitnessSignatureProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/witness/signatures/';

  static String getInducteeFitnessCertificateAdmin =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/fitnesscertificates/';

  String getFitnessCertificatesPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/fitnesscertificates/';

  // String machineryAuthorizationDocsProject =
  //     '${Environment.baseUrl}${Apis.adminBaseUrl}/safetydocuments/';

  static String getSecondaryLogoAdmin =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/report/secondarylogo/';

  String taskPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/taskphotos/';

  String attendeesSignature =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/events/signatures/';

  String checkListAttachedDocumentsBaseUrl =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/';

  String violationPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/violationcasedetails/photos/';

  String responseAttachmentsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/taskconversation/attachments/';

  String wpPhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/workpermits/photos/';

  String safetyActionablePhotosProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/safetyactionablephotos/';

  //get incident photos
  String getIncidentPhotoProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/photos/';

  //get incident other witness profile pic
  String getOtherWitnessProfilePicProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/incident/otherwitness/profilepics/';

  //get incident other witness profile pic
  String getPrecuationsAttachmentsForWorkPermitProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/workpermits/precautionphotos/';

  String getProjectPhotoDisplayUrl =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/project/photo/';

  String getInducteeProfilePicProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/inducteephotos/';

  String tbtGroupPhotos =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/toolboxtraining/groupPhotos/';

  static String getUserProfilePic =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/users/profilepic/';

  static String getChecklistImage =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/';

  static String tbtActivityDocuments =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/toolboxtrainingactivitydocument/';

  static String getInductionCategoryDocumentsFile =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/getInductionCategoryDocuments/';

  static String workpermitDocuments =
      '${Environment.baseUrl}${Apis.adminBaseUrl}/workpermitdocumentsrequired/document/';

  String machineryAuthorizationDocsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/machineryauthorizationdocs/';

  String trainingDocsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/trainingdocs/';

  String workAuthorizationDocsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/workauthorizationdocs/';

  String policyDocsProject =
      '${Environment.baseUrl}${Apis.projectBaseUrl}/${AppData().userCurrentSelectedProject!.projectCode}/policydocuments/';
}


class ApiParams {
  static const String SKILL_LEVEL = "skillLevel";
  static const String CONTENT_TYPE = "Content-Type";
  static const String BEARER = "Bearer ";
  static const String AUTHORIZATION = "Authorization";
  static const String PROJECT_ID = "projectID";
  static const String PROJECT_CODE = "projectCode";
  static const String PEOPLE_TYPE = "peopleType";
  static const String project_id = "projectid";
  static const String USER_ID = "userid";
  static const String ID = "id";
  static const String USER_NAME = "username";
  static const String STATUTES = "statuses";
  static const String ROLE_CODE = "roleCode";
  static const String ROLE = "role";
  static const String DASHBOARD_SOURCE = "dashboardSource";
  static const String DASHBOARD_ROLE_CODE = "dashboardRoleCode";
  static const String DASHBOARD_USER_ID = "dashboardUserId";
  static const String DASHBOARD_USER_NAME = "dashboardUserName";
  static const String SKIP = "skip";
  static const String LIMIT = "limit";
  static const String FROM_DATE = "fromDate";
  static const String TO_DATE = "toDate";
  static const String SELECT_LIST = "select[]";
  static const String DOCUMENT_NAME = "documentName";
  static const String CATEGORY_NAME = "categoryName";
  static const String SEVERITY_LEVEL = "severityLevel";
  static const String INCIDENT_CODE = "incidentCode";
  static const String DETAILS = "details";
  static const String SAFETY_ACTIONABLE_CODE = "safetyActionableCode";
  static const String WORK_PERMIT_ID = "workpermitid";
  static const String TBT_ID = "toolboxTrainingId";
  static const String ACTIVITY_ID = "activityID";
  static const String NAME = "name";
  static const String SEQUENTIAL_ID = "sequentialId";
  static const String TOOLBOX_TRAINING_CODE = "toolboxtrainingCode";
  static const String TOOLBOX_TRAINING_NAME = "toolboxTrainingName";
  static const String INDUCTEE_FULL_NAME = "inducteefullname";
  static const String INDUCTEE_ID = "inducteeId";
  static const String Needs_Attention_ID = "needsattentionid";
  static const String PREVIOUS_DAYS = "previousdays";
  static const String ID_PROOF_TYPE = "idProofType";
  static const String CATEGORY_DETAILS = "categoryDetails";
  static const String EMAIL = "email";
  static const String PROFILE_PIC = "profilePic";
  static const String FILE = "file";
  static const String ENTITLEMENT_CODE = "entitlementCode";
  static const String CREATERID = "createrid";
  static const String REVIEWERID = "reviewerid";
  static const String CATEGORY_CODE = "categoryCode";
  static const String SELECT = 'select';
  static const String MODULENAME = 'moduleName';
  static const String SORTASC = 'sortAsc';
  static const String SORTDESC = 'sortDesc';
  static const String CONTRACTORFIRM = 'contractorfirm';
  static const String CONTRACTORFIRMNAME = 'contractorFirmName';
  static const String CONTRACTORFIRMLABOURSEARCH = 'contractorFirm';
  static const String INDUCTION_TRAINING_ID = "inductiontrainingid";
  static const String IS_OCCUPIED = "isOccupied";

  //static const String MAKER = "makerId";
  static const String ASSIGNED = "assigneeId";
  static const String CATEGORY = "category";
  static const String TRADE = "trade";
  static const String TRADE_NAME = "tradeName";
  static const String INDUCTEE_NAME = "inducteeName";
  static const String CREATED_BY_ID = "createdById";
  static const String FROM_DATE_SA = "createdAtFrom";
  static const String TO_DATE_SA = "createdAtTo";
  static const String RISK_LEVEL = "riskLevel";
  static const String SOURCE_OF_OBSERVATION = "sourceObservation";
  static const String ISACTIVE = "isActive";
  static const String HAS_MANAGER_ACTED = "hasManagerActed";
  static const String isProjectViolationsList = "isProjectViolationsList";
  static const String ISEXIST = "isExists";
  static const String ISACTIVEVERSION = "isActiveVersion";
  static const String CREATED_BY_ID_ID = "createdBy.id";
  static const String ISINDUCTED = "isinducted";
  static const String ISVIOLATIONLIST = "isViolationList";
  static const String incidentDateTo = "incidentDateTo";
  static const String incidentDateFrom = "incidentDateFrom";

  static const String FROMDUEDATE = "fromDueDate";
  static const String TODUEDATE = "toDueDate";
  static const String ACTIVATIONTYPES = "activationtypes.value";
  static const String CHECKLISTTYPE = "checklistType";
  static const String CHECKLIST_ID = "checklistId";
  static const String PROJECTS_PROJECTCODE = "projects.projectCode";
  static const String VIOLATION_ID = "recordId";
  static const String INTIMERANGE = "inTimeRange";
  static const String OUTTIMERANGE = "outTimeRange";
  static const String FIRSTINTIME = "firstInTime";
  static const String LASTOUTTIME = "lastOutTime";
  static const String createdAtTo = "createdAtTo";
  static const String createdAtFrom = "createdAtFrom";
  static const String alertCreatedAtFrom = "alertCreatedAtFrom";
  static const String alertCreatedAtTo = "alertCreatedAtTo";

  //TBT Filters
  static const String TBT_ACTIVITY_ID = "activityId";
  static const String STATUS = "status";
  static const String TYPE = "type";
  static const String TBT_TO_DATE = "todate";
  static const String TBT_FROM_DATE = "fromdate";
  static const String isInformed = "isInformed";
  static const String hasActed = "hasActed";
  static const String STATUSES = "statuses";
  static const String MAKER_ID_NOT_IN = "makerIdNotIn";

  //Incidents
  static const String incidentPhotos = "incidentPhotos";
  static const String details = "details";
  static const String locationOfIncident = "locationOfIncident";
  static const String severityLevel = "severityLevel";
  static const String injuredPeople = "injuredPeople";
  static const String witnessesOfIncident = "witnessesOfIncident";
  static const String otherWitnessesOfIncident = "otherWitnessesOfIncident";
  static const String otherWitnessOfIncidentProfilePics =
      "otherWitnessOfIncidentProfilePics";
  static const String rca = "rca";
  static const String correctiveAction = "correctiveAction";
  static const String preventiveAction = "preventiveAction";
  static const String responsiblePerson = "responsiblePerson";
  static const String incidentCode = "incidentCode";
  static const String getPeopleAtIncidentSearchKey =
      "getPeopleAtIncidentSearchKey";
  static const String getResponsiblePersonSearchKey = "nameString";
  static const String getPeopleAtIncidentFilterKey =
      "getPeopleAtIncidentFilterKey";
  static const String createdBy = "createdBy";
  static const String updatedBy = "updatedBy";
  static const String saphotos = "photos";
  static const String searchTxt = "searchtxt";
  static const String MAKER_ID = "makerId";
  static const String CHECKER_ID = "checkerId";
  static const String CONTRACTOR_FIRM_CODE = "contractorFirmCode";
  static const String CONTRACTOR_FIRM_CODES = "contractorFirmCodes";
  static const String TRADE_CODE = "tradeCode";
  static const String CREATED_AT_TO = "createdAtTo";
  static const String CREATED_AT_FROM = "createdAtFrom";
  static const String SOURCE = "source";
  static const String CONTRACTORGROUPNAMEANDNUMBER =
      "contractorGroupNameAndNumber";
  static const String RESPONSIBLE_PERSON = "responsiblePerson";
  static const String designation = "designation";
  static const String getUndraftedRecords = "getUndraftedRecords";

  static const String sort = "\$sort[createdAt]";

  //Work Permit filters
  static const String MAIN_AREA_NAME = "mainAreaName";
  static const String CONTRACTOR_FIRM_IDS = "contractorFirmIds";
  static const String SUB_AREA_NAME = "subAreaName";
  static const String SearchKey = "searchKey";

  //QR Code Scan
  static const String FIRST_NAME = "firstName";
  static const String LAST_NAME = "lastName";
  static const String AADHAR_NUMBER = "aadhaarNumber";
  static const String USER_CODE = "userCode";
  static const String WORK_DATEGTE = "workDate[\$gte]";
  static const String WORK_DATEIT = "workDate[\$lt]";
  static const String LABOUR_CODE = "labourCode";
  static const String PROJECT_ID_QUERY = "projectId";
  static const String INDUCTEE_CATEGORY = "category";
  static const String IN_TIME = "inTime";
  static const String OUT_TIME = "outTime";

  static const String GEOLOCATION = "geolocation";

  static const String checkListIds = "_id";

  static const String CONTRACTORFIRMCODES = "contractorFirmCodes";

  //Debit Note
  static const String CONTRACTOR_FIRM = "contractorFirm";
  static const String SORT_BY = "sortDesc";
  static const String CONTACT_NUMBER = "contactNumber";
  static const String LABOR_NAME = "labourName";
  static const String LABOR_CODE = "labourCode";
  static const String CONTRACTOR_GROUP_NAME = "contractorGroupName";

  static const String IS_BULK_INDUCTION = "isBulkInduction";
  static const String CATEGORIES = "categories";

  //task
  static const String TASK_ID = "taskId";
  static const String LOCATION_OF_VIOLATION = "location";
  static const String PRIORITY = "priority";
  static const String ISSHOWDELAYED = "isShowDelayed";
  static const String ASSIGNOR = "assignorUserName";
  static const String ASSIGNEE = "assigneeUserName";
  static const String ALERTERCIPIENT = "alertRecipient";
  static const String MYALERTS = "myalerts";

  static const String UUID = "uuid";
  static const String ISDELAYED = "isDelayed";
  static const String SEARCHTEXT = "searchText";
  static const String TASK_CODE = "taskCode";
  static const String GROUP_CODE = "groupCode";
  static const String EMAIL_ID = "emailId";
  static const String OTP = "otp";
  static const String VISITOR_CODE = "visitorCode";
  static const String VISITOR_ID = "visitorId";
  static const String SEARCH_STRING = "searchString";
  static const String EVENT_TYPE = "type";
  static const String eventFromDate = "eventFromDate";
  static const String eventToDate = "eventToDate";
  static const String EVENT_ID = "eventId";
  static const String MAKER = "maker";
  static const String REVIEWER = "reviewer";
  static const String EXPIRE_ID = "expireID";
  static const String FLAG = "flag";
  static const String ADMIN_USER_NAME = "adminUserName";
  static const String User_Name = "userName";
  static const String Email_OTP = "emailOtp";
  static const String Mobile_OTP = "mobileOtp";
  static const String Mobile_Number = "mobileNumber";
  static const String projectName = "projectName";
  static const String roleCode = "roleCode";
  static const String nameString = "nameString";
  static const String download = "download";
  static const String incidentDateAndTime = "incidentDateAndTime";
  static const String activity = "activity";
  static const String siteEngineer = "siteEngineer";
  static const String siteOfficer = "safetyOfficer";
  static const String rcaStatement = "rcaStatement";
  static const String rcaBy = "rcaBy";
  static const String rcadocument = "rcaDocuments";
  static const String status = "status";
  static const String immediateActionTaken = "actionTaken";
  static const String equipmentsInvolved = "equipments";
  static const String action = "action";
  static const String natureOfInjury = "natureOfInjuries";
  static const String typeOfAccident = "typeOfAccidents";
  static const String otherEquipment = "otherEquipment";
  static const String otherNatureInjury = "otherNatureInjury";
  static const String otherAccidentType = "otherAccidentType";
  static const String cacheControl = "Cache-Control";
  static const String cacheControlValue = "max-age=3600";
}


class Apis {
  //User Management
  static const String adminBaseUrl = '/admin/api/v1';

  static const String projectBaseUrl = '/project/api/v1';

  static const String userLogin = '$adminBaseUrl/authentication';

  static const String forgetPassword = '$adminBaseUrl/users/forgotpassword';

  static const String changePassword = '$adminBaseUrl/users/changepassword';

  static const String updateUserProfile =
      '$adminBaseUrl/users/{${ApiParams.USER_ID}}';

  //update user profile
  static const String postFaceScanImage =
      '/project/api/v1/{${ApiParams.PROJECT_CODE}}/face-recognition/attendance';

  //User Project Entitlements
  //Dashboard
  static const String getUserEntitlementsProjectWise =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/authorization';

  static const String getProjectPhoto =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/project';

  static const String getDashboardPendingCounts =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/project';

  static const String getGlobalConfigurations =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/configurations';

  static const String getUserAssignedProjects =
      '$adminBaseUrl/user/activeprojects';

  //Emergency Contacts
  static const String getEmergencyContacts =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/emergencycontacts';

  // Incident Report
  static const String getAccidentsList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/report/list';

  static const String getIncidentListForMe =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/alluserslist';

  static const String getAccidentsListByProjectUser =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incidents';

  static const String geofencing =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/geofencing';

  static const String editIncidentReport =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incidents/{${ApiParams.ID}}';

  static const String getIncidentReportDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/report/{${ApiParams.ID}}';

  static const String postRCAAndCAPA =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incidents/{${ApiParams.ID}}';

  static const String postCAPAResponsiblePersonActions =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incidents/{${ApiParams.ID}}';

  static const String postRCA =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incidents/{${ApiParams.ID}}';

  static const String downloadIncidentReport =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incidents/{${ApiParams.ID}}';

  static const String getInjuredPeopleList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/people';

  static const String getIncidentSeverityLevel =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/accidentseveritylevel';

  static const String getResponsiblePerson =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/capa/responsiblepeople/{${ApiParams.ID}}';

  static const String getCAPAForm =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/capa/{${ApiParams.ID}}';

  static const String getRCAForm = '$adminBaseUrl/rootcauses';

  static const String getCorrectiveActions = '$adminBaseUrl/correctiveactions';

  static const String getWitnessList = '/accident/witnesses';

  static const String getCategoryList = '$adminBaseUrl/categories';

  static const String getRolesList = '$adminBaseUrl/roles';

  static const String getSiteEngineers =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/siteengineer';

  static const String getSafetyOfficers =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/safetyofficer';

  static const String getIncidentInvestigators =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/investigationuserslist';

  static const String getRCACAPAAuthorsList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/incident/caparcalist';

  static const String getAccidentTypes = '$adminBaseUrl/accidenttypes';

  static const String getEquipmentTypes = '$adminBaseUrl/equipmenttypes';

  static const String getInjuredBodyParts = '$adminBaseUrl/injurybodyparts';

  static const String getNatureOfInjuryTypes =
      '$adminBaseUrl/natureinjurytypes';

  // Safety Observation
  static const String getSafetyObservations =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/safetyactionables/';

  static const String getSafetyActionableDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/safetyactionables//{${ApiParams.Needs_Attention_ID}}';

  static const String downloadSafetyActionableReportExcel =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/safetyactionables';

  static const String downloadSafetyActionableReportPDF =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/safetyactionables/{${ApiParams.ID}}';

  static const String createSafetyActionable =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/safetyactionables/';

  static const String postReassigneePeople =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/safetyactionables/{${ApiParams.ID}}';

  static const String sourceOfObservation =
      '$adminBaseUrl/sourceofobservations/';

  static const String assigneeList =
      '$adminBaseUrl/safetyactionable/assignees/{${ApiParams.USER_ID}}';

  static const String getSafetyActionableType =
      '$adminBaseUrl/safetyactionabletypes';

  static const String severityLevel = '$adminBaseUrl/severitylevels';

  static const String issueRiskLevel = '$adminBaseUrl/issuerisklevels';

  static const String getSafetyCategory =
      '$adminBaseUrl/safetyactionablecategories';

  //Toolbox Training
  static const String getToolboxTrainingTbtAll =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtrainings';

  static const String getToolboxTrainingTbtCreater =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtraining/tbtcreater';

  static const String getToolboxTrainingTbtReviewer =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtraining/tbtreviewer';

  static const String getWorkPermitsForTBT =
      '/getprojectworkpermitdataforofflinesync';

  static const String getToolboxTrainingDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtrainings/{${ApiParams.TBT_ID}}';

  static const String getToolboxTrainingForWorkPermit =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/gettbtdata';

  static const String getToolboxTrainingActivities =
      '$adminBaseUrl/toolboxtrainingactivities';

  static const String getToolboxTrainingInstructions =
      '$adminBaseUrl/toolboxtraininginstructions';

  static const String getToolboxTrainingDocuments =
      '$adminBaseUrl/toolboxtrainingactivitydocuments';

  static const String getReviewersForTBT =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtraining/reviewers';

  static const String getTraineesForTBT =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtraining/trainees';

  static const String createTBT =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtrainings';

  static const String closeTBT =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtrainings/{${ApiParams.TBT_ID}}';

  //Induction Training
  static const String getSkillLevels = '$adminBaseUrl/skilllevels';
  static const String getPolicyTypes = '$adminBaseUrl/policytypes';
  static const String getWorkAuthorizationTypes =
      '$adminBaseUrl/workauthorizationtypes';
  static const String getMachineryAuthorizationTypes =
      '$adminBaseUrl/machineryauthorizationtypes';
  static const String getTrainingCompletedTypes =
      '$adminBaseUrl/trainingcompletedtypes';

  static const String getInducteeCategories =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontrainings/categorycounts';

  static const String getInducteeMobCategories = '$adminBaseUrl/mobcategories';

  static const String getInductionCategoryDocuments =
      '$adminBaseUrl/inductioncategorydocuments';

  static const String getInductionTrainingtrainingvideos =
      '$adminBaseUrl/inductiontrainingtrainingvideos';

  static const String getInductionUndertakings = '$adminBaseUrl/undertakings';

  static const String getTrades = '$adminBaseUrl/trades';

  static const String getReasonForVisit = '$adminBaseUrl/reasonsforvisit';

  static const String getDependentRelations =
      '$adminBaseUrl/dependantrelations';

  static const String getQuarterDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/labourcamps';

  static const String getLabourCampAddress = '$adminBaseUrl/labourcampaddress';

  static const String getStaffDesignation = '$adminBaseUrl/designations';

  static const String getIDProfTypes = '$adminBaseUrl/idprooftypes';

  static const String getInductee = '$adminBaseUrl/category/inductee';

  static const String checkLabourFitnessStatus = '$adminBaseUrl/labours';

  static const String getSafetyEquipments = '$adminBaseUrl/safetyequipments';

  static const String getLaboursForBulkInduction =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontraining/labours';

  static const String getInductionTrainingInstructions =
      '$adminBaseUrl/inductiontraininginstructions';

  static const String createInductionTraining =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontrainings';

  static const String createBulkInductionTraining =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontraining/bulkinduction';

  static const String updateLabour =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/mobile/labour';

  static const String getDesignationsList = '$adminBaseUrl/users/';

  static const String contractorFirms = '$adminBaseUrl/contractorfirms';

  static const String getInducteesCategoryForOfflineSync =
      '/getinducteecategorydataforofflinesync';

  static const String getInductionTrainingDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontrainings/{${ApiParams.INDUCTION_TRAINING_ID}}';

  static const String getInductionTrainingList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontrainings';

  static const String checkInductionUniqueness =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inductiontraining/checkInductionUniqueness';

  static const String inductionOptimization = '$adminBaseUrl/labourformfields';

  static const String postOCRDocumentPhotos = "/ocr/api/v1/upload";

  //ID Card Attendance
  static const String getSearchedIDCardList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/idcard/list';

  static const String attendanceCapture =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/inandout/inandoutEntry';

  static const String checkAttendaceCapture =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/masterworkhours';

  static const String getLabourDigitalProfile =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/labour-idcard-data/{${ApiParams.LABOUR_CODE}}';

  static const String downloadLabourDigitalProfilePdf =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/labour-digital-profile-pdf/{${ApiParams.LABOUR_CODE}}';

  //Work Permit
  static const String mainSubArea =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/mainareassubareas/';

  static const String workPermitCategories =
      '$adminBaseUrl/workpermitcategories';

  static const String getContractorFirmList = '$adminBaseUrl/contractorfirms';

  static const String workPermitDocumentsRequired =
      '$adminBaseUrl/workpermitdocumentsrequired';

  static const String workPermitHazards = '$adminBaseUrl/workpermithazards';

  static const String workPermitPrecautions =
      '$adminBaseUrl/workpermitprecautions';

  static const String workPermitPPE = '$adminBaseUrl/workpermitppes';

  static const String workPermitToolsandEquipments =
      '$adminBaseUrl/workpermittoolsandequipments';

  static const String workPermitCheckers =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermit/checkers';

  static const String workPermitCheckersV1 =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/toolboxtraining/reviewers';

  static const String workpermitList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermits/';

  static const String postWorkPermit =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermits/data';

  static const String workPermitDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermits/{${ApiParams.WORK_PERMIT_ID}}';

  static const String requestTimeExtensionWorkPermit =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermit/timeExtention/{${ApiParams.WORK_PERMIT_ID}}';

  static const String updateTimeExtensionWorkPermitStatus =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermitcheckers/{${ApiParams.CHECKER_ID}}';

  static const String postReassignCheckers =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/workpermits/data/{${ApiParams.ID}}';

  //Checklist
  static const String getChecklistForEngineer = '/checklist/list';

  static const String checklistList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/checklists';

  static const String onDemandChecklist =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/projectchecklists';

  static const String checklistDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/checklistinformation';

  static const String postChecklist =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/answersheets';

  static const String postChecklistActions =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/answersheets/{${ApiParams.CHECKLIST_ID}}';

  static const String reassignCheckList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/checklistinformation/{${ApiParams.ID}}';

  static const String downloadProjectScoring =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/downloadscoringpdf/{${ApiParams.ID}}';

  static const String getCheckListRejectReasons =
      '$adminBaseUrl/checklist/rejections';

  static const String getReviewers =
      '$adminBaseUrl/checklistsettings/assignees/{${ApiParams.USER_ID}}';

  static const String deleteCheckList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/checklists';

  static const String getTaskPriority =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/taskturnaroundtimeconfigurations';

  static const String getSpotGroups =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/spotgroups';

  static const String getChecklistNumber =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/checklistuserconfigs';

  static const String getSpotNames =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/spots/';

  //violation notice and Debit note
  static const String violationSeverities = '$adminBaseUrl/violationseverities';

  static const String violationAllTabList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/debitviolationdetails';

  static const String violationTabList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/violationcasedetails';

  static const String violationCaseDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/violationcasedetails/{${ApiParams.VIOLATION_ID}}';

  static const String debitViolationDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/debitviolationdetails/{${ApiParams.VIOLATION_ID}}';

  static const String downloadViolationDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/debitviolationdetails/{${ApiParams.VIOLATION_ID}}';

  static const String receivingPerson =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/violationcasedetails/receivers';

  //Project Labours
  static const String getProjectLabors =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/projectlabours';

  static const String getProjectLaborById = '$adminBaseUrl/web/labour';

  static const String patchLabourActivationStatus =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/projectlabour/activationhistory';

  static const String contractorGroupNameProject =
      '$adminBaseUrl/contractorgroups';

  static const String getImportLaborsOnProject =
      '$adminBaseUrl/project/labours';

  static const String addLaborsToProject =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/project/labours';

  static const String getTodaysWorkForce =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/scanid/todaysworkforce';

  static const String contractorFirmsProject = '$adminBaseUrl/contractorfirms';

  // Manager Dashboard Project
  static const String getManagerDashboardProjet =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/project';

  //Task
  static const String createTask =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/tasks';

  static const String taskList =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/tasks';

  static const String taskDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/tasks/{${ApiParams.TASK_ID}}';

  static const String taskPatch =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/tasks/{${ApiParams.TASK_ID}}';

  static const String taskconversations =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/taskconversations';

  //Visitors
  static const String getVisitorProjectList = '$adminBaseUrl/projects';

  static const String getVisitorReasonList = '$adminBaseUrl/visitreasons';

  static const String getOTPForVisitor = '$adminBaseUrl/otps';

  static const String verifyOTPForVisitor = '$adminBaseUrl/otps';

  static const String getVisitorsList = '$adminBaseUrl/visitors';

  static const String expireOTPVisitor =
      '$adminBaseUrl/otps/{${ApiParams.EXPIRE_ID}}';

  static const String getVisitorsById =
      '$adminBaseUrl/visitors/{${ApiParams.VISITOR_ID}}';

  //Events And Trainings
  static const String getEventTypes = '$adminBaseUrl/eventtypes';

  static const String getInstructorTypes = '$adminBaseUrl/instructortypes';

  static const String scheduleEvent =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/events';

  static const String closeEvents =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/closeevents';

  static const String updateEvent =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/events/{${ApiParams.EVENT_ID}}';

  static const String downloadEventDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/events/{${ApiParams.EVENT_ID}}';

  //Freemium Users
  static const String createOrUpdateUser = '$adminBaseUrl/users';

  static const String inviteUser = '$adminBaseUrl/invite-user';

  static const String freemiumUserUpdate =
      '$adminBaseUrl/users/{${ApiParams.USER_ID}}';

  static const String deleteFreemiumUser =
      '$adminBaseUrl/users/{${ApiParams.USER_ID}}';

  static const String createProject = '$adminBaseUrl/projects';

  static const String editProjectDetails =
      '$projectBaseUrl/{${ApiParams.PROJECT_CODE}}/project/{${ApiParams.PROJECT_ID}}';

  static const String requestAccess = '$adminBaseUrl/freemiumrequestproject';

  static const String updateRequestStatus =
      '$adminBaseUrl/freemiumrequestproject/{${ApiParams.ID}}';

  static const String getOTPUser = '$adminBaseUrl/freemiumappotps';

  static const String getFreemiumProjects = '$adminBaseUrl/getFreemiumProjects';

  static const String freemiumUsers = '$adminBaseUrl/users';

  static const String getOHSDocuments = '$adminBaseUrl/ohsdocument';
}
