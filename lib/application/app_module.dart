import 'package:premises/common/base/base.dart';
import 'package:premises/common/network/network.dart';

import '../common/di/base_module.dart';
import 'app.dart';
import 'app_router.dart';

class AppModule extends BaseModule {
  AppModule({injector, required bool isLoggedIn, required bool isConnected})
      : super(injector) {
    /// Application
    injector.map<AppRouter>((i) => AppRouter(isLoggedIn: isLoggedIn));
    injector.map<Application>(
      (i) => Application(inject<AppRouter>()),
    );
    injector.map<ApiClient>(
      (injector) => ApiClient(),
    );
    injector.map<NetworkInfoImpl>(
      (injector) => NetworkInfoImpl(isConnected: isConnected),
    );
  }
}
