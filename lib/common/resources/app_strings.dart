// ignore_for_file: non_constant_identifier_names

import 'package:premises/main_imports.dart';
import 'resources.dart';

class AppStrings {
  static final AppStrings _resource = AppStrings._internal();

  factory AppStrings() => _resource;

  AppStrings._internal();

  //App Customizations
  String get app_title => AppCustomizationStrings().app_title;

  String get splash_title => AppCustomizationStrings().splash_title;

  String get offline_db_name => AppCustomizationStrings().offline_db_name;

  //App Strings
  String get created_with_care_by_safety_app => 'SafetyApp';

  String get blank => "";

  String get dash => "-";

  String get maskedValue => "****";

  String get offlineInstructionForINOUT =>
      "It seems you're currently offline. Please switch to Offline Mode to continue.";

  String get switch_project => "Switch Project";

  String get asterisk => " * ";

  String get login_to_continue => "Please log in to continue";

  String get reset_password => "Reset Password";

  String get welcome => "Welcome!";

  String get select_project => "Select Project";

  String get user_id => "User Name";

  String get enter_user_name => "Enter User Name";

  String get password => "Password";

  String get forget_password => "Forgot Password ?";

  String get login => "Login";

  String get back_to_login => "Back to Login  ?";

  String get version => "Version ";

  //String get reassign => "Reassign";

  String get created_with_care_by => "Created with care by";

  String get calendar => "Calendar";

  String get hint_enter_user_id => "Enter User ID";

  String get hint_enter_password => "Enter Password";

  String get error_valid_user_id => "Please enter your User Name";

  String get error_valid_user_name => "Enter Valid User Name";

  String get error_valid_name => "Enter Valid Name";

  String get error_valid_designation => "Enter Valid Designation";

  String get error_valid_company_name => "Enter Valid Company Name";

  String get error_valid_comment => "Please enter comment";

  String get error_valid_cancellation_reason =>
      "Please enter valid cancellation reason";

  String get error_valid_reason_of_deletion =>
      "Please enter reason of deletion";

  String get error_valid_discussion_points => "Please enter discussion points";

  String get error_time_duration => "Please select Time Duration";

  String get error_valid_reason => "Please enter reason";

  String get error_valid_first_name => "Please enter your First Name";

  String get error_valid_last_name => "Please enter your Last Name";

  String get error_valid_password => "Please enter your password";

  String get error_event_date => "Please select event date";

  String get error_valid_validity => "Please enter valid id proof validity";

  String get error_valid_id_proof_number =>
      "Please enter valid id proof number";

  String get error_valid_other_relation => "Please enter valid other relation";

  String get error_valid_emergency_name =>
      "Please enter emergency contact name";

  String get error_valid_emergency_relation =>
      "Please enter emergency contact relation";

  String get error_valid_emergency_number =>
      "Please enter emergency contact number";

  String get support => "Support";

  String get training_videos => "Training Videos";

  String get device_test => "Device Test";

  String get user_guide => "User Guide";

  String get project_sync_instruction =>
      "Only the data of the currently selected project can be synced. To sync data from another project, please change the project from the Dashboard";

  String get created_with_care => "Created with care by";

  String get error_invalid_platform => "Invalid Platform";

  String get deactivate_user => "Your account has been deactivated";

  String get deactivate => "Deactivate";

  String get remark_of_deactivation => "Remark of Deactivation";

  String get reason_of_deactivation => "Select Reason of Deactivation";

  String get deactivate_labour => "Deactivate Worker";

  String get error_login_failed => "Invalid username or password.";

  String get error_forget_password_failed => "User Name does not exist";

  String get error_some_thing_went_wrong => 'Something went wrong';

  String get email_temporary_password => 'Email temporary Password';

  String get enter_correct_password => 'Please Enter correct current password.';

  // Dashboard
  String get pending_task => 'PENDING ACTIONS'; //TASKS

  String get modules => 'MODULES';

  String get quick_actions => 'QUICK ACTIONS';

  //Dashboard Menu
  String get work_permit => 'Work Permit (WP)';

  String get toolbox_training => 'Trainings & Events';

  String get checklist => 'Checklist';

  String get projectScoring => 'Project Scoring';

  String get workInspection => 'Work Inspection';

  String get materialInspection => 'Material Inspection';

  String get qualityInspection => 'Quality Inspection';

  String get homeInspection => 'Home Inspection';

  String get safety_actionable => 'Safety Observation';

  String get incident_report => 'Incident Report';

  String get induction_training => 'Induction Training';

  String get induction_date => 'Induction Date';

  String get qr_scans => 'QR Scans';

  String get violation_notice => 'Violation Notice';

  String get task => 'Task';

  //Quick Actions
  String get create_wp => 'Create\nWP';

  String get induction_training_create => 'Induction\nTraining';

  String get accepted_wp => 'Accepted\nWP';

  String get add_labor => 'Add\nWorker';

  String get capture => 'Capture';

  String get create_safety_actionable => 'Create Safety Observation';

  String get create_incident_report => 'Create Incident\nReport';

  String get sync_offline => 'Sync\nOffline';

  String get create_tbt => 'Create\nTBT';

  String get scan_id_qr => 'Scan ID\nQR';

  String get visitor_scan => 'Visitor\nScan';

  String get face_scan => 'Face Scan';

  String get dashboard_id => 'Dashboard';

  String get scan_qr => 'QR Scan';

  String get captured_attendance => 'Captured Attendance';

  String get todays_work_force => 'Today\'s  Workforce';

  String get openCamera => "Camera";

  String get checkboxAndRadio => "Checkbox And Radio Button";

  String get no_internet_connection =>
      'No internet connection. Please check your network and try again. '
      'If you\'re experiencing slow internet speed, try refreshing the page or switching to a more stable network.';

  String get emergency_contact => 'Emergency Contacts';

  String get work_permit_screen => 'Work Permit';

  String get data_not_found => 'Data Not Found';

  String get no_records_found => 'No Records Found';

  String get toolbox_training_screen => 'Toolbox Training';

  String get trainings_and_events_screen => 'Training & Events';

  String get schedule_events => 'Schedule Event';

  String get edit_event => 'Edit Event';

  //Sync Offline
  String get sync_offline_screen => 'Sync Offline';

  String get no_offline_safety_observation_offline_sync =>
      'No offline safety observation found';

  String get violation_notice_screen => 'Violation Notice';

  String get safety_observation_screen => 'Safety Observation';

  String get safety_observation_id => 'Safety Observation ID';

  String get involved_party => 'Involved Party';

  String get contractor => 'Contractor';

  String get details => 'Details';

  String get stepIncidentDetails => 'Incident\nDetails';

  String get stepRCADetails => 'RCA Details';

  String get stepCAPA => 'Preventive\nAction';

  String get created_on => 'Created on';

  String get reported_on => 'Reported on';

  String get turn_around_time => 'Turn Around Time';

  String get location_of_breach => 'Location of Breach';

  String get risk_level => 'Risk Level';

  String get type => 'Type';

  String get escalation_level => 'Escalation Level';

  String get source_of_observation => 'Source of Observation';

  String get assignor => 'Assignor';

  String get by_Me => 'By Me';

  String get for_Me => 'For Me';

  String get main_area_of_observation => 'Main Area of Observation';

  String get sub_area_of_observation => 'Sub Area of Observation';

  String get assignee => 'Assignee';

  String get for_me => 'For Me';

  String get informed_people => 'Informed People';

  String get involved_people => 'Involved Persons';

  String get safety_actiobale_status => 'Safety Observation Status';

  String get internal => 'Internal';

  String get external => 'External';

  String get edit => 'EDIT';

  String get externaltxt => 'External';

  String get selectcontractor => 'SELECT CONTRACTOR';

  String get enter_details => 'Enter Details';

  String get select_main_area => 'Select Main Area of Observation';

  String get select_sub_area => 'Select Sub Area of Observation';

  String get select_source_observation => 'Select Source of Observation';

  String get select_turnaround_time => 'Select Turn Around Time';

  String get select_alertDT => 'Select Alert expiry date';

  String get select_risk_level => 'Select Risk Level';

  String get select_type => 'Select Type';

  String get select_assignee => 'Select Assignee';

  String get select_informed_people => 'Select Informed People';

  String get select_involved_people => 'Select Involved Persons';

  String get select_assignor => 'Select Assignor';

  String get add_assignee => 'ADD ASSIGNEE';

  String get add_informed_people => 'Add Informed People';

  String get add_involved_people => 'Add Involved Persons';

  String get back => 'Back';

  String get comment => 'Comment';

  String get decision => 'Decision';

  String get audit_accept => 'Accept Audit';

  String get audit_reject => 'Reject Audit';

  String get add_yout_comment => 'Add your comment here';

  String get add_your_remark => 'Add your remark here';

  String get preview => 'Preview';

  String get max_five_photos => 'Maximum 5 Photos';

  String get max_one_attachment_allowed => ' (Maximum 1 Attachments Allowed)';

  String get max_five_attachment_allowed => ' (Maximum 5 Attachments Allowed)';

  String get error_valid_details => 'Enter valid Details';

  String get error_valid_amount => 'Enter valid non zero amount';

  String get error_valid_turnaroundtime => 'Enter valid Turn Around Time';

  String get error_valid_alertExpiryDT => 'Enter valid Alert expiry date';

  String get error_valid_location_of_breach => 'Enter valid Location of Breach';

  String get error_valid_task_title => 'Enter valid Task Title';

  String get reassign => 'REASSIGN';

  String get reassignCheckList => 'Re-assign Checklist';

  String get reassignForm => 'Re-assign Form';

  String get reassign_question_mark => 'REASSIGN ?';

  String get create_safety_observation => 'Create Safety Observation';

  String get want_to_create_sa =>
      'Are you sure you want to create this Safety Observation?';

  String get create => 'Create';

  String get done => 'Done';

  String get safety_actionable_success =>
      'Safety Observation Created Successfully !';

  String get safety_actionable_reassign_success =>
      'Assignee Reassigned Successfully !';

  String get safety_actionable_close_success =>
      'Safety Observation Closed Successfully !';

  String get safety_actionable_reopen_success =>
      'Safety Observation Reopened Successfully !';

  String get safety_actionable_resolve_success =>
      'Safety Observation Resolved Successfully !';

  String get submit_safety_actionable =>
      'Are you sure you want to create this Safety Observation ?';

  String get close_safety_actionable =>
      'Are you sure you want to close this Safety Observation ?';

  String get reopen_safety_actionable =>
      'Are you sure you want to reopen this Safety Observation ?';

  String get resolve_safety_actionable =>
      'Are you sure you want to resolve this Safety Observation ?';

  String get create_SA_title => 'Create Safety Observation';

  String get close_SA_title => 'Close Safety Observation';

  String get reopen_SA_title => 'Reopen Safety Observation';

  String get resolve_SA_title => 'Resolve Safety Observation';

  String get please_add_signature => 'Please add Signature';

  String get please_add_comment => 'Please add Comment';

  String get please_add_remark => 'Please add remark';

  String get please_add_photos => 'Please add Photos';

  String get txtDashOpen => "Open";

  String get txtDashSubmitted => "Submitted";

  String get select_maker => "Select Maker";

  String get selct_assignee => "Select Assignee";

  String get assigned_to => "Assigned to";

