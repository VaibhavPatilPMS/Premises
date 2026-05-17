import 'app_customizations.dart';

class AppIcons {
  static final AppIcons _icon = AppIcons._internal();

  AppIcons._internal();

  factory AppIcons() => _icon;

  icon(key) => "assets/icons/$key";

  String? getLabourDigitalProfileIcon(String? iconFilename) {
    if (iconFilename == null || iconFilename.trim().isEmpty) {
      return null;
    }

    return icon(iconFilename.trim());
  }

  //App Customizations
  get ic_app_logo => AppCustomizationIcons().ic_app_logo;

  //App Icons
  // Milestone 1
  get ic_menu => icon("ic_menu.svg");

  get ic_notification => icon("ic_notification.svg");

  get ic_arrow_down => icon("ic_arrow_down.svg");

  get ic_arrow_forward => icon("ic_arrow_forward.svg");

  get ic_work_permit_db => icon("ic_work_permit_db.svg");

  get ic_toolbox_training_db => icon("ic_toolbox_training_db.svg");

  get ic_checklist_db => icon("ic_checklist_db.svg");

  get ic_scoring_db => icon("ic_scoring_db.svg");

  get ic_safety_observations_db => icon("ic_safety_observations_db.svg");

  get ic_incident_report_db => icon("ic_incident_report_db.svg");

  get ic_mobile_ohs_document => icon("ic_mobile_ohs_document.svg");

  get ic_qa_create_workpermit => icon("ic_create_workpermit.svg");

  get ic_camera => icon("ic_camera.svg");

  get ic_camera_circle => icon("ic_camera_circle.svg");

  get ic_camera_grey => icon("ic_camera_grey.svg");

  get ic_sync_offline => icon("ic_sync_offline.svg");

  get ic_induction_training_db => icon("ic_induction_training_db.svg");

  get ic_add_labor => icon("ic_add_labor.svg");

  get ic_scan_qr_code => icon("ic_scan_qr_code.svg");

  get ic_scan_qr_white => icon("ic_scan_qr_white.svg");

  get ic_accepted_workpermit => icon("ic_accepted_workpermit.svg");

  get ic_info_white => icon("ic_info_white.svg");

  get ic_success => icon("ic_success.svg");

  get ic_warning => icon("ic_success.svg");

  get ic_error => icon("ic_success.svg");

  get ic_toast_general => ic_info_white;

  get ic_close_icon => icon("ic_close_icon.svg");

  get ic_close_fill_grey => icon("ic_close_fill_grey.svg");

  get ic_create_tbt => icon("ic_create_tbt.svg");

  get ic_arrow_up_fill => icon("ic_arrow_up_fill.svg");

  get ic_arrow_down_fill => icon("ic_arrow_down_fill.svg");

  get ic_arrow_back => icon("ic_arrow_back.svg");

  get ic_emergency_contact => icon("ic_emergency_contact.svg");

  get ic_delete => icon("ic_delete.svg");

  get ic_filter => icon("ic_filter.svg");

  get ic_user_default_image => icon("ic_user_alt_white.svg");

  get ic_drawer_bell => icon("ic_drawer_bell.svg");

  get ic_drawer_change_password => icon("ic_drawer_change_password.svg");

  get ic_drawer_emergency_contact => icon("ic_drawer_emergency_contact.svg");

  get ic_drawer_support => icon("ic_drawer_support.svg");

  get ic_qr_offline => icon("ic_qr_offline.svg");

  get ic_qr_online => icon("ic_qr_online.svg");

  get ic_staff => icon("ic_staff.svg");

  get ic_labor => icon("ic_labor.svg");

  get ic_govt => icon("ic_govt.svg");

  get ic_contractor => icon("ic_contractor.svg");

  get ic_consultant => icon("ic_consultant.svg");

  get ic_client => icon("ic_client.svg");

  get ic_doc_attachment => icon("ic_doc_attachment.svg");

  get ic_edit_sign_icon => icon("ic_edit_sign_icon.svg");

  get ic_edit => icon("ic_edit.svg");

  get ic_close_orange => icon("ic_close_orange.svg");

  get ic_date_time => icon("ic_date_time.svg");

  get ic_location => icon("ic_location.svg");

  get ic_drawer_solid_support => icon("ic_drawer_solid_support.svg");

  get ic_drawer_training_videos => icon("ic_drawer_training_videos.svg");

  get ic_left_back_arrow => icon("ic_left_back_arrow.svg");

  get ic_atatched_document => icon("ic_atatched_document.svg");

  get ic_open_ohs_document => icon("ic_open_ohs_document.svg");

  get ic_solid_camera => icon("ic_solid_camera.svg");

