import 'user_management.dart';
import 'package:premises/common/di/base_module.dart';
import 'package:premises/common/network/network.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class UserModule extends BaseModule {
  UserModule(Injector injector) : super(injector) {
    /// User Management

    injector.map<UserLoginResponseMapper>(
      (injector) => UserLoginResponseMapper(),
    );

    injector.map<ChangePasswordResponseMapper>(
      (injector) => ChangePasswordResponseMapper(),
    );

    injector.map<UpdateProfileResponseMapper>(
      (injector) => UpdateProfileResponseMapper(),
    );

    injector.map<ForgetPasswordResponseMapper>(
      (injector) => ForgetPasswordResponseMapper(),
    );
    injector.map<GetEmergencyContactsResponseMapper>(
      (injector) => GetEmergencyContactsResponseMapper(),
    );
    injector.map<GetTrainingVideosResponseMapper>(
      (injector) => GetTrainingVideosResponseMapper(),
    );

    injector.map<UserManagementRepository>(
      (injector) => UserManagementRepository(
        inject<ApiClient>(),
      ),
    );

    injector.map<UserLoginUseCase>(
      (injector) => UserLoginUseCase(
        inject<UserManagementRepository>(),
        inject<UserLoginResponseMapper>(),
      ),
    );

    injector.map<ForgetPasswordUseCase>(
      (injector) => ForgetPasswordUseCase(
        inject<UserManagementRepository>(),
        inject<ForgetPasswordResponseMapper>(),
      ),
    );

    injector.map<ChangePasswordUseCase>(
      (injector) => ChangePasswordUseCase(
        inject<UserManagementRepository>(),
        inject<ChangePasswordResponseMapper>(),
      ),
    );

    injector.map<UpdateProfileUseCase>(
      (injector) => UpdateProfileUseCase(
        inject<UserManagementRepository>(),
        inject<UpdateProfileResponseMapper>(),
      ),
    );
    injector.map<UserManagementRequestBuilder>(
      (injector) => UserManagementRequestBuilder(),
    );

    injector.map<UserManagementProvider>((injector) => UserManagementProvider(
        inject<UserLoginUseCase>(),
        inject<UserManagementRequestBuilder>(),
        inject<ForgetPasswordUseCase>(),
        inject<ChangePasswordUseCase>(),
        inject<UpdateProfileUseCase>()
      ));
  }
}