  String get txtDashResolved => "Resolved";

  String get txtDashReported => "Reported";

  String get txtDashCompleted => "Completed";

  String get txtDashAccept => "Accepted";

  String get txtDashReject => "Rejected";

  String get txtDashSuspend => "Suspended";

  String get txtDashAuditAccept => "Audit Accepted";

  String get txtDashAuditReject => "Audit Rejected";

  String get txtDashClose => "Closed";

  String get txtCancelled => "Cancelled";

  String get txtDashResubmit => "Resubmitted";

  String get txtDashInReview => "In Review";

  String get txtRejectedComment => "Rejected Comment";

  String get txtAuditRejectedComment => "Audit Rejected Comment";

  String get txtExtendedDuration => "Extended Duration";

  String get extendTime => "Extend Time";

  String get txtDashEscalated => "Escalated";

  String get txtDashReopen => "REOPEN";

  String get txtDashInprogress => "In Progress";

  String get txtDashReassigned => "Reassigned";

  //Common
  String get search => 'Search';

  String get work_permit_added_succ =>
      'Time Extension Request Sent Successfully !';

  String get try_again => 'Try Again ?';

  String get message_forget_password =>
      'A temporary password has been sent to your Contact email id. Kindly use it to log in.';

  String get txtComment => "Comment";

  String get cancellationReason => "Cancellation Reason";

  String get discussionPoints => "Discussion Points";

  String get txtAddYourComment => "Add your comment here";

  String get textAddYourRemark => "Add your remark here";

  // Notifications
  String get Notifications => 'Notifications';

  String get toolbox_training_maker => 'Maker';

  String get tbt_training => 'TBT Training';

  String get trainings_events => 'Training & Events';

  String get all_tab => 'All';

  String get tab_checker => 'Checker';

  String get tab_auditor => 'Auditor';

  String get toolbox_training_reviewer => 'Reviewer';

  // Induction Training
  String get INDUCTEES => 'Inductees';

  String get inducted_by => 'Inducted By';

  String get BULK_INDUCTION => 'Bulk Induction';

  String get labour => 'Worker';

  String get addLabour => 'Add Worker';

  String get maritalStatus => 'Marital Status';

  String get addContractor => "Add Contractor";

  String get addStaff => "Add Staff";

  String get addConsultant => "Add Consultant";

  String get addClient => "Add Client";

  String get addGovtOfficial => "Add Govt. Official";

  String get precaution => 'Precaution';

  String get details_and_sign => 'Details and Sign';

  String get submit => 'Submit';

  String get delete => 'Delete';

  String get confirm => 'CONFIRM';

  String get work => 'work';

  String get machinery => 'machinery';

  String get training => 'training';

  String get document => 'Document';

  String get license_or_certificate_name => 'License / Certificate Name';

  String get upload_license => 'Upload License';

  String get attach_certificate => 'Attach Certificate';

  String get certificate_name => 'Certificate Name';

  String get validity_date => 'Validity Date';

  String get fitness_certificates_details => 'Fitness Certificates Details';

  String get policy_details => 'Policy Details';

  String get policy_type => 'Policy Type';

  String get policy_number => 'Policy Number';

  String get certificate_photos => 'Certificate Photos';

  String get certificate_validity => 'Certificate Validity';

  String get policy_document => 'Policy Document';

  String get document_photos => 'Document Photos';

  String get work_order_photos => 'Work Order Photos';

  // String get staff => 'Staff';

  String get staff_type => 'Staff Type';

  String get consultant => 'Consultant';

  String get client => 'Client';

  String get govt => 'Govt. Official';

  String get personaldetails => 'Personal Details';

  String get sign => 'Sign';

  String get inducteeId => 'Inductee ID';

  String get induction_training_code => 'Induction Training Code ';

  String get inducteeInfo => 'Inductee Info';

  String get ValidIdCard => "The ID Card is VALID";

  String get inValidIdCard => "The ID Card is INVALID";

  String get contactAdmin => "Please contact Admin";

  String get professionaldetails => 'Professional Details';

  String get contractorFirm => 'Contractor Firm';

  String get builder => 'Organisation';

  String get contractorFirmInvolved => 'Contractors Firms Involved';

  String get contractorFirms => 'Contractor Firms';

  String get emergencycontact => 'Emergency Contact';

  String get emergencycontactname => 'Emergency Contact Name';

  String get enterIdProofNumber => 'Enter ID Proof Number';

  String get idProof => 'ID Proof';

  String get name => 'Name';

  String get relation => 'Relation';

  String get governmentId => 'Government ID';

  String get governmentIds => 'Government IDs';

  String get documentName => 'Document Name';

  String get documentPhoto => 'Document Photo';

  String get enterOtherRelative => 'Enter Other Relative';

  String get idNumber => 'ID Number';

  String get otherRelative => 'Other Relative';

  String get validity => 'Validity';

  String get inductionDocument => 'Induction Document';

  String get workOrderPhoto => 'Work Order Photo';

  String get adharcardNumber => 'Aadhaar Card Number'; // CSA-1780

  String get emergency_contact_number => 'Emergency Contact Number';

  String get male => 'Male';

  String get gender => 'Gender';

  String get female => 'Female';

  String get other => 'Other';

  String get literacy => 'Literacy';

  String get literate => 'Literate';

  String get married => 'Married';

  String get unmarried => 'Unmarried';

  String get sameAsPermanentAddress => 'Same as Permanent Address';

  String get labourCampAddress => 'Worker Camp Address';

  String get enterAddressManually => 'Enter Address Manually';

  String get labourCampLocation => 'Worker Camp Location';

  String get enterLabourCampLocation => 'Enter Worker Camp Location';

  String get quarterDetails => 'Worker Camp Details';

  String get dependents => 'Dependents';

  String get dependentDetails => 'Dependent Details';

  String get manageDependents => 'Manage Dependents';

  String get skill => 'Skilled';

  String get unskill => 'Unskilled';

  String get work_fitness_status => 'Work Fitness Status';

  String get fit => 'Fit';

  String get unfit => 'Unfit';

  String get skillLevel => 'Skill Category';

  String get illiterate => 'Illiterate';

  String get bloodgroup => 'Blood Group';

  String get safetyEquipmentProvided => 'Safety Equipment Provided';

  String get fitnessCertificate => 'Fitness certificate';

  String get workAuthorization => 'Work Authorization (High Risk)';

  String get machineryAuthorization => 'Machinery Authorization';

  String get trainingCompleted => 'Training Completed';

  String get selectbloodgroup => 'Select Blood Group';

  String get reasonforvisit => 'Reason For Visit';

  //String get geoLocation => 'Geolocation';

  String get tbt => 'TBT';

  String get trade => 'Trade';

  String get address => 'Address';

  String get permanentAddressDetails => 'Permanent Address Details';

  String get permanentAddress => 'Permanent Address';

  String get currentAddress => 'Current Address';

  String get currentAddressDetails => 'Current Address Details';

  String get currentAddressType =>
      'Please select the appropriate option for the current address';

  String get experienceInYears => 'Experience in Year';

  String get firmContractorNumber => 'Firm Contractor Number';

  String get gstinNumber => 'GSTIN Number';

  String get contractorfirmname => 'Contractor Firm Name';

  String get contractorGroupname => 'Contractor Group Name';

  String get undertaking => "Undertaking";

  String get signBehalf => "Sign by maker on behalf of inductee";

  String get signBehalfContractor =>
      "Contractor's Signature on Behalf of inductee";

  String get undertaking1Induction =>
      'I understood and will follow all the instructions given to me. (मैं एतद्द्वारा घोषणा करता हूं कि मुझे दिए गए सभी निर्देशों को मैंने समझ लिया है और मैं उनका पालन करूंगा।)';

  String get undertaking2Induction =>
      'I accept all the company regulations explained to me and I will comply to those. (मुझे बताए गए कंपनी के सभी नियमों को मैं स्वीकार करता हूं और मैं उनका पालन करूंगा।)';

  String get undertaking3Induction =>
      "I hereby declare that the information / documents provided in above form is true & correct to the best of my knowledge and belief and nothing has been falsely stated. In case any of the above information is found to be false or untrue or misleading or misrepresenting, I am aware that may be held liable for it. (मैं एतद्द्वारा घोषणा करता हूं कि उपरोक्त प्रपत्र में प्रदान की गई जानकारी/दस्तावेज मेरी सर्वोत्तम जानकारी और विश्वास के अनुसार सत्य और सही है और कुछ भी गलत नहीं बताया गया है। यदि उपरोक्त में से कोई भी जानकारी झूठी या असत्य या भ्रामक या गलत प्रस्तुत करने वाली पाई जाती है, तो मुझे पता है कि इसके लिए मुझे उत्तरदायी ठहराया जा सकता है।)";

  String get undertaking4Induction =>
      "I hereby authorize that the documents of my Aadhaar card and other government ID cards submitted here are true."
      "\nI solely will be fully responsible for any discrepancy found. I give my consent to share these documents for official use, understanding that my personal data will be stored securely and used solely for the stated purpose. I acknowledge that I have read and understood the terms of this consent."
      "\nमैं यह सत्यापित करता/करती हूँ कि यहां प्रस्तुत किए गए मेरे आधार कार्ड और अन्य सरकारी पहचान पत्र सही हैं। किसी भी त्रुटि पाए जाने पर मैं पूरी तरह से जिम्मेदार होऊंगा/हूंगी। मैं आधिकारिक उपयोग के लिए इन दस्तावेजों को साझा करने की सहमति देता/देती हूँ, यह समझते हुए कि मेरे व्यक्तिगत डेटा को सुरक्षित रूप से संग्रहीत किया जाएगा और केवल निर्दिष्ट उद्देश्य के लिए उपयोग किया जाएगा। मैं स्वीकार करता/करती हूँ कि मैंने इस सहमति की शर्तों को पढ़ा और समझा है।";

  //Filter
  String get filter => 'Filter';

  String get selectDate => 'Select Date';

  String get fromDate => 'From Date';

  String get toDate => 'To Date';

  String get selectCategory => 'Select Category';

  String get category => 'Category';

  String get resetFilter => 'RESET FILTER';

  String get applyFilter => 'APPLY FILTER';

  String get addToList => 'ADD TO LIST';

  String get add => 'Add';

  String get dateOfBirth => 'Date Of Birth';

  String get error_select_reason_visit => 'Please select reason for visit';

  String get error_select_quarter_details =>
      'Please select worker camp details';

  String get error_select_staff_designation =>
      'Please select staff designation';

  String get error_valid_contact_number =>
      'Enter valid 10 digit contact number';

  String get error_valid_address => 'Enter valid address';

  String get error_valid_current_address => 'Enter valid current address';

  String get error_valid_labour_camp_address =>
      'Enter valid worker camp address';

  String get error_valid_permanent_address => 'Enter valid permanent address';

  String get error_valid_year_count => 'Enter valid year count';

  String get error_select_trade => 'Please select trade';

  String get error_select_relation => 'Please select relation';

  String get error_select_government_id => 'Please select government ID';

  String get error_select_document => 'Please select id proof document type';

  String get error_select_contractor_firm_name =>
      'Please select contractor firm name';

  String get select_contractor_firm_name => 'Select contractor firm name';

  String get select_contractor_Group => 'Select contractor Group Name';