  get ic_create_incident_report => icon("ic_create_incident_report.svg");

  get ic_create_safety_actionable => icon("ic_create_safety_actionable.svg");

  get ic_mark_out => icon("ic_mark_out.svg");

  get ic_mark_in => icon("ic_mark_in.svg");

  get ic_face_net => icon("ic_face_net.svg");

  get ic_id_valid => icon("ic_green_valid.svg");

  get ic_id_invalid => icon("ic_red_invalid.svg");

  get ic_no_internect_connection => icon("ic_no_internet_connection.svg");

  get ic_dashboard => icon("ic_dashboard.svg");

  //debit note
  get ic_debit_rupees => icon("ic_debit_rupees.svg");

  get ic_red_cross => icon("ic_red_cross.svg");

  get ic_green_correct => icon("ic_green_correct.svg");

  // Milestone 2
  get ic_device_test => icon("ic_device_test.svg");

  get ic_gallary => icon("ic_gallary.svg");

  get ic_arrow => icon("ic_arrow.svg");

  get checklist_section_draft => icon("ic_checklist_section_draft.svg");

  get checklist_section_filled => icon("ic_checklist_section_filled.svg");

  get ic_violation_notice => icon("ic_violation_notice.svg");

  get ic_sync_offline_grey => icon("ic_sync_offline_grey.svg");

  get ic_sync_offline_orange => icon("ic_sync_offline_orange.svg");

  get ic_delete_checklist => icon("ic_delete_checklist.svg");

  get ic_remove_checklist => icon("ic_remove_checklist.svg");

  get ic_deleted_checklist_card => icon("ic_deleted_checklist_card.svg");

  get ic_project_labour => icon("ic_project_labour.svg");

  get ic_caller_icon => icon("ic_caller_icon.svg");

  get inward_work_force => icon("ic_inward.svg");

  get outward_work_force => icon("ic_outward.svg");

  get ic_work_force => icon("ic_work_force.svg");

  get ic_bell => icon("ic_bell.svg");

  get ic_minus_alert_count => icon("ic_minus_alert_count.svg");

  get ic_plus_alert_count => icon("ic_plus_alert_count.svg");

  //task
  get ic_task => icon("ic_task.svg");

  get ic_alert => icon("ic_alert.svg");

  get ic_reminder => icon("ic_reminder.svg");

  get ic_warning_task => icon("Ic_alert_triangle.svg");

  get ic_response => icon("ic_response.svg");

  get ic_task_complete => icon("ic_task_complete.svg");

  get ic_location_orange => icon("ic_location_orange.svg");

  get ic_date_time_orange => icon("ic_date_time_orange.svg");

  get ic_profile_orange => icon("ic_profile_orange.svg");

  get ic_user_black => icon("ic_user_black.svg");

  get ic_spot => icon("ic_spot.svg");

  get ic_logout_pass => icon("ic_logout_pass.svg");

  get ic_visitor_scan => icon("ic_visitor_scan.svg");

  get ic_accept => icon("ic_accept.svg");

  get ic_decline => icon("ic_decline.svg");

  get ic_freemium_user => icon("ic_freemium_user.svg");

  get ic_manage_project => icon("ic_manage_project.svg");

  get ic_manage_user => icon("ic_manage_user.svg");

  get ic_building_thumbnails => icon("ic_building_thumbnails.svg");

  get ic_add_new_project => icon("ic_add_new_project.svg");

  get ic_request_for_access => icon("ic_request_for_access.svg");

  get ic_request_sent => icon("ic_request_sent.svg");

  get ic_smiley => icon("ic_smiley.svg");

  get ic_edit_grey => icon("ic_edit_grey.svg");

  get ic_download_exel => icon("ic_download_exel.svg");

  get ic_download_pdf => icon("ic_download_pdf.svg");

  get ic_download_pdf_png => icon("ic_download_pdf.png");

  get ic_info_circle => icon("ic_info_circle.svg");

  get ic_info => icon("ic_info.svg");

  get ic_info_red => icon("ic_info_red.svg");

  get ic_call_support => icon("ic_call_support.svg");

  //get ic_whats_app => icon("ic_whats_app.svg");

  get ic_support_email => icon("ic_support_email.svg");

  get ic_thank_you_emoji => icon("ic_thank_you_emoji.png");

  get ic_whats_app => icon("ic_whats_app.png");

  get ic_induction_training => icon("ic_induction_training.svg");

  get ic_delete_grey => icon("ic_delete_grey.svg");

  get ic_add_image => icon("ic_add_image.svg");

  get ic_reassign => icon("ic_reassign.svg");

  get ic_face_scan => icon("ic_face_scan.svg");

  get ic_sync_project_data => icon("ic_sync_project_data.svg");
}
