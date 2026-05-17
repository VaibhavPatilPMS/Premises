import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:premises/common/utils/app_constants.dart';

class Environment {
  static String? getEnvironment(int environment) {
    switch (environment) {
      case AppEnvironments.APP_DEVELOPMENT:
        return '.env.development';

      case AppEnvironments.APP_QA:
        return '.env.qa';

      case AppEnvironments.APP_UAT:
        return '.env.uat';

      case AppEnvironments.APP_PRODUCTION:
        return '.env.production';
    }
    return null;
  }

  static String get baseUrl => dotenv.env['BASE_URL']!;

  static String get environmentName => dotenv.env['ENV_NAME']!;

  static String get IS_FORCE_UPDATE_ALLOW =>
      dotenv.env['IS_FORCE_UPDATE_ALLOW']!;

  static String get IS_CRASHLYTICS_ALLOW => dotenv.env['IS_CRASHLYTICS_ALLOW']!;

  static String get MIXPANEL_PROJECT_TOKEN =>
      dotenv.env['MIXPANEL_PROJECT_TOKEN']!;

  static String get IS_MIXPANEL_ALLOW => dotenv.env['IS_MIXPANEL_ALLOW']!;
}