  String get error_valid_aadhar_number =>
      'Enter valid Aadhaar number'; // CSA-1780

  //Incident Forms
  String get photos => 'Photos';

  String get photosAndVideos => 'Photos/Videos';

  String get verificationPhotosAndVideos => 'Verification Photos/Video';

  String get verificationRemark => 'Verification Remark';

  String get evidencePhotosAndVideos => 'Evidence Photos/Video';

  String get remarkOrActionTaken => 'Remark/Action Taken';

  String get close_photos => 'Closed Photos';

  String get enterDetails => 'Enter Details';

  String get enterRemark => 'Enter Remark';

  String get briefDescriptionIncidentReport =>
      'Brief Description of Incident Report';

  String get enterExplanation => 'Enter Explanation here';

  String get locationOfIncident => 'Location of Incident';

  String get severity => 'Severity';

  String get selectSeverity => 'Select Severity';

  String get selectInjuredPeople => 'Select Injured People';

  String get next => 'Next';

  String get maximum5Photos => 'Maximum 5 Photos';

  String get maximumFilesPhotosAndVideos => 'Maximum 5 Files (Photos/1 Video)';

  String get addWitness => 'Add Witness';

  String get addOtherWitness => 'Add Other Witness';

  String get addExternalMember => 'Add Members';

  String get externalMember => 'External Members';

  String get dateAndLocationOfSubmission => 'Date and Location of Submission';

  String get permissionStatus => 'Permission Status';

  String get error_location => 'Error While Getting Address';

  String get signed_by_maker => 'Sign by maker on behalf of trainee';

  String get signed_by_attendees => 'Sign by maker on behalf of Attendees';

  String get signed_by_contractor =>
      'Contractor\'s Signature on Behalf of trainee';

  String get correctiveAction => 'Corrective Action Taken';

  String get preventiveAction => 'Preventive Action';

  String get detailsofCorrectiveAction => 'Details of Corrective Action';

  String get completionDateandTime => 'Completion Date and Time';

  String get selectCompletionDateandTime => 'Select Completion Date and Time';

  String get selectResponsiblePerson => 'Select Responsible Person';

  String get responsiblePerson => 'Responsible Person';

  String get detailsofPreventiveAction => 'Details of Preventive Action';

  String get saveRCA => 'SUBMIT RCA';

  String get SAVE_CAPA => 'Save CAPA';

  String get saveCAPA => 'SAVE CAPA';

  String get saveCA => 'SAVE CA';

  String get savePA => 'SAVE PA';

  String get RCA => 'RCA';

  String get CA => 'CA   ';

  String get PA => 'PA   ';

  String get investigationTeam => 'Investigation Team';

  String get addPerson => 'ADD PERSON';

  String get saveCorrectiveAction => 'SAVE CORRECTIVE ACTION';

  String get savePreventiveAction => 'SAVE PREVENTIVE ACTION';

  String get rca_already_saved => 'RCA is already saved';

  String get ca_already_saved => 'Corrective Action is already saved';

  String get pa_already_saved => 'Preventive Action is already saved';

  String get fullName => 'Full Name';

  String get firstName => 'First Name';

  String get middleName => 'Middle Name';

  String get lastName => 'Last Name';

  String get contactNumber => 'Contact Number';

  String get confirmEmailId => 'Confirm Email ID';

  String get crecheSchooling => 'Creche/Schooling';

  String get allowCrecheAccess =>
      'Allow this dependent to access creche/schooling facility';

  String get update => 'Update';

  String get witness => 'Witness';

  String get otherWitness => 'Other Witness';

  String get makerDetails => 'Maker Details';

  String get reporterDetails => 'Reporter Details';

  String get other_representative => 'Other Representative';

  String get signature => 'Signature';

  String get signatureAndFingerprint => 'Signature / Finger Print';

  String get signatory => 'Signatory';

  String get finger_print => 'Finger Print';

  String get continue_btn => 'CONTINUE';

  String get warning => 'WARNING';

  String get warning_alert_msg =>
      'To capture finger print, you will be taken to another application. Are you sure you want to continue ?';

  String get report_incident => 'REPORT INCIDENT';

  String get update_incident => 'UPDATE INCIDENT';

  String get incidentID => 'Incident ID';

  String get injuredPeople => 'Injured People';

  String get addInjuredPeople => 'Add Injured People';

  String get incidentPhotos => 'Incident Photos';

  String get error_valid_corrective_actions =>
      'Please enter corrective action details';

  String get error_valid_preventive_actions =>
      'Please enter preventive action details';

  String get error_valid_remark => 'Please enter valid remark';

  String get error_firm_contractor_number => 'Enter Firm Contractor Number';

  String get error_enter_gstin_number => 'Enter GSTIN Number';

  String get error_valid_signature => 'Please save signature';

  String get error_valid_add_one_or_more_photo =>
      'Please add one or more photo';

  String get error_select_safety_officer => 'Please select Safety Incharge';

  String get error_select_type_accident => 'Please select Type of Incident';

  String get error_valid_details_of_incident =>
      'Please enter a brief description of the Incident';

  String get error_valid_explanation => 'Enter valid explanation';

  String get error_valid_problemStatement => 'Enter valid Problem Statement';

  String get error_valid_location_of_incident =>
      'Please enter the location of the Incident';

  String get error_valid_injured_people => 'Please add injured people';

  // String get error_valid_signature_witness_people =>
  //     'Please draw or save signature for ';

  String get error_valid_comment_witness_people => 'Please add comment for ';

  String get error_valid_witness_people => 'Please add witness';

  String get error_valid_severity_level => 'Please select Severity Level';

  String get general_details => 'General Details';

  String get incident_saved_succ => 'Incident reported successfully!';

  String get incident_update_succ => 'Incident updated successfully!';

  String get incident_failed_save => 'Not able to save Incident';

  String get common_error =>
      'There was a problem while submitting your report. Please try again.';

  String get ca_saved_succ => 'Corrective Action Submitted successfully!';

  String get pa_saved_succ => 'Preventive Action Submitted successfully!';

  String get ca_failed_save => 'Corrective Action failed to save';

  String get pa_failed_save => 'Preventive Action failed to save';

  String get incident_alert_msg =>
      'Are you sure you want to report this incident ?';

  String get incident_alert_msg_update =>
      'Are you sure you want to update this incident ?';

  String get rca_alert_msg =>
      'Are you sure you want to submit RCA for this incident ?';

  String get ca_action =>
      'Are you sure you want to resolve this Corrective Action ? Please ensure all details are accurate.';

  String get pa_action =>
      'Are you sure you want to resolve this Preventive Action ?Please ensure all details are accurate.';

  String get ca_alert_msg =>
      'Are you sure you want to save corrective action for this incident ?';

  String get pa_alert_msg =>
      'Are you sure you want to save preventive action for this incident ?';

  String get rca_saved_succ => 'RCA submitted successfully!';

  String get rpa_empty_data => 'Please select Root Cause Analysis';

  String get rpa_failed_save => 'RCA failed to save';

  String get close_incident_error =>
      'There was a problem while closing incident report';

  String get makerOfRCA => 'Maker of RCA';

  String get makerOfCA => 'Maker of CA';

  String get makerOfPA => 'Maker of PA';

  String get rootCauseAnalysisTitle => 'Root Cause Analysis (RCA)';

  String get correctiveActionTitle => 'Corrective Action (CA)';

  String get correctiveActionAndPreventiveActionTitle =>
      'Preventive Action (PA)';

  String get preventiveActionTitle => 'Preventive Action (PA)';

  String get detailsOfCorrectiveAction => 'Details of Corrective Action';

  String get detailsOfPreventiveAction => 'Details of Preventive Action';

  String get responsiblePersonValidation => 'Please Add Responsible Person';

  //TBT
  String get tbt_id => 'Toolbox Training ID';

  String get tbt_name => 'Name of Toolbox Training';

  String get tbt_activity => 'Activity';

  String get tbt_work_permit => 'Work Permit';

  String get tbt_not_applicable => 'Not Applicable';

  //String get tbt_details_of_training => 'Details of Training';

  String get tbt_sync_type => 'Sync Type';

  String get tbt_sync_at => 'Sync At';

  String get created_at_offline => 'Created At Offline';

  String get tbt_created_on => 'Created on';

  String get tbt_maker => 'Maker';

  String get incident_reported_by => 'Incident Reported By';

  String get reviewer_status => 'Reviewer Status';

  String get my_check_list => 'My Checklist';

  String get my_forms => 'My Forms';

  String get to_review => 'To Review';

  String get for_review => 'For Review';

  String get tbt_reviewer => 'Reviewer';

  String get tbt_document => 'Training Document';

  String get induction_document => 'Induction Document';

  String get tbt_trainees => 'Trainees';

  String get tbt_group_photos => 'Group Photos';

  String get tbt_instructions_given => 'Instructions Given';

  String get logout => "LOGOUT";

  String get search_activity => 'Search Activity';

  String get activity => 'Activity';

  String get select_activity => 'Select Activity';

  String get status => 'Status';

  String get active => 'Active';

  String get inactive => 'Inactive';

  String get inductee_type => 'Inductee Type';

  String get select_inductee_type => 'Select Inductee Type';

  String get inductee_trade => 'Trade';

  String get select_trade => 'Select Trade';

  String get select_status => 'Select Status';

  String get search_contractor_firm_name => 'Search Contractor Firm Name';

  String get attach_work_permit => 'Attach Work Permit';

  String get name_of_tbt => 'Name of Toolbox Training';

  String get details_of_training => 'Details of Training';

  String get select_reviewer => 'Select Reviewer';

  String get select_trainees => 'Select Trainees';

  String get select_site_engineer => 'Select Site Engineer';

  String get site_engineer_name => 'Site Engineer Name';

  String get site_engineer => 'Site Engineers';

  String get add_people => 'Add People';

  String get add_reviewer => 'Add Reviewer';

  String get add_reviewers => 'Add Reviewer(s)';

  String get select_all => 'Select All';

  String get instruction_given => 'Instruction Given';

  String get add_trainee => 'ADD TRAINEES';

  String get add_site_sngineer => 'ADD SITE ENGINEER';

  String get add_attendees => 'ADD ATTENDEES';

  String get take_group_photo => 'Take Group Photo';

  String get attach_event_photo => 'Attach Event Photo';

  String get maximum_10_photos => 'Maximum 10 photos';

  String get maximum_2_photos => 'Maximum 2 photos';

  String get tbt_attestation => 'Attestation';

  String get debitnote_approver => 'Approver';

  String get approve => 'Approve';

  String get debite_note => 'Debit Note';

  String get call => 'CALL';

  String get proceed => 'PROCEED';

  String get already_marked_in => 'Already Marked In';

  String get already_marked_out => 'Already Marked Out';

  String get marked_in_instruction => 'This person is already marked In today.';

  String get marked_in_out_confrimation => 'Do you still want to proceed?';

  String get marked_out_instruction =>
      'This person is already marked Out today.';

  String get call_alert_msg => 'Are you sure you want call this number ?';

  String get unfit_labour => 'Worker Rejected';

  // error messages
  String get error_select_activity => 'Please Select Activity';

  String get error_select_work_permit => 'Please Select Work Permit to Attach';

  String get error_add_labours_signature =>
      'Please Add All Worker\'s Signature';

