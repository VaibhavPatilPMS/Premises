import 'package:flutter_simple_dependency_injection/injector.dart';

import '../../common/di/base_module.dart';
import 'device_test.dart';

class DeviceTestModule extends BaseModule {
  DeviceTestModule(Injector injector) : super(injector) {
    injector.map<DeviceTestProvider>((injector) => DeviceTestProvider());
  }
}
