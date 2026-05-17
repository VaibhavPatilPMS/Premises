import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:premises/common/mapper/mapper.dart';
import 'package:premises/features/dashboard/di.dart';
import 'package:premises/features/device_test/device_test.dart';
import 'package:premises/features/offline_sync/di.dart';
import 'package:premises/application/app_module.dart';
import 'package:premises/features/user_management/user_management.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/widgets/widgets.dart';
import '../utils/utils.dart';

class Dependency {
  Dependency._internal();

  static final Dependency _container = Dependency._internal();

  factory Dependency() => _container;

  late Injector injector;

  T inject<T>() {
    return injector.get<T>();
  }

  void initialise({required bool isLoggedIn, required bool isConnected}) {
    injector = Injector();

    /// Utils
    injector.map<DateTimeUtil>((injector) => DateTimeUtil());
    injector.map<LocationUtils>((injector) => LocationUtils());

    injector.map<ChipStateManageProvider>(
      (injector) => ChipStateManageProvider(),
    );

    injector.map<CameraProvider>(
      (injector) => CameraProvider(),
    );

    injector.map<BaseProvider>(
      (injector) => BaseProvider(isNetworkConnected: isConnected),
    );

    injector.map<CommonResponseMapper>(
      (injector) => CommonResponseMapper(),
    );

    /// Application classes.
    AppModule(
        injector: injector, isLoggedIn: isLoggedIn, isConnected: isConnected);

    //UserManagement Module
    UserModule(injector);
    DashboardModule(injector);
    OfflineSyncModule(injector);
    DeviceTestModule(injector);
  }
}