  String get error_add_trainees => 'Please Add Trainees';

  String get error_select_reviewer => 'Please Select Reviewer';

  String get error_select_Instructions => 'Please Select Instructions';

  String get error_Instructions_not_configured =>
      'Instructions are not configured by admin.';

  String get error_capture_grouo_photo => 'Please Take Group Photo';

  String get error_trainee_signature_mandatory =>
      'Please Take Signature From All Selected Trainee';

  String get error_draw_signature => 'Please Draw/Save Your Signature';

  String get error_draw_signature_for => 'Please Draw/Save Signature For';

  String get error_add_photos => 'Please Attach Event Photos';

  String get error_add_attendees => 'Please Add Attendees to Complete Event';

  String get error_enter_comment => 'Please Enter Your Comment';

  String get error_witness_photo => 'Please Take Witness Photo';

  String get error_other_representative_photo =>
      'Please Take Other Representative Photo';

  String get error_select_risk_level => 'Please Select Risk Level';

  String get error_select_type => 'Please Select Type';

  String get error_select_Source => 'Please select Source of Observation';

  String get error_select_main_area => 'Please Select Main Area of Observation';

  String get error_select_sub_area => 'Please Select Sub Area of Observation';

  String get error_select_category => 'Please Select Category';

  String get error_select_assignee => 'Please Select Assignee';

  String get error_select_recipient => 'Please Select Recipient';

  String get error_select_gaps => 'Please Select Gaps';

  String get error_select_count => 'Please Select Count';

  String get error_enter_message => 'Please Enter Message or Add Attachments';

  //change password place holders
  String get change_password => "Change Password";

  String get sync_project => "Sync Project";

  String get enter_current_pwd => "Enter Current Password";

  String get enter_valid_current_pwd => "Enter Valid Current Password";

  String get enter_new_pwd => "Enter New Password";

  String get enter_valid_new_password => "Enter Valid New Password";

  String get enter_valid_password =>
      "Passwords must be at least 8 characters in length.\n(at least 1 capital letter, 1 numeric value,1 Special character)";

  String get confirm_new_pwd => "Confirm New Password";

  String get confirm_valid_new_pwd => "Enter Valid Confirm password";

  String get confirmpass_newpass_same =>
      "Confirm password and new password should be same.";

  String get confirmpass_currentpass_not_same =>
      "Confirm password and current password should not be same.";

  String get newpass_currentpass_not_same =>
      "New password and current password should not be same.";

  String get same_password_error =>
      "New password and confirm new password should be same.";

  String get password_same_as_user_name =>
      "Passwords should not be same as username";

  String get changePasswordbtn => "CHANGE PASSWORD";

  String get syncOffline => "Sync Project Data";

  String get syncNow => "Sync Now";

  //contact email id
  String get contact_email_id => "Contact Email ID";

  String get email_id => "Email ID";

  String get designation => "Designation";

  String get enter_otp => "Enter OTP";

  String get otp_sent_to => "OTP sent to";

  String get contractor_email_id => "Contractor Email ID";

  String get valid_contact_email_id => "Enter Valid Contact Email ID";

  String get valid_email_id => "Enter Valid Email ID";

  String get valid_otp_code => "Enter Valid 6 Digit OTP Code";

  String get saveBtn => "SAVE";

  String get send_otp => "Send Otp";

  //Online and Offline Sync
  String get online => 'Online';

  String get offline => 'Offline';

  String get message_changePassword => 'Password changed successfully !';

  String get lb_current_project => 'Current Project';

  String get lb_assigned_project => 'Assigned Projects';

  String get lb_username => 'User Name';

  String get lb_userrole => 'User Role';

  String get lb_contact_number => 'Contact Number';

  String get email_id_update => 'Personal Email ID Saved Successfully!';

  String get profile_picture_update => 'Profile Picture Saved Successfully!';

  String get error_updating_user_profile =>
      'There was an error while updating user profile.';

  String get error_while_processing_request =>
      'An error occurred while processing your request. Please try again later. '
      'If you have a slow internet connection, ensure your network is stable and try again.';

  String get bad_gateway =>
      'An error occurred while processing your request. 502 Bad Gateway '
      'If you have a slow internet connection, ensure your network is stable and try again.';

  String get profile => 'Profile';

  String get viewProfile => 'View Profile';

  String get labourDigitalProfile => 'Worker Digital Profile';

  String get lastUpdatedOn => 'Last Updated On';

  String get eligibilityStatus => 'Eligibility Status';

  String get eligible => 'Eligible';

  String get notAllowed => 'Not Allowed';

  String get compliance => 'Compliance';

  String get trainingsAndToolbox => 'Training & Toolbox';

  String get safetyPerformance => 'Safety Performance';

  String get attendance => 'Attendance';

  String get medicalAndInsurance => 'Medical & Insurance';

  String get medicalStatus => 'Medical Status';

  String get documentsAndUndertakings => 'Documents & Undertakings';

  String get workAuthorizationStatus => 'Work Authorization Status';

  String get trainingCount => 'Training Count';

  String get trainingHours => 'Training Hours';

  String get toolboxCount => 'Toolbox Count';

  String get lastToolbox => 'Last Toolbox';

  String get safetyTraining => 'Safety Training';

  String get violations => 'Violations';

  String get incidents => 'Incidents';

  String get ppeIssued => 'PPE Issues';

  String get lastAttendance => 'Last Attendance';

  String get inEntry => 'IN';

  String get outEntry => 'OUT';

  String get workHours => 'Work Hours';

  String get totalDays => 'Total Days';

  String get averageHours => 'Average Hours';

  String get medical => 'Medical';

  String get inductionId => 'Induction ID';

  String get expiry => 'Expiry';

  String get insurance => 'Insurance';

  String get number => 'Number';

  String get validTill => 'Valid Till';

  String get fitnessCertificates => 'Fitness Certificates';

  String get topic => 'Topic';

  String get last => 'Last';

  String get noDocumentAvailable => 'No document available';

  String get noProfileDataFound => 'No labour profile data found';

  String get statusValid => 'Valid';

  String get statusInvalid => 'Invalid';

  String get statusNotAllowed => 'Not Allowed';

  String get statusUnavailable => 'Status Unavailable';

  String get eligibilityMaskedReasonCannotDetermine =>
      'Eligibility cannot be determined.';

  String get eligibilityMaskedReasonRestrictedData =>
      'Some required data is restricted.';

  String get tbt_created_successfully =>
      'Toolbox Training Submitted Successfully !';

  String get so_created_successfully =>
      'Safety Observation Submitted Successfully !';

  String get tbt_closed_successfully =>
      'Toolbox Training Closed Successfully !';

  String get submit_toolbox_training_title => 'Create Toolbox Training';

  String get oflfine_sync_pending_data => 'Sync Offline Data';

  String get oflfine_sync_pending_message =>
      'Please Sync the Offline Data from All Your Projects Before Logout from Application';

  String get confirm_delete => 'Delete this record?';

  String get date_sync_error => 'Incorrect Device Date';

  String get confirm_delete_message =>
      'Are you sure you want to delete this record?';

  String get project_not_sync_title => 'Project Data Not Synced';

  String get already_exists => 'Already Exists';

  String get aadhaar_number_required => 'Aadhaar Number Required';

  String get submit_work_permit_title => 'Create Work Permit';

  String get close_toolbox_training_title => 'Close Toolbox Training';

  String get submit_toolbox_training =>
      'Are you sure you want to submit this toolbox training ?';

  String get project_data_not_sync =>
      'Project data is not yet synced for use in Offline Mode.\n '
      'Please enable your internet connection and sync the project data from the Menu Bar';

  String get submit_work_permit =>
      'Are you sure you want to create this work permit ?';

  String get accept_work_permit =>
      'Are you sure you want to accept this work permit ?';

  String get reject_work_permit =>
      'Are you sure you want to reject this work permit ?';

  String get suspend_work_permit =>
      'Are you sure you want to suspend this work permit ?';

  String get accept_audit_work_permit =>
      'Are you sure you want to accept audit on this work permit ?';

  String get reject_audit_work_permit =>
      'Are you sure you want to reject audit on this work permit ?';

  String get close_work_permit =>
      'Are you sure you want to close this work permit ?';

  String get resubmit_work_permit =>
      'Are you sure you want to resubmit this work permit ?';

  String get close_toolbox_training =>
      'Are you sure you want to close this toolbox training ?';

  String get accept_this_checklist_message =>
      'Are you sure you want to accept this checklist ?';

  String get accept_this_form_message =>
      'Are you sure you want to accept this form ?';

  String get reject_this_checklist_message =>
      'Are you sure you want to reject this checklist ?';

  String get reject_this_form_message =>
      'Are you sure you want to reject this Form ?';

  String get reject_checklist_title => 'REJECT CHECKLIST';

  String get reject_form_title => 'REJECT FORM';

  String get accept_checklist_title => 'ACCEPT CHECKLIST';

  String get accept_form_title => 'ACCEPT FORM';

  String get accept_time_extension =>
      'Are you sure you want to accept time extension for this work permit ?';

  String get accept_time_extension_title => 'Accept Time Extension';

  String get reject_time_extension_title => 'Reject Time Extension';

  String get reject_time_extension =>
      'Are you sure you want to reject time extension for this work permit ?';

  String get error_not_assigned_project =>
      'You have not been assigned any role';

  String get errorEnterFullName => 'Please enter full name';

  String get errorEnterValidName => 'Please enter a valid name';

  String get for_project => 'for project ';

  String get no_projects_found => 'No Projects Found';

  String get deacitivate_project => 'Project has been deactivated';

  String get support_url => 'https://www.constructionsafetyapp.com/support';

  String get safety_app_url => 'https://www.constructionsafetyapp.com/';

  String get close => 'Close';

  String get resolve => 'Resolve';

  String get edit_image => 'Edit Image';

  String get capture_photo => 'Capture Photo';

  String get save_signature => 'Save Signature';

  String get clear_signature => 'Clear Signature';

  String get error_id_proof_photo => 'Please attach ID Proof document photos';

  String get select_document_name => 'Please select document name';

  String get error_work_order => 'Please attach Work Order photos';

  String get error_audit_decision => 'Please Select Audit Decision';

  String get error_select_literacy => 'Please select Literacy';

  String get error_select_date_of_birth => 'Please select date of birth';

  String get error_select_skill_level => 'Please select skill category';

  String get select_skill_level => 'Select Skill Category';

  String get error_select_gender_value => 'Please select Gender';

  String get error_inductee_profile_photo =>
      'Please capture inductee profile photo';

  String get error_fitness_certificate => 'Please attach Fitness Certificate';

  String get error_fitness_status => 'Please Select Work Fitness Status';

  String get error_current_status => 'Please Select Current Address';

  String get error_select_safety_equipments =>
      'Please Select Provided Safety Equipments';

  String get error_select_work_authorization =>
      'Please select at least one work authorization';

  String get error_select_machinery_authorization =>
      'Please select at least one machinery authorization';

  String get error_select_license_name_and_validity =>
      'Please add license name and validity date for the uploaded machinery document';

  String get error_select_training_completed =>
      'Please select at least one training completed item';

  String get error_select_undertaking => 'Please Select All Undertakings';

  String get open_settings => 'Open Settings';

  String get retry => 'Retry';

  String get location_permission_title => 'Allow Location Permission';

