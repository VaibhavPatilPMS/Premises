import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/di/base_module.dart';
import 'package:premises/ui/check_list/check_list.dart';
import 'package:premises/ui/offline_sync/provider.dart';

import '../attendence/attendance.dart';
import '../events_and_trainings/toolbox_trainings/toolbox_training.dart';
import '../induction_training/induction_training.dart';
import '../induction_training/induction_training.dart';
import '../safety_actionable/safety_actionable.dart';
import '../safety_actionable/use_cases.dart';
import '../safety_actionable/request_builder.dart';
import '../work_permit/work_permit.dart';

class OfflineSyncModule extends BaseModule {
  OfflineSyncModule(Injector injector) : super(injector) {
    injector.map<OfflineSyncProvider>(
      (injector) => OfflineSyncProvider(
        inject<GetOfflineWorkPermitsUseCase>(),
        inject<WorkPermitRequestBuilder>(),
        inject<PostWorkPermitUseCase>(),
        inject<GetOfflineInductionTrainingUseCase>(),
        inject<InductionTrainingRequestBuilder>(),
        inject<CreateInductionTrainingUseCase>(),
        inject<GetOfflineCreatedTBTUseCase>(),
        inject<ToolboxTrainingRequestBuilder>(),
        inject<CreateTBTUseCase>(),
        inject<DeleteOfflineWorkPermitsUseCase>(),
        inject<DeleteOfflineTBTUseCase>(),
        inject<DeleteOfflineInductionTrainingUseCase>(),
        inject<GetOfflineCreatedInAndOutUseCase>(),
        inject<DeleteOfflineCreatedInAndOutUseCase>(),
        inject<CaptureAttendanceUseCase>(),
        inject<AttendanceCaptureRequestBuilder>(),
        inject<CheckListRequestBuilder>(),
        inject<PostChecklistUseCase>(),
        inject<CommonRequestBuilder>(),
        inject<GetOfflineTaskUseCase>(),
        inject<CreateTaskUseCase>(),
        inject<GetOfflineSafetyObservationsUseCase>(),
        inject<DeleteOfflineSafetyObservationsUseCase>(),
        inject<SafetyObservationListRequestBuilder>(),
        inject<CreateSafetyObservationUseCase>(),
        inject<PostReassigneePeopleUseCase>(),
        inject<DeleteOfflineTaskUseCase>(),
      ),
    );
  }
}
