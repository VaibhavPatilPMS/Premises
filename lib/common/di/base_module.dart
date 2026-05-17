import 'package:flutter_simple_dependency_injection/injector.dart';

class BaseModule {
  Injector injector;

  T inject<T>() {
    return injector.get<T>();
  }

  BaseModule(this.injector);
}