  String get location_permission_turn_on => 'Turn On Location Service';

  String get storage_permission_title => 'Storage Permission is denied';

  String get notification_permission_title =>
      'Notification Permission is denied';

  String get location_not_available => 'Location Not Available';

  String get location_permission =>
      'You have denied location access. To proceed, please allow this permission in your app settings.';

  String get storage_permission =>
      'You have denied Storage Permission forever. To Continue please allow storage permission from your app settings';

  String get notification_permission =>
      'You have denied Notification Permission forever. To Continue please allow notification permission from your app settings';

  String get location_service_unavailable =>
      'We need access to your location to continue. Please enable location services in your settings';

  String get location_service_error =>
      'There was a problem while getting your location';

  String get device_not_able_to_fetch_location =>
      'Your Device Is Unable To Fetch Your Location';

  String get unable_to_fetch_location => 'Unable To Fetch Your Location';

  String get error_select_valid_from_to_date =>
      'Please select valid from/to date';

  String get ehs_induction_location_permission =>
      'Location ensures that inductions are logged on-site.';

  String get attendance_location_permission =>
      'Location confirms presence at the site during attendance marking.';

  String get work_permit_location_permission =>
      'Location verifies where the work is initiated and approved for compliance.';

  String get tbt_location_permission =>
      'Location is recorded to ensure training occurs at the designated site.';

  String get safety_observation_location_permission =>
      'Location tags help pinpoint unsafe conditions for quicker resolution.';

  String get incident_location_permission =>
      'Location captures where the incident occurred for accurate reporting.';

  String get checklist_location_permission =>
      'Location confirms on‑site presence during checklist execution.';

  String get violation_notice_location_permission =>
      'Location validates the site of safety violation for enforcement.';

  String get generic_location_permission =>
      'Location access helps maintain accurate site-level safety records and compliance logs.';

  String get error_valid_filter =>
      'Please select valid details to apply filters';

  String get error_valid_fromDate_filter =>
      "Please select the 'From' date first before selecting the 'To' date.";

  //Work Permit
  String get describe_work_here => 'Describe work here';

  String get answer_here => 'Answer Here';

  String get description_of_work => 'Description of Work';

  String get cin => 'CIN';

  String get no_of_workers => 'Number of Workers';

  String get attach_toolbox_training => 'Attach Toolbox Training';

  String get name_of_work_permit => 'Name of Work Permit';

  String get work_permit_id => 'Work Permit ID';

  String get toolbox_training_number => 'Toolbox Training Number';

  String get error_valid_description_of_work =>
      'Enter valid description of work';

  String get error_valid_cin => 'Enter valid CIN';

  String get error_valid_cin_special_char =>
      'CIN cannot have special characters';

  String get select_main_area_of_permission => 'Select Main Area of Permission';

  String get select_sub_area_of_permission => 'Select Sub Area of Permission';

  String get duration_of_work => 'Duration of Work';

  String get in_time_range => 'In Time Range';

  String get out_time_range => 'Out Time Range';

  String get missingTime => 'Missing IN/OUT Time';

  String get select_duration_of_work => 'Select Duration of Work';

  String get date_time_limit =>
      'You can select \'End Date/Time\' within 24 hrs from \'Start Date/Time\'.';

  String get date_same_error =>
      'You have selected same start/end date with similar time';

  String get hazards_identified => 'Hazards Identified';

  String get error_end_date_validation => 'End date must be after startDate';

  String get precautions_in_place => 'Precautions in Place';

  String get pps_title => 'PPEs Issued and to be used by the Workforce';

  String get pps_title_full => 'PPEs Issued and to be used by the \nWorkforce';

  String get tools_and_equipment => 'Tools and Equipment Provided';

  String get category_of_work_permit => 'Category of Work Permit';

  String get description_of_work_permit => 'Description of Work';

  String get geolocation => 'Geolocation';

  String get attached_toolbox_training => 'Attached Toolbox Training';

  String get main_area_of_permission => 'Main Area of Permission';

  String get sub_area_of_permission => 'Sub Area of Permission';

  String get documents_required => 'Documents Required';

  String get assign_checker => 'Assign ${AppData().checkerStr}(s)';

  String get assign => 'Assign';

  String get assign_rca => 'Assign RCA';

  String get assign_user_rca => 'Assign User For RCA';

  String get assign_user_capa => 'Assign User For PA';

  String get assign_investigation_team => 'Investigation Team';

  String get assign_capa => 'Assign CAPA';

  String get select_user => 'Select User';

  String get addCheckers => 'Add ${AppData().checkerStr}';

  String get select_categorys => 'Select Category';

  String get work_permit_status => 'Work Permit Status';

  String get checker_status => '${AppData().checkerStr}s Status';

  String get time_extension => 'Time Extension';

  String get auditor_status => 'Auditor Status';

  String get closed_status => 'Closing Status';

  String get suspension_status => 'Suspension Status';

  String get set_checker_in_sequence =>
      'Set the ${AppData().checkerStr}(s) in sequence?';

  String get error_select_categorys => 'Please Select Category';

  String get error_start_date_end_date => 'Please Select Start Date & End Date';

  String get error_select_hazards => 'Please Select Hazards';

  String get error_select_precaution => 'Please Select Precaution';

  String get error_select_ppe => 'Please Select PPEsIssued';

  String get error_select_tools_and_equipment =>
      'Please Select Tools and Equipment Provided';

  String get error_other_hazards => 'Please Enter Other Hazards';

  String get error_other_precaution => 'Please Enter Other Precaution';

  String get error_other_ppe => 'Please Enter Other PPEsIssued';

  String get error_other_tools => 'Please Enter Other Tools and Equipment';

  String get error_select_checkers =>
      'Please Select ${AppData().checkerStr}(s)';

  String get work_permit_created_successfully =>
      'Work Permit Created Successfully !';

  String get record_deleted_successfully => 'Record Deleted Successfully !';

  String get work_permit_accepted_successfully =>
      'Work Permit Accepted Successfully !';

  String get work_permit_rejected_successfully =>
      'Work Permit Rejected Successfully !';

  String get work_permit_closed_successfully =>
      'Work Permit Closed Successfully !';

  String get work_permit_suspended_successfully =>
      'Work Permit Suspended Successfully !';

  String get work_permit_resubmitted_successfully =>
      'Work Permit Resubmitted Successfully !';

  String get checkers_reassigned_successfully =>
      '${AppData().checkerStr}s Reassigned Successfully !';

  String get audit_accepted_successfully => 'Audit Accepted Successfully !';

  String get audit_rejected_successfully => 'Audit Rejected Successfully !';

  String get time_extension_request_successfully =>
      'Time Extension Request Sent Successfully !';

  String get time_extension_accept_successfully =>
      'Time Extension Accepted Successfully  ! ';

  String get time_extension_reject_successfully =>
      'Time Extension Rejected Successfully !';

  String get work_permit_failed_save => 'Not able to save Work Permit';

  String get work_permit_time_extension_failed =>
      'There was a problem for Extension Time Request';

  String get resonForExtendTime => 'Reason';

  String get requestedExtensionTime => 'Requested Extension Time';

  String get wpUndertaking1 =>
      'I confirm that required Safety Measures have been established and adopted before starting the work by the Contractor and Worker. (मैं पुष्टि करता हूं कि ठेकेदार और कर्मचारी द्वारा काम शुरू करने से पहले आवश्यक सुरक्षा उपाय स्थापित किए गए हैं और अपनाए गए हैं। )';

  String get wpUndertaking2 =>
      'All the above information filled by me is correct. (मेरे द्वारा भरी गई उपरोक्त सभी जानकारी सही है। )';

  String get wpUndertaking3 =>
      "I authorize the work permit and sign the work permit. (मैं वर्क परमिट को अधिकृत करता हूं और वर्क परमिट पर हस्ताक्षर करता हूं।)";

  String get accept => 'Accept';

  String get accept_all => 'Accept All';

  String get reject_all => 'Reject All';

  String get reject => 'Reject';

  String get rejectIncident =>
      'Are you sure you want to reject this report ?\nThis action cannot be undone.';

  String get closeIncident =>
      'Are you sure you want to Close this report ?\nThis action cannot be undone and not editable.';

  String get cancel_debit_note => 'CANCEL DEBIT NOTE ?';

  String get button_cancel => 'Cancel ?';

  String get cancel => 'Cancel';

  String get edit_violation_notice => 'Edit Violation Notice';

  String get suspend => 'Suspend';

  String get suspension_photos => 'Suspension Photos';

  String get reason_of_rejection => 'Reason of Rejection';

  String get reason_of_cancellation => 'Reason of Cancellation';

  String get add_your_reason_of_rejection_here =>
      'Add your reason of rejection here';

  String get reason_of_suspension => 'Suspension Reason';

  String get add_your_suspension_reason_here =>
      'Add your suspension reason here';

  String get reject_audit => 'Reject Audit';

  String get accept_audit => 'Accept Audit';

  String get audit => 'Audit';

  String get resubmit => 'Resubmit';

  String get resubmission_remark => 'Resubmission Remark';

  String get profile_photo => 'Profile Photo';

  String get ppe_compliance => 'PPE’s Compliance Image';

  String get no_offline_tbt =>
      'No offline Toolbox Training created. Please Go To Maker Tab and Tap on the Add button below to create.';

  String get no_offline_tbt_maker =>
      'No offline Toolbox Training created. Tap the Add button below to create.';

  String get no_offline_tbt_offline_sync =>
      'No offline Toolbox Training created';

  String get no_offline_inductions =>
      'No Inductee Created. Please Go To Inductees Tab and select the above category to add respective inductee';

  String get no_offline_inductions_maker =>
      'No Inductee Created. Please select the above category to add respective inductee';

  String get no_offline_inductions_offline_sync =>
      'No offline Induction Training created.';

  String get no_offline_checklist_sync => 'No offline Checklist created.';

  String get no_offline_attendance_offline_sync =>
      'No offline Captured Attendance.';

  String get no_offline_work_permit =>
      'No offline work permit created. Please Go To ${AppData().makerStr} Tab and Tap on the Add button below to create.';

  String get no_offline_work_permit_maker =>
      'No offline work permit created. Tap the Add button below to create.';

  String get no_offline_task =>
      'No offline task created. Please Go To Maker Tab and Tap on the Add button below to create.';

  String get no_offline_task_maker =>
      'No offline task created. Tap the Add button below to create.';

  String get no_offline_check_list_maker =>
      'No offline checklists are available To Create';

  String get no_offline_check_list =>
      'No offline checklists created. Please Go To My Checklist Tab to create/fill the check list.';

  String get no_offline_work_permit_offline_sync =>
      'No offline work permit created.';

  String get no_offline_Task_sync => 'No offline task created.';

  String get bulk_induction_success =>
      'Bulk Induction Completed Successfully !';

  String get accept_wp_title => 'Accept work permit';

  String get reject_wp_title => 'reject work permit';

  String get suspend_wp_title => 'suspend work permit';

  String get resubmit_wp_title => 'Resubmit work permit';

  String get close_wp_title => 'close work permit';

  String get accept_audit_title => 'accept audit';

  String get reject_audit_title => 'reject audit';

  String get status_of_work_permit => 'Status of Work Permit';

  String get error_select_tbt => 'Please Select Toolbox training';

