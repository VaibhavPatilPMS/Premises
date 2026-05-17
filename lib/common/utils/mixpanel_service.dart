import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:premises/common/resources/app_strings.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:premises/application/application.dart';

class MixpanelService {
  static final MixpanelService _mixpanelService = MixpanelService._internal();

  factory MixpanelService() => _mixpanelService;

  MixpanelService._internal();

  String anonymousId = Uuid().v4();

  Mixpanel? _mixpanel;

  Future<void> init({
    required String token,
    required SharedPreferencesUtils utils,
  }) async {
    try {
      //_appName = await AppVersionDetails.getAppInstalledName();
      //_appName = AppData().userDetailsUiModel?.clientName;
      if (AppData().isMixpanelSupported!) {
        _mixpanel = await Mixpanel.init(token, trackAutomaticEvents: false);
      } else {
        _mixpanel = null;
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void registerSuperProperties(Map<String, dynamic> properties) {
    try {
      if (_mixpanel != null) {
        _mixpanel!.registerSuperProperties(properties);
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void trackEvent({
    required String eventName,
    Map<String, dynamic>? properties,
  }) {
    try {
      if (_mixpanel != null) {
        final eventProperties = {
          'Name':
              "${AppData().userDetailsUiModel!.firstName} ${AppData().userDetailsUiModel?.lastName}",
          'userName': "${AppData().userDetailsUiModel!.username}",
          if (properties != null) ...properties,
        };
        _mixpanel!.track(eventName, properties: eventProperties);
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void loginSuccessEvent() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(
          AppStrings().login_done,
          properties: {
            AppStrings().page_name: AppStrings().login,
            AppStrings().login_status: AppStrings().logged_in,
          },
        );
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void logoutSuccessEvent() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(
          AppStrings().logout_done,
          properties: {
            AppStrings().page_name: AppStrings().dashboard_id,
            AppStrings().login_status: AppStrings().logged_out,
            AppStrings().page_sub_category: AppStrings().profile,
            AppStrings().button_label: AppStrings().logout,
          },
        );
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

    void safetyAppSupportClickEvent() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(AppStrings().support_url_clicked, properties: {
          AppStrings().page_name: AppStrings().dashboard_id,
          AppStrings().page_sub_category: AppStrings().profile,
          AppStrings().button_label: AppStrings().support,
        });
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void disableModuleClickEvent({required String moduleName}) {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(AppStrings().disable_module_clicked, properties: {
          AppStrings().page_name: AppStrings().dashboard_id,
          AppStrings().page_sub_category: AppStrings().dashboard_id,
          AppStrings().module_name: moduleName,
        });
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void exploreAppButtonClickEvent() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(
          AppStrings().explore_app_button_clicked,
          properties: {
            AppStrings().page_name: AppStrings().login,
            AppStrings().button_label: AppStrings().explore_app,
            AppStrings().page_sub_category: AppStrings().login,
            AppStrings().anonymous_id: anonymousId,
          },
        );
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void termsAndConditionViewedEvent() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(
          AppStrings().terms_and_conditions_viewed,
          properties: {
            AppStrings().page_name: AppStrings().login,
            AppStrings().button_label: AppStrings().explore_app,
            AppStrings().page_sub_category: AppStrings().terms_and_condition,
            AppStrings().anonymous_id: anonymousId,
          },
        );
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void privacyPolicyViewedEvent() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(
          AppStrings().privacy_policy_viewed,
          properties: {
            AppStrings().page_name: AppStrings().login,
            AppStrings().button_label: AppStrings().explore_app,
            AppStrings().page_sub_category: AppStrings().privacy_policy,
            AppStrings().anonymous_id: anonymousId,
          },
        );
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void pdfDownloadEvent({
    String? username,
    String? userrole,
    String? moduleName,
    String? recordId,
    String? projectId,
    String? platform,
  }) {
    try {
      if (_mixpanel != null) {
        _mixpanel!.track(
          AppStrings().mobile_pdf_download,
          properties: {
            AppStrings().username: username,
            AppStrings().lb_userrole: userrole,
            AppStrings().module_name: moduleName,
            'Record ID': recordId,
            'projectId': projectId,
            'platform': platform,
          },
        );
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void mixpanelReset() {
    try {
      if (_mixpanel != null) {
        _mixpanel!.reset();
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void registerPeopleProperties({
    required String firstname,
    lastname,
    userhash,
    user_id,
    email,
    mobilenumber,
    username,
  }) {
    try {
      if (_mixpanel != null) {
        _mixpanel!.identify(user_id);
        _mixpanel!.getPeople().set("First Name", firstname);
        _mixpanel!.getPeople().set("Last Name", lastname);
        _mixpanel!.getPeople().set("User Hash", userhash);
        _mixpanel!.getPeople().set("Email", email);
        _mixpanel!.getPeople().set("Mobile Number", mobilenumber);
        _mixpanel!.getPeople().set("Username", username);
      }
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void _handleError(dynamic error, StackTrace stackTrace) {
    CustomLogger.logPrint('Error occurred: $error');
    CustomLogger.logPrint('Stack trace:\n$stackTrace');
  }
}
