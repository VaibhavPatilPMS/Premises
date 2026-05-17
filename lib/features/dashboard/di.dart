import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/network/network.dart';
import 'package:premises/features/dashboard/dashboard.dart';
import 'package:premises/common/di/base_module.dart';

class DashboardModule extends BaseModule {
  DashboardModule(Injector injector) : super(injector) {
    injector.map<EntitlementsMapper>(
      (injector) => EntitlementsMapper(),
    );

    injector.map<GlobalConfigurationMapper>(
      (injector) => GlobalConfigurationMapper(),
    );

    injector.map<GetDashboardPendingCountsMapper>(
      (injector) => GetDashboardPendingCountsMapper(),
    );

    injector.map<GetUserProjectMapper>(
      (injector) => GetUserProjectMapper(),
    );

    injector.map<DashboardRepository>(
      (injector) => DashboardRepository(
        inject<ApiClient>(),
      ),
    );

    injector.map<ProjectEntitlementsUseCase>(
      (injector) => ProjectEntitlementsUseCase(
        inject<DashboardRepository>(),
        inject<EntitlementsMapper>(),
        inject<NetworkInfoImpl>(),
      ),
    );

    injector.map<GlobalConfigurationsUseCase>(
      (injector) => GlobalConfigurationsUseCase(
        inject<DashboardRepository>(),
        inject<GlobalConfigurationMapper>(),
        inject<NetworkInfoImpl>(),
      ),
    );

    injector.map<DashboardPendingCountUseCase>(
      (injector) => DashboardPendingCountUseCase(
        inject<DashboardRepository>(),
        inject<GetDashboardPendingCountsMapper>(),
        inject<NetworkInfoImpl>(),
      ),
    );

    injector.map<ProjectListUseCase>(
      (injector) => ProjectListUseCase(
        inject<DashboardRepository>(),
        inject<GetUserProjectMapper>(),
        inject<NetworkInfoImpl>(),
      ),
    );

    injector.map<CommonRequestBuilder>(
      (injector) => CommonRequestBuilder(),
    );

    injector.map<GeofencingRequestBuilder>(
      (injector) => GeofencingRequestBuilder(),
    );

    injector.map<GeofencingMapper>(
      (injector) => GeofencingMapper(),
    );

    injector.map<GeofancingUseCase>(
      (injector) => GeofancingUseCase(
        inject<DashboardRepository>(),
        inject<GeofencingMapper>(),
        inject<NetworkInfoImpl>(),
      ),
    );

    injector.map<DashboardProvider>(
      (injector) => DashboardProvider(
        inject<CommonRequestBuilder>(),
        inject<GeofencingRequestBuilder>(),
        inject<ProjectEntitlementsUseCase>(),
        inject<GlobalConfigurationsUseCase>(),
        inject<DashboardPendingCountUseCase>(),
        inject<GeofancingUseCase>(),
        inject<ProjectListUseCase>(),
      ),
    );
  }
}