  String get error_select_main_area_permission =>
      'Please Select Main Area of Permission';

  String get error_select_sub_area_permission =>
      'Please Select Sub Area of Permission';

  String get error_field_mandatory => 'This field is mandatory';

  String get oflfine_sync_success => 'Offline Synced Successfully !';

  String get oflfine_sync_error => 'There was an error while Offline Sync!';

  String get took_action_already_auditor_wp =>
      'You can not audit this work permit as you already took action as a ${AppData().checkerStr}';

  String get took_action_already_auditor_wp_maker =>
      'You can not audit this work permit as you already took action as a ${AppData().makerStr}';

  String get punch_in => 'आगमन / MARK IN';

  String get punch_in_success => 'Time Punched Successfully !';

  String get punch_out => 'रवानगी / MARK OUT';

  String get punch_out_success => 'Time Punched Successfully !';

  String get punch_in_out_error =>
      'There was an error while doing Time Punched';

  String get work_permit_time_extension_message =>
      'Are you sure you want to request time extension for this work permit ?';

  String get inducted => 'INDUCTED';

  String get noninducted => 'NON-INDUCTED';

  String get start_testing => 'Start Testing';

  String get induction_status => 'Induction Status';

  String get debit_status_accept_successfully =>
      'Debit Note Accepted Successfully!';

  String get debit_status_reject_successfully =>
      'Debit Note Rejected Successfully!';

  String get debit_status_cancelled_successfully =>
      'Debit Note Cancelled Successfully!';

  String get debit_note_updated_successfully =>
      'Debit Note Updated Successfully!';

  //String get dash => '-';

  String get same_as_mention_aadhar =>
      'Same as mention in the Aadhaar Card Number above.';

  String get valid_aadhar_number =>
      'Please enter valid details in above Aadhaar Card Number Field';

  //Checklist
  String get my_checklist_tab => 'My Checklist';

  String get for_review_tab => 'For Review';

  String get name_of_checklist => 'Name of Checklist';

  String get name_of_form => 'Name of Form';

  String get deleted_on => 'Deleted on';

  String get deleted_by => 'Deleted By';

  String get checklist_type => 'Checklist type';

  String get form_type => 'Form type';

  String get checklist_status => 'Checklist status';

  String get form_status => 'Form status';

  String get checklist_document_number => 'Checklist Document Number';

  String get form_document_number => 'Form Document Number';

  String get remark => 'Remark';

  String get error_remark => 'Enter Valid Remark';

  String get checklist_description => 'Checklist Description';

  String get form_description => 'Form Description';

  String get sync_type => 'Sync Type';

  String get spot_name => 'Spot Name';

  String get cl_no => 'CL No';

  String get select_cl_no => 'Select CL No';

  String get spot_group => 'Spot Group';

  String get checklist_banner => 'Checklist Banner';

  String get select_spot_group => 'Select Spot Group';

  String get select_spot_name => 'Select Spot Name';

  String get view_reference_image => 'View Reference Image';

  String get select => 'Select';

  String get previous => 'Previous';

  String get on_demand_checklist => 'On Demand Checklists';

  String get on_demand_form => 'On Demand Form';

  String get select_section => 'Select Section';

  String get not_applicable => 'Not Applicable';

  String get submit_checklist_message =>
      'Are you sure you want to submit this checklist ?';

  String get submit_form_message =>
      'Are you sure you want to submit this Form ?';

  String get submit_checklist_title => 'SUBMIT CHECKLIST';

  String get submit_form_title => 'SUBMIT FORM';

  String get addOtherRepresentatives => 'Add Other Representatives';

  String get please_add_addOtherRepresentatives =>
      'Please Add Other Representatives';

  String get your_remark => 'Your Remark';

  String get select_checking_authority => 'Select Checking Authority';

  String get checklist_submitted_successfully =>
      'Checklist Submitted Successfully !';

  String get form_submitted_successfully => 'Form Submitted Successfully !';

  String get checklist_deleted_successfully =>
      'Checklist Deleted Successfully !';

  String get form_deleted_successfully => 'Form Deleted Successfully !';

  String get checklist_removed_successfully =>
      'Checklist Removed Successfully !';

  String get form_removed_successfully => 'Form Removed Successfully !';

  String get checklist_reassigned_successfully =>
      'Checklist Re-assigned Successfully !';

  String get form_reassigned_successfully => 'Form Re-assigned Successfully !';

  String get remove => 'Remove';

  String get please_fill_all_mandatory_fileds =>
      'Please fill all the mandatory fields';

  String get checklist_rejected_reason_not_configured =>
      'Checklist Rejections are not configured by your admin. Please contact Admin';

  String get select_reject_reason => 'Please select reason of Rejection';

  String get checklist_rejected_successfully =>
      'Checklist Rejected Successfully !';

  String get form_rejected_successfully => 'Form Rejected Successfully !';

  String get checklist_accepted_successfully =>
      'Checklist Accepted Successfully !';

  String get form_accepted_successfully => 'Form Accepted Successfully !';

  String get error_while_submitting_checklist =>
      'There was an error while submitting checklist';

  String get error_while_reassigning_checklist =>
      'There was an error while re-assigning checklist';

  String get date_not_synced_error =>
      'Your mobile date is not synced with the Current Date, Please set proper current date to use this application';

  String get delete_checklist => 'Delete Checklist';

  String get delete_form_template => 'Delete Form Template';

  String get reason_of_deletion => 'Reason of deletion';

  String get delete_checklist_message =>
      'This action will delete the selected checklist permanently from your list. To proceed ahead, please mention the reason of deletion below.';

  String get delete_form_template_message =>
      'This action will delete the selected form template permanently from your list. To proceed ahead, please mention the reason of deletion below.';

  String get attach_safety_actionable => 'Attach Safety Observation';

  String get responsible_contractor_firm => 'Responsible Contractor Firm';

  String get locationOfVio => 'Location of Violation';

  String get violationDetails => 'Violation Details';

  String get add_responsible_contractor_firm =>
      'Add Responsible Contractor Firm';

  String get enterViolationDetails => 'Enter Violation Details';

  // Violation filters
  String get severityOfViolation => 'Severity of Violation';

  String get selectSeverityOfViolation => 'Select Severity of violation';

  String get safetyactiobnableId => 'Safety Observation ID';

  String get caseid => 'Case ID';

  String get noticeid => 'Notice ID';

  String get amount => 'Amount';

  String get amountMax => 'Maximum Amount';

  String get amountMin => 'Minimum Amount';

  String get action => 'Action Taken';

  String get new_violation_notice => 'New Violation Notice';

  String get severity_of_violation => 'Severity of Violation';

  String get select_severity_of_violation => 'Select Severity of Violation';

  String get debit_amount => 'Debit Amount in ₹';

  String get makers_sign => 'Makers Sign';

  String get receivers_information => 'Receiver\'s Information';

  String get receiving_person => 'Receiving Person';

  String get add_receiving_person => 'Add Receiving Person';

  String get enter_name => "Enter Name";

  String get add_reciever => 'Add Receiver';

  String get edit_reciever => 'Edit Receiver';

  String get error_selecte_contractor_firm => 'Please Select Contractor Firm';

  String get error_selecte_receiver => 'Please Add Receiving Person';

  String get error_enter_name => 'Please Enter Name';

  String get rupee_symbol => '-₹';

  String get error_enter_location_of_violation =>
      'Please Enter Location of Violation';

  String get error_enter_violation_details => 'Please Enter Violation Details';

  String get violation_notice_created_successfully =>
      'Violation Notice Created Successfully !';

  String get accept_debit_note_dilaog_message =>
      'Are you sure you want to accept this debit note ?';

  String get reject_debit_note_dilaog_message =>
      'Are you sure you want to reject this debit note ?';

  String get cancel_debit_note_dilaog_message =>
      'Are you sure you want to cancel this debit note ?';

  String get accept_debit_note_dialog_title => 'ACCEPT DEBIT NOTE';

  String get reject_debit_note_dialog_title => 'REJECT DEBIT NOTE';

  String get cancel_debit_note_dialog_title => 'CANCEL DEBIT NOTE';

  String get create_debit_note => 'CREATE A DEBIT NOTE ?';

  String get debit_note_failed_save => 'Not able to save Debit Note';

  String get work_permit_pending_actions => 'Work Permit Pending Actions';

  String get total_results => ' Total Results ';

  String get fill_advance_form => 'Fill the advance form ?';

  String get fill_basic_form => 'Fill the basic form ?';

  String get project_labours => 'Project Workers';

  String get project_labour => 'Project Worker';

  String get fetch_labor => 'Fetch Worker';

  String get labour_id => 'Worker ID';

  String get labour_name => 'Worker Name';

  String get contact_number => 'Contact Number';

  String get labour_status => 'Worker Status';

  String get contractor_firm_not_registered => 'Please update contractor firm';

  String get change_contractor_firm => 'Change Contractor Firm';

  String get import_labour =>
      'Please search or filter for the worker to get the results';

  String get update_contractor_firm =>
      'Please update contractor firm for this Worker';

  String get update_contractor_firm_all_labors =>
      'Please update contractor firm for all Workers';

  String get select_labor => 'Please select Worker to add to project';

  String get add_to_project => 'Add To Project';

  String get labor_added_success => ' Worker Added Successfully!';

  String get labor_updated_success => ' Worker Updated Successfully!';

  String get labors_added_success => ' Workers Added Successfully!';

  String get select_date_range => 'Select Date Range';

  String get create_task => 'Create Task';

  String get task_title => 'Task Title';

  String get alert_expirt_date => 'Alert Expiry Date';

  String get alert_expirt_date_only => 'Alert Expiry Date';

  //Task
  String get tabByMe => 'By Me';

  String get tabForMe => 'For Me';

  String get tabMyAlert => 'My Alert';

  String get taskId => 'Task ID';

  String get checkerId => '${AppData().checkerStr} ID';

  String get locationOfViolation => 'Location of Violation';

  String get priority => 'Priority';

  String get showDelayed => 'Show delayed';

  String get buttonAddAssignor => 'Add Assignor';

  String get buttonAddAssignee => 'Add Assignee';

  String get cancel_task => 'CANCEL TASK';

  String get cancel_task_msg => 'Are you sure you want to cancel this task ?';

  String get closing_remark => 'Closing Remarks';

  String get complete_remark => 'Complete Remarks';

  String get problem_statement => 'Problem Statement';

  String get complete => 'Complete';

  String get checklistId => 'Checklist Id';

  String get nameOfChecklist => 'Name of Checklist and Version';

  String get checkpoint => 'Checkpoint';

  String get sourceOfTask => 'Source of Task';

  String get taskID => 'Task ID';

  String get syncType => 'Sync Type';

  String get taskTitle => 'Task Title';

  String get taskDetails => 'Task Details';

  String get turnAroundTime => 'Turn Around Time';

  String get locationOfTask => 'Location of Task';

  String get alertRecipients => 'Alert Recipients';

  String get alertCount => 'Alert Count';

  String get alertGap => 'Alert Gap (in Days)';

  String get createdDateAndTime => 'Created Date and Time';

  String get cancelTask => 'Cancel Task';

  String get tabReport => 'Report';

  String get tabResponse => 'Response';

  String get task_cancel_updated_successfully => 'Task  Cancelled!';

  String get task_closed_updated_successfully => 'Task  Closed!';

  String get task_inprogress_updated_successfully => 'Task  In-Progress!';

  String get task_completed_updated_successfully => 'Task  Completed!';

  String get task_reassign_updated_successfully => 'Task Reassign';

  String get taskStatus => 'Task Status';

  String get reopen => 'Reopen';

  String get inprogress => 'In-Progress';

  String get task_reopend_successfully => 'Task  Reopened!';

  String get alert_recipient => 'Alert Recipients';

  String get add_alert_recipient => 'Add Alert Recipients';

  String get create_task_message =>
      'Are you sure you want to create this Task ?';

  String get error_select_source_task => 'Please Select Source of Task';

  String get add_response => 'Add Response';

  String get task_attachments => 'Task Attachments';

  String get attachments => 'Attachments';

  String get task_response_added => 'Task Response added Successfully !';

  String get ocr_capture_document => "Capture Document";

  String get visit_project => "Visit Project";

  String get add_pass => "Add Pass";

  String get visitor => "Visitor";

  String get generate_visitor_pass => 'Generate Visitor Pass';

  String get access_visitor_pass => 'Access Visitor Pass';

  String get visitor_address => 'Visitor Address';

  String get back_generate_visitor_pass => 'Back to Generate visitor pass ?';

  String get reason_for_visit => 'Reason for Visit';

  String get acknowledge_and_agree => 'I acknowledge and agree to :';

  String get visit_date => 'Visit Date and Time';

  String get error_valid_visitor_address => 'Enter valid Visitor address';

  String get error_valid_visit_reason => 'Enter valid Reason for Visit';

  String get error_valid_visit_date => 'Select valid Visit Date and Time';

  String get error_agree_ack => 'Please Agree and Acknowledge all the points.';

  String get my_pass => 'My Pass';

  String get visitor_pass => 'Visitor Pass';

  String get i_am_a_visitor => 'I AM A VISITOR';

  String get otp_limit => 'You have completed requesting OTP limit';

  String get entry_given => 'Entry Given Successfully!';

  String get entry_exited => 'Visit Ended Successfully!';

  String get instructions => 'Instructions';

  String get instructions_hindi => 'अनुदेश';

  String get aadhar_instructions =>
      // '• Government ID photos can be used to capture the personal information.'
      '• Aadhar Card photos can be used to capture the personal information.'
      '\n\n• Upload the first photo with Name, DOB, and Gender. Then, upload the second photo with the Address.'
      '\n\n• Upload images in either Vertical or Horizontal format.'
      '\n\n• If only the year is provided for the date of birth (DOB), it will be automatically set to \'January 1st of that year'
      '\n\n• All information on the Aadhar Card card/photo must be clearly visible for the system to read the data.'
      '\n\n• Do not upload the blurry or tilted images.'
      '\n\n• Due to our use of third-party services, data information may occasionally be inaccurate.'
      '\n\n• Please verify all populated data.';
  // '\n\n• Construction SafetyApp does not mandate Aadhaar. Government ID documents are uploaded by the employer or user as required by site or statutory authorities.';

  String get aadhar_instructions_hindi =>
      '• व्यक्तिगत जानकारी हासिल करने के लिए आधार फोटो/वास्तविक फोटो का उपयोग किया जा सकता है|'
      // '\n\n• पहली फोटो नाम, जन्मतिथि और लिंग के साथ अपलोड करें। फिर, पते के साथ दूसरी फोटो अपलोड करें।'
      '\n\n• छवियों को लंबवत या क्षैतिज प्रारूप में अपलोड करें।'
      '\n\n• यदि जन्मतिथि (डीओबी) के लिए केवल वर्ष प्रदान किया गया है, तो यह स्वचालित रूप से \'उस वर्ष की 1 जनवरी पर सेट हो जाएगा।'
      '\n\n• सिस्टम द्वारा डेटा पढ़ने के लिए आधार कार्ड/फोटो पर सभी जानकारी स्पष्ट रूप से दिखाई देनी चाहिए।'
      '\n\n• धुंधली या झुकी हुई तस्वीरें अपलोड न करें।'
      '\n\n• तृतीय-पक्ष सेवाओं के हमारे उपयोग के कारण, डेटा जानकारी कभी-कभी गलत हो सकती है।'
      '\n\n• कृपया सभी पॉपुलेटेड डेटा को सत्यापित करें';
  // '\n\n• कंस्ट्रक्शन सेफ्टी ऐप में आधार कार्ड अनिवार्य नहीं है। सरकारी पहचान पत्र नियोक्ता या उपयोगकर्ता द्वारा साइट या वैधानिक अधिकारियों के निर्देशानुसार अपलोड किए जाते हैं।';

  String get eventsType => 'Event/ Training Type';

  String get selectEventsType => 'Select Event /Training Type';

  String get selectType => 'Select Type';

  String get eventTrainingName => 'Event/ Training Name';

  String get errorEventTrainingName =>
      'Please enter valid Event/ Training Name';

  String get eventTrainingDescription => 'Event/ Training Description';

  String get eventVenue => 'Venue';

  String get errorEventVenue => 'Please enter valid Event Venue';

  String get errorEventAttendees => 'Please enter no. of Attendees(Max 500)';

  String get eventDate => 'Event Date';

  String get eventDateAndStartTime => 'Event Date and Start Time';

  String get eventTime => 'Event Start and End Time';

  String get timeDuration => 'Time Duration';

  String get targetGroup => 'Target Group';

  String get exceptedNoOfAttendees => 'Expected no. of Attendees';

  String get speaker => 'Instructor';

  String get addOtherAttendees => 'Add Other Attendee';

  String get errorSpeakerName => 'Please enter valid InstructorName';

  String get errorAddOtherAttendees => 'Please enter valid Other Attendee Name';

  String get speakerCompany => 'Company Name';

  String get errorSpeakerCompanyName => 'Please enter Company Name';

  String get addInstructor => 'In The Presence Of';

  String get addMoreInstructor => 'Add More';

  String get updateInstructor => 'Update';

  String get startEvent => 'START EVENT';

  String get scheduleEvent => 'SCHEDULE EVENT';

  String get saveChanges => 'Save Changes';

  String get save => 'Save';

  String get scheduleEventSuccess => 'Event Scheduled Successfully !';

  String get changesSavedSuccess => 'Changes Saved Successfully !';

  String get startEventSuccess => 'Event Started Successfully !';

  String get scheduleEventCancel => 'Event Cancelled Successfully !';

  String get scheduleEventClosed => 'Events Closed Successfully !';

  String get scheduleEventCompleted => 'Event Completed Successfully !';

  String get cancelEvent => 'Cancel Event';

  String get completeEvent => 'Complete Event';

  String get areYourSureWantToCancelEvent =>
      'Are you sure you want to cancel this event ?';

  String get areYourSureWantToCloseEvent =>
      'Are you sure you want to close this event ?';

  String get areYourSureWantToCompleteEvent =>
      'Are you sure you want to complete this event ?';

  String get buttonYes => 'Yes';

  String get buttonNo => 'No';

  String get buttonComplete => 'Complete';

  String get addAttendees => 'Add Attendees';

  String get visitorUndertaking1 =>
      'Wear a provided safety helmet at all times.';

  String get visitorUndertaking2 =>
      'Follow designated paths and safety signage.';

  String get visitorUndertaking3 =>
      'Carry and display visitor identifications.';

  String get visitorUndertaking4 =>
      'Keep children and pets off the construction site.';

  String get visitorUndertaking5 =>
      'I confirm that I am 18 years or older in age and I understand my safety at construction site is my responsibility.';

  String get safety_week => "Event Details";

  String get speaker_details => 'Instructor Details';

  String get attendees => 'Attendees';

  String get internal_attendees => 'Internal Attendees';

  String get external_attendees => 'Other Attendees';

  String get event_id => 'Event ID: ';

  String get exp_num_attendees => 'Expected No. Of Attendees';

  String get actual_num_attendees => 'Actual No. Of Attendees ';

  String get closeEvent => 'Close Event';

  String get take_look => 'Explore App';

  String get closingEvents => 'Closing event ID\'s';

  String get self_login_form => 'Sign Up';

  String get contact_details => 'Contact Details';

  String get otp_verification => 'OTP Verification';

  String get add_project => 'Add Project';

  String get mobile => 'Mobile';

  String get get_otp => 'Get Otp';

  String get email_verification => 'Email Verification';

  String get email_instruction => 'Enter your email OTP';

  String get mobile_verification => 'Mobile Verification';

  String get verify_number => 'Verify Your Number';

  String get mobile_instruction => 'Enter your mobile OTP';

  String get error_valid_mobile => 'Please enter valid Mobile NO.';

  String get add_new_project => 'Add New Project';

  String get edit_project => 'Edit Project Details';

  String get add_new_user => 'Invite New User';

  String get users => 'Users';

  String get edit_user => 'Edit User';

  String get projectDetails => 'Project Details';

  String get projectName => 'Project Name';

  String get developerName => 'Developer Name';

  String get website => 'Website';

  String get city => 'City';

  String get logo => 'Logo';

  String get username => 'Username';

  String get onlyJPGPNG =>
      'Only JPG or PNG (Max. size 2 MB)\n\nRecommended dimension: 1801x1801 pixels';

  String get jpg_required => "Jpg,Pdf or doc upto 5 mb";

  String get upload_supporting_doc => "Upload Supporting Document";

  String get recommended_dimensions =>
      'Recommended dimension: 1801x1801 pixels';

  String get pendingRequest => 'Pending Request';

  String get errorProjectName => 'Enter Valid Project Name';

  String get errorDeveloperName => 'Enter Valid Developer Name';

  String get errorCompanyName => 'Enter Valid Company Name';

  String get errorValidWebsite => 'Enter Valid Website URL';

  String get errorValidCity => 'Enter Valid City Name';

  String get errorValidUserName => 'Enter Valid Username (Min 5 Characters) ';

  String get userCreatedSuccessfully => 'User Created Successfully !';

  String get projectCreatedSuccessfully => 'Project Created Successfully !';

  String get projectUpdatedSuccessfully => 'Project Updated\nSuccessfully !';

  String get userUpdatedSuccessfully => 'User Updated Successfully !';

  String get userDeletedSuccessfully => 'User Deleted Successfully !';

  String get pleaseSelectReviewer => 'Please Select Reviewer';

  String get manageUsers => 'Manage Users';

  String get manageProjects => 'Manage Projects';

  String get ohs_document => 'OH&S Document';

  String get request_for_access => 'Request For Access';

  String get request_for_another_access => 'Request For Another Access';

  String get credential_sent => 'Credentials Sent';

  String get credential_sent_description =>
      'Your Credentials have been sent to your email';

  String get credential_sent_screen_title => 'Thank You!';

  String get credential_sent_screen_title_description =>
      'Thank you for completing the sign-up process.You\'re just a step away from exploring our app!';

  String get verify => 'Verify';

  String get exit => 'Exit';

  String get consent => 'Yes , I Agree';

  String get highlight_features => 'Highlight Features';

  String get highlight_feature1 =>
      '• Experience our Safety Observation Module, designed to effectively address your safety concerns.';

  String get selectAttendanceStatement =>
      'Please select how attendance should be recorded:';

  String get selectAttendance => 'Select Attendance Preference';

  String get highlight_feature2 =>
      '• Complete the signup process by following steps 1 to 3 on the next screens.';

  String get highlight_feature3 =>
      '• You will need to provide the project name, company name, designation, address, city, and other general information to complete.';

  String get highlight_feature4 =>
      '• Verification OTP will be sent to your email and mobile for authentication.';

  String get terms_condtion_url =>
      'https://www.constructionsafetyapp.com/terms-and-conditions';

  String get privacy_policy_url =>
      'https://www.constructionsafetyapp.com/privacy-policy';

  String get privacy_policy => 'Privacy Policy';

  String get goto_login => 'GO TO LOGIN';

  String get support_email => 'support@constructionsafetyapp.com';

  String get support_phone => '+91 8007002826';

  String get instruction_manual_link =>
      '${Environment.baseUrl}/admin/api/v1/users/freemium-instruction-pdf/Instruction_Manual.pdf';

  // String get mixpanel_project_token => 'c7605684c68b8503cf57f0a375f1c1b7'; //DEV

  String get mixpanel_project_token => '5536eccbaf1defe274f469603477bcbd'; //UAT

  String get agree_with => 'I agree with ';

  String get subscriptionErrorMultiProject =>
      'Your access is no longer active. Please contact your admin or switch to another project';

  String get subscriptionErrorSingleProject =>
      'Your access is no longer active. Please contact your admin';

  String get invite_new_user => 'INVITE NEW USER';

  String get company_name => 'Company Name';

  String get invite => 'Invite';

  String get projects => 'Projects';

  String get you_can_add_up_to =>
      'You can add up to 2 projects as a project admin';

  String get mobile_otp_verification =>
      'Mobile OTP verification will be done at the time of login ';

  String get staffId => 'Staff ID';

  String get incidentDateAndTime => 'Date and Time of Incident';

  String get enterActivity => 'Work Activity';

  String get fileDownloadError =>
      'There was a problem while downloading the file';

  String get fileSuccessfullyDownloaded => 'File downloaded successfully';

  String get staffNote =>
      '• "The system will generate Staff ID automatically if not entered"'
      '\n• "Once it is submitted, it will be non-editable."';

  //MixPanel

  //Event Name
  String get login_done => 'login_done';

  String get logout_done => 'logout_done';

  String get explore_app_button_clicked => 'explore_app_button_clicked';

  String get terms_and_conditions_viewed => 'terms_and_conditions_viewed';

  String get privacy_policy_viewed => 'privacy_policy_viewed';

  String get signup_done => 'signup_done';

  String get post_signup_project_added => 'post_signup_project_added';

  String get support_url_clicked => 'support_url_clicked';

  String get disable_module_clicked => 'disable_module_clicked';

  String get subscription_ended => 'subscription_ended';

  String get mobile_pdf_download => 'mobile_pdf_download';

  //Super Properties
  String get static_first_name => 'Static First Name';

  String get static_last_name => 'Static First Name';

  String get static_email => 'Static First Name';

  String get static_mobile_number => 'Static First Name';

  String get static_user_hash => 'Static First Name';

  String get static_user_name => 'Static Username';

  String get toolBoxTrainingsCreated => 'ToolBox Training Created';
  String get activeUser => 'Active user';
  String get workPermitsCreated => 'Work Permits Created';
  String get inductionTrainingCreated => 'Induction Training Created';

  String get safetyObservationsReported => 'Safety Observations Reported';
  String get incidentReported => 'Incident Reported';

  String get workpermitApproved => 'WorkPermit Approved';
  String get workpermitRejected => 'WorkPermit Rejected';
  String get workpermitClosed => 'WorkPermit Closed';
  String get workpermitSuspended => 'WorkPermit Suspended';
  String get workpermitResubmitted => 'WorkPermit Resubmitted';
  String get workpermitAuditAccepted => 'WorkPermit Audit Accepted';
  String get workpermitAuditRejected => 'WorkPermit Audit Rejected';
  String get workpermitReassignCheckersInReview =>
      'WorkPermit Reassign Checkers';

  //Properties
  String get page_name => 'Page Name';

  String get page_sub_category => 'Page Sub-Category';

  String get login_status => 'Login Status';

  String get logged_in => 'Logged In';

  String get logged_out => 'Logged Out';

  String get explore_app_click => "On Explore App Click";

  String get button_label => "Button Label";

  String get module_name => "Module Name";

  String get explore_app => "Explore App";

  String get anonymous_id => "Anonymous Id";

  String get terms_and_condition => 'Terms And Conditions';

  String get email => 'Email';

  String get usercity => 'User City';

  String get subscription_end_date => 'Subscription End Date';

  String get subscription_ended_error =>
      'Your subscription has ended. For assistance, contact the SafetyApp support team.';

  String get subscription_ended_error_non_admin_multi_project =>
      'Your access has ended. Please contact your project admin or the SafetyApp support team .';

  String get subscription_ended_error_non_admin =>
      'Your access has ended. Please contact your project admin or the SafetyApp support team.';

  String get ok => 'OK';

  String get unlockFeatures =>
      'To unlock all features, please contact support.';

  String get maxProjects => 'Max 2 Projects in Free Trial';

  String get maxUpToProjects =>
      'You can add up to 2 projects \nin the free trial.\n\nTo unlock unlimited project creation, subscribe our premium plans';

  String get emergencyContactsError =>
      'Emergency contacts are not configured for';

  String get trainingVideosError => 'Training Videos are not configured for';

  String get inductionCategoriesAreNotAvailable =>
      'Induction Training categories are not available.';

  String get select_signature_configuration =>
      'Please select signature configuration to proceed';

  String get draw_signature_behalf_of_trainee_contractor => '';

  String get consent_to_fetch_signature =>
      'Please provide your consent to fetch the trainee\'s signature from the induction process';

  String get fetch_signature_internet_required =>
      'Please check or enable the internet connection to fetch the trainee\'s signature from the induction process';

  String get consent_to_fetch_signature_attendees =>
      'Please provide your consent to fetch the attendee\'s signature from the induction process';

  String get contractor_firms_not_available =>
      'Contractor Firms are not available for selected trainee list. Please choose another signature type';

  String get error_draw_signature_maker =>
      'Please Draw/Save Your Signature For ${AppData().makerStr}';

  String get otp_verified_successfully => 'OTP verified successfully.';

  String get labourUnfitAdmin =>
      'The worker was found unfit and has been rejected by the ';

  String get labourUnfitProject =>
      'The worker was found unfit and has been rejected for the';

  String get errorSubmitCheckList =>
      'The was a problem while submitting your cheklist';

  String get signature_fetch_consent =>
      'I, hereby declare that I am fetching the signature of Worker\'s, '
      'captured previously in the system, for Toolbox training purposes. '
      'This is my conscious decision, and I do not hold any other person or any third party responsible '
      'in case of disputes or breach of any laws. \n मैं, इसके द्वारा घोषणा करता हूं कि मैं मजदूर के हस्ताक्षर ला रहा हूं, '
      'टूलबॉक्स प्रशिक्षण उद्देश्यों के लिए सिस्टम में पहले से कैप्चर किया गया। यह मेरा सचेत निर्णय है, '
      'और मैं किसी अन्य व्यक्ति या किसी तीसरे पक्ष को जिम्मेदार नहीं ठहराता '
      ' विवाद या किसी कानून के उल्लंघन के मामले में।';

  String get signature_fetch_consent_attendees =>
      'I, hereby declare that I am fetching the signature of attendee\'s, captured previously in the system, for Training & Events purposes. '
      'This is my conscious decision, and I do not hold any other person or any third party responsible in case of disputes or breach of any laws. '
      '\n मैं, इसके द्वारा घोषणा करता/करती हूं कि मैं प्रशिक्षण और कार्यक्रमों के उद्देश्यों के लिए सिस्टम में पहले से कैप्चर किए गए उपस्थितियों के हस्ताक्षर प्राप्त कर रहा/रही हूं। '
      'यह मेरा स्वैच्छिक निर्णय है, और मैं किसी अन्य व्यक्ति या किसी तृतीय पक्ष को किसी भी विवाद या किसी कानून के उल्लंघन की स्थिति में उत्तरदायी नहीं ठहराता/ठहराती हूं।';

  String get staffJoiningDate => 'Staff Joining Date';

  String get uploadImage => 'Upload Image';

  String get pelase_add_profile_pic => 'Please Add Profile Pic For';

  String get precautions_image => 'Precaution Image';

  String get noTodaysTBT => 'No today’s toolbox training (TBT) is available';

  String get noSearchResult => 'No search results were found.';

  String get noMatchingTBTs =>
      'No matching toolbox training sessions were found';

  String get yes => 'Yes';

  String get no => 'No';

  String get five_why_analysis => '5 Why Analysis';

  String get fishbone_analysis => 'Fishbone Analysis';

  String get recommendation => 'Recommended Action';

  String get fill_mandatory => "Please fill in all mandatory fields";

  String get bulkinduction_warning_unfit_labour =>
      'The following will apply to successfully inducted workers:\n'
      '\n1. Safety equipment provided.\n2. Induction documents.\n3. Instructions given.';

  String get safety_officer => 'Safety Incharge';

  String get rca_by => 'RCA By';

  String get capa_by => 'Corrective Actions';

  String get pa_by => 'Preventive Actions';

  String get add_safety_officer => 'Add Safety Incharge';

  String get incident_approved => 'RCA/PA Assigned Successfully';

  String get incident_rejected => 'Incident Report Rejected Successfully';

  String get incident_closed => 'Incident Report Closed Successfully';

  String get rca_status => 'RCA SUBMITTED';

  String get corrective_action_submit =>
      'Corrective Action Resolved Successfully';

  String get preventive_action_submit =>
      'Preventive Action Resolved Successfully';

  String get submitted_by => 'Submitted By';

  String get assigned_by => 'Assigned By';

  String get rejected_by => 'Rejected By';

  String get approved_by => 'Approved By';

  String get assigned_user => 'Assigned User';

  String get resolved_by => 'Resoled By';

  String get immediateActionTaken => 'Corrective Action Taken';

  String get equipmentsInvolved => 'Equipment(s) Involved';

  String get natureOfInjury => 'Nature of Injury';

  String get typeOfAccident => 'Type of Incident';

  String get bodyPartsInjured => 'Body Part(s) of Injured';

  String get signatureFileNotAvailable => 'Signature File is not available';

  String get closedBy => 'Closed By';

  String get captureAttendance => "Capture Attendance";

  String get lostTimeDueToInjury => 'Lost Time Due to Injury (In Hrs)';

  String get signatureConfigNotPresent =>
      'Please contact the admin to enable the signature option.';

  String get contractorDetailsNotFound =>
      'Contractor details not found. Please contact your admin for updating the details';

  String get syncProjectData => 'Sync Project Data';

  String get ohsDocumentFetched => 'OHS Document fetched successfully';

  String get ohsDocumentCategoryFetched =>
      'OHS Document Category fetched successfully';

  String get SAME_AS_PERMANENT => 'SAME_AS_PERMANENT';

  String get LABOUR_CAMP => 'LABOUR_CAMP';

  String get MANUAL_INPUT => 'MANUAL_INPUT';

  String get edit_current_address => 'Edit Current Address';

  String get previous_address => 'Previous Address';

  String get new_address => 'New Address';
}
