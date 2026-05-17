import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safety_app/common/base/base.dart';
import 'package:safety_app/ui/check_list/check_list.dart';

import '../../application/application.dart';
import '../../common/common_models/common_models.dart';
import '../../common/custom_widgets/custom_widgets.dart';
import '../../common/resources/resources.dart';
import '../../common/utils/utils.dart';
import '../attendence/attendance.dart';
import '../events_and_trainings/toolbox_trainings/toolbox_training.dart'
    hide WorkPermitDetailsUiModel;
import '../induction_training/induction_training.dart';
import '../safety_actionable/safety_actionable.dart';
import '../work_permit/work_permit.dart';

class OfflineSyncProvider extends BaseProvider {
  final GetOfflineWorkPermitsUseCase? _getOfflineWorkPermitsUseCase;
  final WorkPermitRequestBuilder? _workPermitRequestBuilder;
  final PostWorkPermitUseCase _postWorkPermitUseCase;

  final GetOfflineInductionTrainingUseCase? _getOfflineInductionTrainingUseCase;
  final InductionTrainingRequestBuilder? _inductionTrainingRequestBuilder;
  final CreateInductionTrainingUseCase? _createInductionTrainingUseCase;

  final GetOfflineCreatedTBTUseCase? _getOfflineCreatedTBTUseCase;
  final ToolboxTrainingRequestBuilder? _toolboxTrainingRequestBuilder;
  final CreateTBTUseCase? _createTBTUseCase;

  final CheckListRequestBuilder? _checklistRequestBuilder;

  final PostChecklistUseCase? _postChecklistUseCase;
  final CommonRequestBuilder? _commonRequestBuilder;
  final GetOfflineTaskUseCase? _getOfflineTaskUseCase;
  final DeleteOfflineTaskUseCase? _getDeleteOfflineTaskUseCase;
  // final CheckListRequestBuilder? _requestBuilder;
  List<ChecklistDetailRequestModel>? offlineChecklistDetailRequestModelList;
  List<CreateTaskModel>? off;

  List<CreateWorkPermitRequestModel>? offlineWorkPermitsList = [];
  List<CreateTaskModel>? offlineTaskList = [];
  List<CreateInductionTrainingModel>? offlineInductionTrainings = [];
  List<CreateToolboxTrainingModel>? offlineTBTS = [];
  List<CheckListsUiModel>? offlineChecklistList = [];
  bool? isLoading;
  bool? isSelectAll = false;

  final DeleteOfflineWorkPermitsUseCase? _deleteOfflineWorkPermitsUseCase;
  final DeleteOfflineTBTUseCase? _deleteOfflineTBTUseCase;
  final DeleteOfflineInductionTrainingUseCase?
  _deleteOfflineInductionTrainingUseCase;

  final AttendanceCaptureRequestBuilder?
  _offlineCaptureAttendanceRequestBuilder;
  final CaptureAttendanceUseCase? _captureAttendanceUseCase;
  final GetOfflineCreatedInAndOutUseCase? _getOfflineCreatedInAndOutUseCase;
  final DeleteOfflineCreatedInAndOutUseCase?
  _deleteOfflineCreatedInAndOutUseCase;

  List<AttendanceCaptureRequestModel>? offlineCreatedInAndOutsList = [];
  List<AttendanceCaptureRequestModel>? offlineDisplayCreatedInAndOutsList = [];

  final GetOfflineSafetyObservationsUseCase?
  _getOfflineSafetyObservationsUseCase;
  final DeleteOfflineSafetyObservationsUseCase?
  _deleteOfflineSafetyObservationsUseCase;
  final SafetyObservationListRequestBuilder?
  _safetyObservationListRequestBuilder;
  final CreateSafetyObservationUseCase? _createSafetyObservationUseCase;
  final PostReassigneePeopleUseCase? _postReassigneePeopleUseCase;

  List<CreateSafetyObservationModel>? offlineSafetyObservationsList = [];
  bool _autoSyncInProgress = false;

  final CreateTaskUseCase? _createTaskUseCase;
  OfflineSyncProvider(
    this._getOfflineWorkPermitsUseCase,
    this._workPermitRequestBuilder,
    this._postWorkPermitUseCase,
    this._getOfflineInductionTrainingUseCase,
    this._inductionTrainingRequestBuilder,
    this._createInductionTrainingUseCase,
    this._getOfflineCreatedTBTUseCase,
    this._toolboxTrainingRequestBuilder,
    this._createTBTUseCase,
    this._deleteOfflineWorkPermitsUseCase,
    this._deleteOfflineTBTUseCase,
    this._deleteOfflineInductionTrainingUseCase,
    this._getOfflineCreatedInAndOutUseCase,
    this._deleteOfflineCreatedInAndOutUseCase,
    this._captureAttendanceUseCase,
    this._offlineCaptureAttendanceRequestBuilder,
    this._checklistRequestBuilder,
    this._postChecklistUseCase,
    this._commonRequestBuilder,
    this._getOfflineTaskUseCase,
    this._createTaskUseCase,
    this._getOfflineSafetyObservationsUseCase,
    this._deleteOfflineSafetyObservationsUseCase,
    this._safetyObservationListRequestBuilder,
    this._createSafetyObservationUseCase,
    this._postReassigneePeopleUseCase,
    this._getDeleteOfflineTaskUseCase,
  ) : super() {
    isLoading = true;
  }

  Future<void> autoSyncOfflineSafetyObservations() async {
    if (_autoSyncInProgress) return;
    _autoSyncInProgress = true;
    try {
      await getOfflineSafetyObservations(context: null, isNotify: false);
      final allItems = offlineSafetyObservationsList ?? [];
      final resolvedStatuses = <String>{
        VSAStatusConstants.STATUS_RESOLVED,
        VSAStatusConstants.STATUS_COMPLETED,
        VSAStatusConstants.STATUS_CLOSED,
        VSAStatusConstants.STATUS_REASSIGNED,
        VSAStatusConstants.STATUS_REOPEN,
      }.map((e) => e.toLowerCase()).toSet();
      final items = allItems
          .where((e) => e.uuid != null && e.uuid!.startsWith('server_action_'))
          .where(
            (e) => resolvedStatuses.contains((e.status ?? '').toLowerCase()),
          )
          .toList();
      CustomLogger.logPrint('Auto sync SA: eligible=${items.length}');
      if (items.isNotEmpty) {
        syncOfflineSafetyObservations(
          context: null,
          itemsOverride: items,
          showSuccess: false,
        );
      }
    } catch (e) {
      CustomLogger.logPrint('Auto sync SA failed: $e');
    } finally {
      _autoSyncInProgress = false;
    }
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void getOfflineWorkPermits({BuildContext? context, bool? isNotify}) async {
    setLoading(true);
    offlineWorkPermitsList!.clear();
    if (isNotify!) notifyListeners();

    RequestModel<WorkPermitListRequestModel> requestModel =
        await _workPermitRequestBuilder!.getWorkpermitList(
          limit: PageLimit.LIMIT,
          skip: 0,
          isAllTab: false,
          isMaker: false,
          isChecker: false,
          isAuditor: false,
        );

    ResponseModel<List<CreateWorkPermitRequestModel>> response =
        await _getOfflineWorkPermitsUseCase!.execute(request: requestModel);

    if (response.isSuccess!) {
      if (response.data != null) {
        offlineWorkPermitsList = response.data!;
        for (var element in offlineWorkPermitsList!) {
          element.isCheck = false;
        }
      } else {
        offlineWorkPermitsList = [];
      }
      //CustomLogger.logPrint('offline work permits ${response.data!.length}');
    } else {
      offlineWorkPermitsList = [];
    }
    setLoading(false);
    notifyListeners();
  }

  void getOfflineInductionTrainings({
    BuildContext? context,
    bool? isNotify,
  }) async {
    setLoading(true);
    offlineInductionTrainings!.clear();
    if (isNotify!) notifyListeners();

    RequestModel<InductionTrainingRequestModel> requestModel =
        await _inductionTrainingRequestBuilder!
            .getInductionTrainingListRequestModel(
              limit: PageLimit.LIMIT,
              skip: 0,
            );

    ResponseModel<List<CreateInductionTrainingModel>> response =
        await _getOfflineInductionTrainingUseCase!.execute(
          request: requestModel,
        );

    if (response.isSuccess!) {
      if (response.data != null) {
        offlineInductionTrainings = response.data!;
        for (var element in offlineInductionTrainings!) {
          element.isCheck = false;
        }
      } else {
        offlineInductionTrainings = [];
      }
      //CustomLogger.logPrint('offline induction trainings ${response.data!.length}');
    } else {
      offlineInductionTrainings = [];
    }

    setLoading(false);
    notifyListeners();
  }

  void getOfflineTbts({BuildContext? context, bool? isNotify}) async {
    setLoading(true);
    offlineTBTS!.clear();
    if (isNotify!) notifyListeners();

    RequestModel<ToolboxTrainingRequestModel> requestModel =
        await _toolboxTrainingRequestBuilder!
            .getToolboxTrainingListRequestModel(
              limit: PageLimit.LIMIT,
              skip: 0,
            );

    ResponseModel<List<CreateToolboxTrainingModel>> response =
        await _getOfflineCreatedTBTUseCase!.execute(request: requestModel);

    if (response.isSuccess!) {
      //CustomLogger.logPrint('offline tbts ${response.data!.length}');
      if (response.data != null) {
        offlineTBTS = response.data!;
        for (var element in offlineTBTS!) {
          element.isCheck = false;
        }
      }
    } else {
      offlineTBTS = [];
      // AppStrings()
      //     .no_offline_tbt
      //     .showAsToast(context: context!, type: ToastType.TOAST_ERROR);
    }

    setLoading(false);
    notifyListeners();
  }

  Future<void> getOfflineSafetyObservations({
    BuildContext? context,
    bool? isNotify,
  }) async {
    setLoading(true);
    offlineSafetyObservationsList!.clear();
    if (isNotify!) notifyListeners();

    RequestModel<SafetyObservationListRequestModel> requestModel =
        await _safetyObservationListRequestBuilder!
            .getSafetyObservationListRequestModel(
              limit: PageLimit.LIMIT,
              skip: 0,
            );

    ResponseModel<List<CreateSafetyObservationModel>> response =
        await _getOfflineSafetyObservationsUseCase!.execute(
          request: requestModel,
        );

    if (response.isSuccess!) {
      if (response.data != null) {
        offlineSafetyObservationsList = response.data!;
        for (var element in offlineSafetyObservationsList!) {
          element.isCheck = false;
        }
      } else {
        offlineSafetyObservationsList = [];
      }
    } else {
      offlineSafetyObservationsList = [];
    }
    setLoading(false);
    notifyListeners();
  }

  List<CreateSafetyObservationModel> getPendingSaRequestItems() {
    return (offlineSafetyObservationsList ?? [])
        .where(
          (element) =>
              element.uuid != null &&
              element.uuid!.startsWith('server_action_'),
        )
        .toList();
  }

  getOfflineChecklist({BuildContext? context}) async {
    offlineChecklistList!.clear();
    offlineChecklistDetailRequestModelList =
        await HiveChecklistService.getSubmittedOfflineChecklists(
          AppData().userCurrentSelectedProject!.projectCode,
        );
    for (var element in offlineChecklistDetailRequestModelList!) {
      element.checkListsUiModel!.isCheck = false;
      if (element.projectCode ==
          AppData().userCurrentSelectedProject!.projectCode) {
        offlineChecklistList!.add(element.checkListsUiModel!);
      }
    }
    setLoading(false);
    notifyListeners();
  }

  int? convertToInt(Color? color) {
    return color!.value;
  }

  void syncOfflineChecklist({BuildContext? context}) async {
    try {
      setLoading(true);
      notifyListeners();

      ResponseModel<ChecklistDetailUiModel>? response;
      for (int i = 0; i < offlineChecklistList!.length; i++) {
        if (offlineChecklistList![i].isCheck!) {
          RequestModel<PostChecklistRequestModel> requestModel =
              await _checklistRequestBuilder!.postChecklistRequestModel(
                checklistDetailRequestModel:
                    offlineChecklistDetailRequestModelList![i],
                isSubmitChecklist:
                    offlineChecklistDetailRequestModelList![i]
                        .answerSheetStatus ==
                    'COMPLETED',
                checklistDetailDataUiModel:
                    offlineChecklistDetailRequestModelList![i]
                        .checklistDetailDataUiModel!,
                checklistAction: false,
              );

          response = await _postChecklistUseCase!.execute(
            request: requestModel,
          );

          CheckListUiModel? checkListUiModelHive =
              await HiveChecklistService.getChecklist(
                requestModel.model.projectCode,
              );

          if (response.isSuccess!) {
            List<CreateTaskModel>? selectedOfflineTask = [];
            if (offlineTaskList!.isNotEmpty) {
              selectedOfflineTask = offlineTaskList!
                  .where(
                    (element) =>
                        element.checklistId ==
                        offlineChecklistList![i].checklistId!,
                  )
                  .toList();
            }
            if (selectedOfflineTask.isNotEmpty) {
              for (int i = 0; i < selectedOfflineTask.length; i++) {
                var element = selectedOfflineTask[i];

                RequestModel<CreateTaskRequestModel> requestModel =
                    await _checklistRequestBuilder.getCreateTaskRequestModel(
                      isOffline: true,
                      createTaskModel: element,
                    );

                ResponseModel<CommonResponseUiModel> response =
                    await _createTaskUseCase!.execute(request: requestModel);
                if (response.isSuccess!) {
                  //CustomLogger.logPrint('Sync Offline Attendance ${element.uuid}');

                  RequestModel<OfflineTaskListRequestModel> requestModel =
                      await _checklistRequestBuilder.getOfflineTaskList(
                        uuid: element.uuid,
                      );

                  ResponseModel<List<CreateTaskModel>> response =
                      await _getDeleteOfflineTaskUseCase!.execute(
                        request: requestModel,
                      );
                } else {
                  //CustomLogger.logPrint('Failed Attendance Sync ${element.uuid}');
                  AppStrings().oflfine_sync_error.showAsToast(
                    context: context!,
                    type: ToastType.TOAST_ERROR,
                  );
                  break;
                }
              }
            }

            await HiveChecklistService.deleteOfflineChecklistById(
              offlineChecklistList![i].sId,
            );

            if (offlineChecklistDetailRequestModelList![i].answerSheetStatus ==
                'COMPLETED') {
              int index = -1;
              if (checkListUiModelHive != null) {
                index = checkListUiModelHive.data!.indexWhere(
                  (element) =>
                      element.sId ==
                      offlineChecklistDetailRequestModelList![i]
                          .checkListsUiModel!
                          .sId,
                );
              }
              if (index != -1 && checkListUiModelHive != null) {
                checkListUiModelHive.data!.removeAt(index);
                HiveChecklistService.putChecklist(
                  requestModel.model.projectCode,
                  checkListUiModelHive,
                );
                HiveChecklistService.removeChecklistDetail(
                  offlineChecklistDetailRequestModelList![i]
                      .checkListsUiModel!
                      .sId,
                );
              }
            }
          } else if (response.statusCode == 409) {
            await HiveChecklistService.deleteOfflineChecklistById(
              offlineChecklistList![i].sId,
            );
            int index = -1;
            if (checkListUiModelHive != null) {
              index = checkListUiModelHive.data!.indexWhere(
                (element) =>
                    element.sId ==
                    offlineChecklistDetailRequestModelList![i]
                        .checkListsUiModel!
                        .sId,
              );
            }
            if (index != -1 && checkListUiModelHive != null) {
              checkListUiModelHive.data!.removeAt(index);
              notifyListeners();
              HiveChecklistService.putChecklist(
                requestModel.model.projectCode,
                checkListUiModelHive,
              );
              HiveChecklistService.removeChecklistDetail(
                offlineChecklistDetailRequestModelList![i]
                    .checkListsUiModel!
                    .sId,
              );
              await getOfflineChecklist();
            }
          }
        }
      }
      if (response != null && response.isSuccess!) {
        _navigateToSuccessScreen(context);
      } else {
        //getOfflineChecklist();
        //CustomLogger.logPrint('status code ${response!.statusCode}');
        response!.message != null
            ? response.message!.showAsToast(
                context: context!,
                type: ToastType.TOAST_ERROR,
              )
            : AppStrings().oflfine_sync_error.showAsToast(
                context: context!,
                type: ToastType.TOAST_ERROR,
              );
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  void syncOfflineInductionTrainings({BuildContext? context}) async {
    try {
      setLoading(true);
      notifyListeners();

      List<CreateInductionTrainingModel>?
      selectedOfflineInductionTrainingsForSync = offlineInductionTrainings!
          .where((element) => element.isCheck!)
          .toList();

      if (selectedOfflineInductionTrainingsForSync.isNotEmpty) {
        for (
          int i = 0;
          i < selectedOfflineInductionTrainingsForSync.length;
          i++
        ) {
          var element = selectedOfflineInductionTrainingsForSync[i];
          RequestModel<CreateInductionTrainingRequestModel> requestModel =
              await _inductionTrainingRequestBuilder!
                  .getInductionTrainingRequestModel(
                    createInductionTrainingModel: element,
                  );

          ResponseModel<CommonResponseUiModel> response =
              await _createInductionTrainingUseCase!.execute(
                request: requestModel,
              );

          if (response.isSuccess!) {
            //CustomLogger.logPrint('Sync Induction Trainings Sync ${element.uuid}');
            MixpanelService().trackEvent(
              eventName: AppStrings().inductionTrainingCreated,
              properties: {'category': element.categoryDetails?.categoryName},
            );
            RequestModel<InductionTrainingRequestModel> requestModel =
                await _inductionTrainingRequestBuilder
                    .getInductionTrainingListRequestModel(
                      limit: PageLimit.LIMIT,
                      skip: 0,
                      uuid: element.uuid,
                    );

            ResponseModel<List<CreateInductionTrainingModel>>
            deleteOfflineSyncInductions =
                await _deleteOfflineInductionTrainingUseCase!.execute(
                  request: requestModel,
                );
            if (deleteOfflineSyncInductions.isSuccess!) {
              if (deleteOfflineSyncInductions.data != null) {
                offlineInductionTrainings!.clear();
                offlineInductionTrainings = deleteOfflineSyncInductions.data!;
                //CustomLogger.logPrint('Deleted Induction ID  ${element.uuid}');
                if (selectedOfflineInductionTrainingsForSync.length !=
                        offlineInductionTrainings!.length ||
                    selectedOfflineInductionTrainingsForSync.length ==
                        offlineInductionTrainings!.length) {
                  if (i ==
                      selectedOfflineInductionTrainingsForSync.length - 1) {
                    //CustomLogger.logPrint('Partial data Deleted inductions ${element.uuid}');
                    _navigateToSuccessScreen(context);
                  }
                }
              } else {
                //CustomLogger.logPrint('Delete Work Permit Failed ${element.uuid}');
              }
            } else {
              //CustomLogger.logPrint('All Data Deleted Induction Trainings ${element.uuid}');
              _navigateToSuccessScreen(context);
            }
          } else {
            //CustomLogger.logPrint('Failed Induction Trainings Sync ${element.uuid}');
            if (response.message != null &&
                response.message!.toLowerCase() ==
                    'This record is already exists.'.toLowerCase()) {
              MixpanelService().trackEvent(
                eventName: AppStrings().inductionTrainingCreated,
                properties: {'category': element.categoryDetails?.categoryName},
              );
              RequestModel<InductionTrainingRequestModel> requestModel =
                  await _inductionTrainingRequestBuilder
                      .getInductionTrainingListRequestModel(
                        limit: PageLimit.LIMIT,
                        skip: 0,
                        uuid: element.uuid,
                      );

              ResponseModel<List<CreateInductionTrainingModel>>
              deleteOfflineSyncInductions =
                  await _deleteOfflineInductionTrainingUseCase!.execute(
                    request: requestModel,
                  );
              if (deleteOfflineSyncInductions.isSuccess!) {
                if (deleteOfflineSyncInductions.data != null) {
                  offlineInductionTrainings!.clear();
                  offlineInductionTrainings = deleteOfflineSyncInductions.data!;
                  //CustomLogger.logPrint('Deleted Induction ID  ${element.uuid}');
                  if (selectedOfflineInductionTrainingsForSync.length !=
                          offlineInductionTrainings!.length ||
                      selectedOfflineInductionTrainingsForSync.length ==
                          offlineInductionTrainings!.length) {
                    if (i ==
                        selectedOfflineInductionTrainingsForSync.length - 1) {
                      //CustomLogger.logPrint('Partial data Deleted inductions ${element.uuid}');
                      _navigateToSuccessScreen(context);
                    }
                  }
                } else {
                  //CustomLogger.logPrint('Delete Work Permit Failed ${element.uuid}');
                }
              } else {
                //CustomLogger.logPrint('All Data Deleted Induction Trainings ${element.uuid}');
                _navigateToSuccessScreen(context);
              }
            } else {
              setLoading(false);
              notifyListeners();
              AppStrings().oflfine_sync_error.showAsToast(
                context: context!,
                type: ToastType.TOAST_ERROR,
              );
              break;
            }
          }
        }
        //setLoading(false);
        //notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  void syncOfflineTbts({BuildContext? context}) async {
    try {
      setLoading(true);
      notifyListeners();

      List<CreateToolboxTrainingModel>? selectedOfflineTbts = offlineTBTS!
          .where((element) => element.isCheck!)
          .toList();

      if (selectedOfflineTbts.isNotEmpty) {
        for (int i = 0; i < selectedOfflineTbts.length; i++) {
          var element = selectedOfflineTbts[i];
          RequestModel<CreateToolboxTrainingRequestModel> requestModel =
              await _toolboxTrainingRequestBuilder!.getCreateTBTRequestModel(
                createToolboxTrainingModel: element,
              );

          ResponseModel<CommonResponseUiModel> response =
              await _createTBTUseCase!.execute(request: requestModel);

          if (response.isSuccess!) {
            MixpanelService().trackEvent(
              eventName: AppStrings().toolBoxTrainingsCreated,
            );
            //CustomLogger.logPrint('Sync Offline TBT ${element.uuid}');
            RequestModel<ToolboxTrainingRequestModel> requestModel =
                await _toolboxTrainingRequestBuilder
                    .getToolboxTrainingListRequestModel(
                      limit: PageLimit.LIMIT,
                      skip: 0,
                      uuid: element.uuid,
                    );

            ResponseModel<List<CreateToolboxTrainingModel>>
            deletedOfflineTbtsResponse = await _deleteOfflineTBTUseCase!
                .execute(request: requestModel);
            if (deletedOfflineTbtsResponse.isSuccess!) {
              if (deletedOfflineTbtsResponse.data != null) {
                offlineTBTS!.clear();
                offlineTBTS = deletedOfflineTbtsResponse.data!;
                //CustomLogger.logPrint('Deleted TBT Data ${element.uuid}');
                if (selectedOfflineTbts.length != offlineTBTS!.length ||
                    selectedOfflineTbts.length == offlineTBTS!.length) {
                  if (i == selectedOfflineTbts.length - 1) {
                    //CustomLogger.logPrint('Partial data Deleted TBT ${element.uuid}');
                    _navigateToSuccessScreen(context);
                  }
                }
              } else {
                //CustomLogger.logPrint('Delete TBT Failed ${element.uuid}');
              }
            } else {
              //CustomLogger.logPrint('All Data Deleted TBT ${element.uuid}');
              _navigateToSuccessScreen(context);
            }
          } else {
            if (response.message != null &&
                response.message!.toLowerCase() ==
                    'This record is already exists.'.toLowerCase()) {
              MixpanelService().trackEvent(
                eventName: AppStrings().toolBoxTrainingsCreated,
              );
              RequestModel<ToolboxTrainingRequestModel> requestModel =
                  await _toolboxTrainingRequestBuilder
                      .getToolboxTrainingListRequestModel(
                        limit: PageLimit.LIMIT,
                        skip: 0,
                        uuid: element.uuid,
                      );

              ResponseModel<List<CreateToolboxTrainingModel>>
              deletedOfflineTbtsResponse = await _deleteOfflineTBTUseCase!
                  .execute(request: requestModel);
              if (deletedOfflineTbtsResponse.isSuccess!) {
                if (deletedOfflineTbtsResponse.data != null) {
                  offlineTBTS!.clear();
                  offlineTBTS = deletedOfflineTbtsResponse.data!;
                  //CustomLogger.logPrint('Deleted TBT Data ${element.uuid}');
                  if (selectedOfflineTbts.length != offlineTBTS!.length ||
                      selectedOfflineTbts.length == offlineTBTS!.length) {
                    if (i == selectedOfflineTbts.length - 1) {
                      //CustomLogger.logPrint('Partial data Deleted TBT ${element.uuid}');
                      _navigateToSuccessScreen(context);
                    }
                  }
                } else {
                  //CustomLogger.logPrint('Delete TBT Failed ${element.uuid}');
                }
              } else {
                //CustomLogger.logPrint('All Data Deleted TBT ${element.uuid}');
                _navigateToSuccessScreen(context);
              }
            } else {
              //CustomLogger.logPrint('Failed TBT Sync ${element.uuid}');
              setLoading(false);
              notifyListeners();
              AppStrings().oflfine_sync_error.showAsToast(
                context: context!,
                type: ToastType.TOAST_ERROR,
              );
              break;
            }
          }
        }
        //setLoading(false);
        //notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  void syncOfflineWorkPermits({BuildContext? context}) async {
    try {
      setLoading(true);
      notifyListeners();

      List<CreateWorkPermitRequestModel>? selectedOfflineWorkPermits =
          offlineWorkPermitsList!.where((element) => element.isCheck!).toList();

      if (selectedOfflineWorkPermits.isNotEmpty) {
        for (int i = 0; i < selectedOfflineWorkPermits.length; i++) {
          var element = selectedOfflineWorkPermits[i];
          RequestModel<PostWorkPermitRequestModel> requestModel =
              await _workPermitRequestBuilder!.createWorkPermitRequestModel(
                workPermitRequestModel: element,
              );

          ResponseModel<WorkPermitDetailsUiModel> response =
              await _postWorkPermitUseCase.execute(request: requestModel);
          if (response.isSuccess!) {
            MixpanelService().trackEvent(
              eventName: AppStrings().workPermitsCreated,
              properties: {
                'workpermitCode': response.data?.data?.workpermitCode,
                'workStartDatetime': response.data?.data?.workStartDatetime,
                'workEndDatetime': response.data?.data?.workEndDatetime,
              },
            );
            //CustomLogger.logPrint('Sync Offline Work Permit ${element.uuid}');
            RequestModel<WorkPermitListRequestModel> requestModel =
                await _workPermitRequestBuilder.getWorkpermitList(
                  limit: PageLimit.LIMIT,
                  skip: 0,
                  isAllTab: false,
                  isMaker: false,
                  isChecker: false,
                  uuid: element.uuid,
                  isAuditor: false,
                );

            ResponseModel<List<CreateWorkPermitRequestModel>>
            deletedOfflineWorkPermitsResponse =
                await _deleteOfflineWorkPermitsUseCase!.execute(
                  request: requestModel,
                );

            if (deletedOfflineWorkPermitsResponse.isSuccess!) {
              if (deletedOfflineWorkPermitsResponse.data != null) {
                offlineWorkPermitsList!.clear();
                offlineWorkPermitsList =
                    deletedOfflineWorkPermitsResponse.data!;
                //CustomLogger.logPrint('Deleted Work Permit ${element.uuid}');
                if (selectedOfflineWorkPermits.length !=
                        offlineWorkPermitsList!.length ||
                    selectedOfflineWorkPermits.length ==
                        offlineWorkPermitsList!.length) {
                  if (i == selectedOfflineWorkPermits.length - 1) {
                    //CustomLogger.logPrint('Partial data Deleted Work Permit ${element.uuid}');
                    _navigateToSuccessScreen(context);
                  }
                }
              } else {
                //CustomLogger.logPrint('Delete Work Permit Failed ${element.uuid}');
              }
            } else {
              //CustomLogger.logPrint('All Data Deleted Work Permit ${element.uuid}');
              _navigateToSuccessScreen(context);
            }
          } else {
            //CustomLogger.logPrint('Failed Work Permit Sync ${element.uuid}');
            if (response.message != null &&
                response.message!.toLowerCase() ==
                    'This record is already exists.'.toLowerCase()) {
              MixpanelService().trackEvent(
                eventName: AppStrings().workPermitsCreated,
                properties: {
                  'workpermitCode': response.data?.data?.workpermitCode,
                  'workStartDatetime': response.data?.data?.workStartDatetime,
                  'workEndDatetime': response.data?.data?.workEndDatetime,
                },
              );
              RequestModel<WorkPermitListRequestModel> requestModel =
                  await _workPermitRequestBuilder.getWorkpermitList(
                    limit: PageLimit.LIMIT,
                    skip: 0,
                    isAllTab: false,
                    isMaker: false,
                    isChecker: false,
                    uuid: element.uuid,
                    isAuditor: false,
                  );

              ResponseModel<List<CreateWorkPermitRequestModel>>
              deletedOfflineWorkPermitsResponse =
                  await _deleteOfflineWorkPermitsUseCase!.execute(
                    request: requestModel,
                  );

              if (deletedOfflineWorkPermitsResponse.isSuccess!) {
                if (deletedOfflineWorkPermitsResponse.data != null) {
                  offlineWorkPermitsList!.clear();
                  offlineWorkPermitsList =
                      deletedOfflineWorkPermitsResponse.data!;
                  //CustomLogger.logPrint('Deleted Work Permit ${element.uuid}');
                  if (selectedOfflineWorkPermits.length !=
                          offlineWorkPermitsList!.length ||
                      selectedOfflineWorkPermits.length ==
                          offlineWorkPermitsList!.length) {
                    if (i == selectedOfflineWorkPermits.length - 1) {
                      //CustomLogger.logPrint('Partial data Deleted Work Permit ${element.uuid}');
                      _navigateToSuccessScreen(context);
                    }
                  }
                } else {
                  //CustomLogger.logPrint('Delete Work Permit Failed ${element.uuid}');
                }
              } else {
                //CustomLogger.logPrint('All Data Deleted Work Permit ${element.uuid}');
                _navigateToSuccessScreen(context);
              }
            } else {
              AppStrings().oflfine_sync_error.showAsToast(
                context: context!,
                type: ToastType.TOAST_ERROR,
              );
              setLoading(false);
              notifyListeners();
              break;
            }
          }
        }
      }
      //setLoading(false);
      //notifyListeners();
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  void syncOfflineAttendanceCaptured({
    BuildContext? context,
    String? source,
  }) async {
    setLoading(true);
    notifyListeners();

    List<AttendanceCaptureRequestModel>? selectedOfflineAttendanceCapture = [];
    selectedOfflineAttendanceCapture.addAll(offlineCreatedInAndOutsList!);
    try {
      if (selectedOfflineAttendanceCapture.isNotEmpty) {
        for (int i = 0; i < selectedOfflineAttendanceCapture.length; i++) {
          var element = selectedOfflineAttendanceCapture[i];

          RequestModel<AttendanceCaptureRequestModel> requestModel =
              await _offlineCaptureAttendanceRequestBuilder!
                  .getOfflineSyncCapturedAttendanceRequestModel(
                    requestModel: element,
                  );

          ResponseModel<CommonResponseUiModel> response =
              await _captureAttendanceUseCase!.execute(request: requestModel);
          if (response.isSuccess!) {
            //CustomLogger.logPrint('Sync Offline Attendance ${element.uuid}');
            ResponseModel<List<AttendanceCaptureRequestModel>>
            deletedOflfineSyncCapturedInAndOutResponse =
                await _deleteOfflineCreatedInAndOutUseCase!.execute(
                  request: requestModel,
                );

            if (deletedOflfineSyncCapturedInAndOutResponse.isSuccess!) {
              if (deletedOflfineSyncCapturedInAndOutResponse.data != null) {
                offlineCreatedInAndOutsList!.clear();
                offlineDisplayCreatedInAndOutsList!.clear();
                offlineCreatedInAndOutsList =
                    deletedOflfineSyncCapturedInAndOutResponse.data!;
                offlineDisplayCreatedInAndOutsList =
                    deletedOflfineSyncCapturedInAndOutResponse.data!;

                //CustomLogger.logPrint('Deleted Offline Created Attendance ${element.uuid}');
                if (selectedOfflineAttendanceCapture.length !=
                        offlineWorkPermitsList!.length ||
                    selectedOfflineAttendanceCapture.length ==
                        offlineWorkPermitsList!.length) {
                  if (i == selectedOfflineAttendanceCapture.length - 1) {
                    await getAllCapturedAttendanceData(
                      context: context,
                      isNotify: true,
                    );
                    //CustomLogger.logPrint('Partial data Deleted Attendance ${element.uuid}');
                    _navigateToSuccessScreen(context, source: source);
                  }
                }
              } else {
                //CustomLogger.logPrint('Delete Attendance Failed ${element.uuid}');
              }
            } else {
              //CustomLogger.logPrint('All Data Deleted Attendance ${element.uuid}');
              _navigateToSuccessScreen(context, source: source);
            }
          } else {
            //CustomLogger.logPrint('Failed Attendance Sync ${element.uuid}');
            setLoading(false);
            notifyListeners();
            if (response.message != null) {
              response.message?.showAsToast(
                context: context ?? navigatorKey.currentState!.context,
                type: ToastType.TOAST_ERROR,
              );
            } else {
              AppStrings().oflfine_sync_error.showAsToast(
                context: context ?? navigatorKey.currentState!.context,
                type: ToastType.TOAST_ERROR,
              );
            }
            break;
          }
        }
      }
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
    //setLoading(false);
    //notifyListeners();
  }

  _navigateToSuccessScreen(BuildContext? context, {String? source}) async {
    setLoading(true);
    notifyListeners();
    //await Provider.of<DashboardProvider>(context!, listen: false).getAllOfflineModulesData(context: context, projectCode: AppData().projectCode);
    WorkForceArgs args = WorkForceArgs(
      entitlementPermissionsUiModel: AppData().scanQRCodeEntitlements,
      showWorkForce: false,
    );
    Navigator.of(context!).pushReplacementNamed(
      RouteName.successfullScreen,
      // (route) => route.isFirst,
      arguments: SuccessfullScreenArgs(
        title: AppStrings().oflfine_sync_success,
        onPressed: null,
        routeName: source != null && source == 'QRCODE'
            ? RouteName.qrcodeListScreen
            : RouteName.offlineSyncScreen,
        screenArguments: source != null && source == 'QRCODE'
            ? args
            : AppData().customOfflineSyncModule,
      ),
    );
    setLoading(false);
    notifyListeners();
  }

  updateOfflineSyncSelectionWorkPermit(bool? value) {
    isSelectAll = value;
    for (var element in offlineWorkPermitsList!) {
      element.isCheck = value;
    }
    notifyListeners();
  }

  updateOfflineSyncSelectionTaskList(bool? value) {
    isSelectAll = value;
    for (var element in offlineTaskList!) {
      element.isCheck = value;
    }
    notifyListeners();
  }

  updateOfflineSyncSingleSelectionWorkPermit(int? index, bool? value) {
    offlineWorkPermitsList![index!].isCheck = value;

    List<CreateWorkPermitRequestModel> selectedValueList =
        offlineWorkPermitsList!.where((element) => element.isCheck!).toList();
    if (selectedValueList.length == offlineWorkPermitsList!.length) {
      isSelectAll = true;
    } else {
      isSelectAll = false;
    }
    notifyListeners();
  }

  updateOfflineSyncSelectionTbts(bool? value) {
    isSelectAll = value;
    for (var element in offlineTBTS!) {
      element.isCheck = value;
    }
    notifyListeners();
  }

  updateOfflineSyncSingleSelectionTBT(int? index, bool? value) {
    offlineTBTS![index!].isCheck = value;
    List<CreateToolboxTrainingModel> selectedValueList = offlineTBTS!
        .where((element) => element.isCheck!)
        .toList();
    if (selectedValueList.length == offlineTBTS!.length) {
      isSelectAll = true;
    } else {
      isSelectAll = false;
    }
    notifyListeners();
  }

  updateOfflineSyncSelectionInductionTrainings(bool? value) {
    isSelectAll = value;
    for (var element in offlineInductionTrainings!) {
      element.isCheck = value;
    }
    notifyListeners();
  }

  updateOfflineSyncSelectionChecklist(bool? value) {
    isSelectAll = value;
    for (var element in offlineChecklistList!) {
      element.isCheck = value;
    }
    notifyListeners();
  }

  updateOfflineSyncSingleSelectionInductionTrainings(int? index, bool? value) {
    offlineInductionTrainings![index!].isCheck = value;
    List<CreateInductionTrainingModel> selectedValueList =
        offlineInductionTrainings!
            .where((element) => element.isCheck!)
            .toList();
    if (selectedValueList.length == offlineInductionTrainings!.length) {
      isSelectAll = true;
    } else {
      isSelectAll = false;
    }
    notifyListeners();
  }

  getAllCapturedAttendanceData({BuildContext? context, bool? isNotify}) async {
    setLoading(true);
    offlineCreatedInAndOutsList!.clear();
    offlineDisplayCreatedInAndOutsList!.clear();
    if (isNotify!) notifyListeners();

    RequestModel<GetCapturedResultRequestModel> requestModel =
        await _offlineCaptureAttendanceRequestBuilder!
            .getCapturedResultsFormSearch(searchName: '');

    ResponseModel<List<AttendanceCaptureRequestModel>>? response =
        await _getOfflineCreatedInAndOutUseCase!.execute(request: requestModel);

    if (response.isSuccess!) {
      if (response.data != null) {
        offlineCreatedInAndOutsList = response.data!;
        offlineDisplayCreatedInAndOutsList = response.data!;
        //  offlineDisplayCreatedInAndOutsList!.sort((a, b) => DateTime.parse(b.createdAtOfflineDate!)
        //   .compareTo(DateTime.parse(a.createdAtOfflineDate!)));
      } else {
        offlineCreatedInAndOutsList = [];
        offlineDisplayCreatedInAndOutsList = [];
      }
      //CustomLogger.logPrint('Offline Captured list length ${offlineCreatedInAndOutsList!.length}');
    } else {
      offlineCreatedInAndOutsList = [];
      offlineDisplayCreatedInAndOutsList = [];
    }
    setLoading(false);
    notifyListeners();
  }

  updateOfflineSyncSingleSelectionChecklist(int? index, bool? value) {
    offlineChecklistList![index!].isCheck = value;
    List<CheckListsUiModel> selectedValueList = offlineChecklistList!
        .where((element) => element.isCheck!)
        .toList();
    if (selectedValueList.length == offlineChecklistList!.length) {
      isSelectAll = true;
    } else {
      isSelectAll = false;
    }
    notifyListeners();
  }

  updateOfflineSyncSelectionSafetyObservation(bool? value) {
    isSelectAll = value;
    for (var element in offlineSafetyObservationsList!) {
      element.isCheck = value;
    }
    notifyListeners();
  }

  updateOfflineSyncSingleSelectionSafetyObservation(int? index, bool? value) {
    offlineSafetyObservationsList![index!].isCheck = value;
    List<CreateSafetyObservationModel> selectedValueList =
        offlineSafetyObservationsList!
            .where((element) => element.isCheck!)
            .toList();
    if (selectedValueList.length == offlineSafetyObservationsList!.length) {
      isSelectAll = true;
    } else {
      isSelectAll = false;
    }
    notifyListeners();
  }

  deleteChecklist(int index) {
    HiveChecklistService.deleteOfflineChecklist(index);
    getOfflineChecklist();
  }

  void getOfflineTask({BuildContext? context, bool? isNotify}) async {
    setLoading(true);
    offlineTaskList!.clear();
    if (isNotify!) notifyListeners();

    RequestModel<CommonRequestModel> requestModel = await _commonRequestBuilder!
        .getCommonRequestModel();

    ResponseModel<List<CreateTaskModel>> response =
        await _getOfflineTaskUseCase!.execute(request: requestModel);

    if (response.isSuccess!) {
      if (response.data != null) {
        offlineTaskList = response.data!;
        // for (var element in offlineTaskList!) {
        //   element.isCheck = false;
        // }
      } else {
        offlineTaskList = [];
      }
      //CustomLogger.logPrint('offline work permits ${response.data!.length}');
    } else {
      offlineTaskList = [];
    }
    setLoading(false);
    notifyListeners();
  }

  void syncOfflineTasks({BuildContext? context}) async {
    try {
      setLoading(true);
      notifyListeners();

      List<CreateTaskModel>? selectedOfflineTask = [];
      selectedOfflineTask.addAll(offlineTaskList!);

      if (selectedOfflineTask.isNotEmpty) {
        for (int i = 0; i < selectedOfflineTask.length; i++) {
          var element = selectedOfflineTask[i];

          RequestModel<CreateTaskRequestModel> requestModel =
              await _checklistRequestBuilder!.getCreateTaskRequestModel(
                isOffline: true,
                createTaskModel: element,
              );

          ResponseModel<CommonResponseUiModel> response =
              await _createTaskUseCase!.execute(request: requestModel);
          if (response.isSuccess!) {
            //CustomLogger.logPrint('Sync Offline Attendance ${element.uuid}');

            RequestModel<OfflineTaskListRequestModel> requestModel =
                await _checklistRequestBuilder.getOfflineTaskList(
                  uuid: element.uuid,
                );

            ResponseModel<List<CreateTaskModel>> response =
                await _getDeleteOfflineTaskUseCase!.execute(
                  request: requestModel,
                );

            if (response.isSuccess!) {
              if (response.data != null) {
                offlineTaskList!.clear();
                // offlineDisplayCreatedInAndOutsList!.clear();
                offlineTaskList = response.data!;
                // offlineDisplayCreatedInAndOutsList =
                //     deletedOflfineSyncCapturedInAndOutResponse.data!;

                //CustomLogger.logPrint('Deleted Offline Created Attendance ${element.uuid}');
                if (selectedOfflineTask.length != offlineTaskList!.length ||
                    selectedOfflineTask.length == offlineTaskList!.length) {
                  if (i == selectedOfflineTask.length - 1) {
                    //CustomLogger.logPrint('Partial data Deleted Attendance ${element.uuid}');
                    // _navigateToSuccessScreen(context, source: source);
                    _navigateToSuccessScreen(context);
                  }
                }
              } else {
                //CustomLogger.logPrint('Delete Attendance Failed ${element.uuid}');
              }
            } else {
              //CustomLogger.logPrint('All Data Deleted Attendance ${element.uuid}');
              // _navigateToSuccessScreen(context, source: source);
              _navigateToSuccessScreen(context);
            }
          } else {
            //CustomLogger.logPrint('Failed Attendance Sync ${element.uuid}');
            AppStrings().oflfine_sync_error.showAsToast(
              context: context!,
              type: ToastType.TOAST_ERROR,
            );
            break;
          }
        }
      }
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  void syncOfflineSafetyObservations({
    BuildContext? context,
    bool syncAll = false,
    bool showSuccess = true,
    List<CreateSafetyObservationModel>? itemsOverride,
  }) async {
    try {
      if (context != null) {
        setLoading(true);
        notifyListeners();
      }

      List<CreateSafetyObservationModel>? selectedOfflineSafetyObservations =
          itemsOverride ??
          (syncAll
              ? (offlineSafetyObservationsList ?? [])
              : (offlineSafetyObservationsList ?? [])
                    .where((element) => element.isCheck!)
                    .toList());

      if (selectedOfflineSafetyObservations.isNotEmpty) {
        for (int i = 0; i < selectedOfflineSafetyObservations.length; i++) {
          var element = selectedOfflineSafetyObservations[i];

          if (element.uuid != null &&
              element.uuid!.startsWith('server_action_')) {
            final id = element.uuid!.replaceFirst('server_action_', '');
            ResponseModel<CommonResponseUiModel> response;
            if ((element.status ?? '').toUpperCase() ==
                VSAStatusConstants.STATUS_REASSIGNED) {
              if (element.assignee == null) {
                CustomLogger.logPrint(
                  'SA offline sync skipped: missing assignee for reassign uuid=${element.uuid}',
                );
                continue;
              }
              RequestModel<CreateSafetyObservationRequestModel> requestModel =
                  await _safetyObservationListRequestBuilder!
                      .createReAssigneePeopleRequestModel(
                        id: id,
                        assigneeDetails: element.assignee,
                      );
              response = await _postReassigneePeopleUseCase!.execute(
                request: requestModel,
              );
            } else {
              final List<File> incidentPhotos =
                  element.photos != null && element.photos!.isNotEmpty
                  ? await FileConversionUtility.createFileListFromBase64String(
                      base64List: element.photos!,
                      isExtensionsRequired: true,
                    )
                  : <File>[];
              CustomLogger.logPrint(
                'SA offline sync photos: uuid=${element.uuid} base64Count=${element.photos?.length ?? 0} fileCount=${incidentPhotos.length}',
              );

              RequestModel<CreateSafetyObservationRequestModel> requestModel =
                  await _safetyObservationListRequestBuilder!
                      .createCloseSafetyActionableRequestModel(
                        id: id,
                        createSafetyObservationModel: element,
                        incidentPhotos: incidentPhotos,
                      );

              response = await _postReassigneePeopleUseCase!.execute(
                request: requestModel,
              );
            }

            if (response.isSuccess!) {
              RequestModel<SafetyObservationListRequestModel>
              deleteRequestModel = await _safetyObservationListRequestBuilder!
                  .getSafetyObservationListRequestModel(uuid: element.uuid);

              await _deleteOfflineSafetyObservationsUseCase!.execute(
                request: deleteRequestModel,
              );
              await HiveSafetyObservationService.removeAssigneeSafetyObservationDetailsById(
                id,
              );
              await HiveSafetyObservationService.removeAssignorSafetyObservationDetailsById(
                id,
              );
              await HiveSafetyObservationService.setSafetyObservationDetailsOffline(
                id,
                false,
              );
              if (i == selectedOfflineSafetyObservations.length - 1 &&
                  showSuccess &&
                  context != null) {
                _navigateToSuccessScreen(context);
              }
              continue;
            } else {
              if (context != null) {
                setLoading(false);
                notifyListeners();
                AppStrings().oflfine_sync_error.showAsToast(
                  context: context,
                  type: ToastType.TOAST_ERROR,
                );
              } else {
                CustomLogger.logPrint(
                  'SA offline sync error: ${response.message}',
                );
              }
              break;
            }
          }

          List<String> photos = [];
          if (element.photos != null && element.photos!.isNotEmpty) {
            for (var file in element.photos!) {
              photos.add(file);
            }
          }

          RequestModel<CreateSafetyObservationRequestModel> requestModel =
              await _safetyObservationListRequestBuilder!
                  .getCreateSafetyObservationRequestModel(
                    createSafetyObservationModel: element,
                    incidentPhotos: photos,
                  );

          ResponseModel<CommonResponseUiModel> response =
              await _createSafetyObservationUseCase!.execute(
                request: requestModel,
              );

          if (response.isSuccess!) {
            MixpanelService().trackEvent(
              eventName: AppStrings().tbt_created_successfully,
            );

            RequestModel<SafetyObservationListRequestModel> deleteRequestModel =
                await _safetyObservationListRequestBuilder!
                    .getSafetyObservationListRequestModel(uuid: element.uuid);

            ResponseModel<List<CreateSafetyObservationModel>>
            deletedOfflineSafetyObservationsResponse =
                await _deleteOfflineSafetyObservationsUseCase!.execute(
                  request: deleteRequestModel,
                );

            if (deletedOfflineSafetyObservationsResponse.isSuccess!) {
              if (deletedOfflineSafetyObservationsResponse.data != null) {
                offlineSafetyObservationsList!.clear();
                offlineSafetyObservationsList =
                    deletedOfflineSafetyObservationsResponse.data!;
                if (i == selectedOfflineSafetyObservations.length - 1 &&
                    showSuccess &&
                    context != null) {
                  _navigateToSuccessScreen(context);
                }
              }
            } else {
              if (showSuccess && context != null) {
                _navigateToSuccessScreen(context);
              }
            }
          } else {
            if (response.message != null &&
                response.message!.toLowerCase() ==
                    'This record is already exists.'.toLowerCase()) {
              MixpanelService().trackEvent(
                eventName: AppStrings().so_created_successfully,
              );

              RequestModel<SafetyObservationListRequestModel>
              deleteRequestModel = await _safetyObservationListRequestBuilder!
                  .getSafetyObservationListRequestModel(uuid: element.uuid);

              ResponseModel<List<CreateSafetyObservationModel>>
              deletedOfflineSafetyObservationsResponse =
                  await _deleteOfflineSafetyObservationsUseCase!.execute(
                    request: deleteRequestModel,
                  );

              if (deletedOfflineSafetyObservationsResponse.isSuccess!) {
                if (deletedOfflineSafetyObservationsResponse.data != null) {
                  offlineSafetyObservationsList!.clear();
                  offlineSafetyObservationsList =
                      deletedOfflineSafetyObservationsResponse.data!;
                  if (i == selectedOfflineSafetyObservations.length - 1 &&
                      showSuccess &&
                      context != null) {
                    _navigateToSuccessScreen(context);
                  }
                }
              } else {
                if (showSuccess && context != null) {
                  _navigateToSuccessScreen(context);
                }
              }
            } else {
              if (context != null) {
                setLoading(false);
                notifyListeners();
                AppStrings().oflfine_sync_error.showAsToast(
                  context: context,
                  type: ToastType.TOAST_ERROR,
                );
              } else {
                CustomLogger.logPrint(
                  'SA offline sync error: ${response.message}',
                );
              }
              break;
            }
          }
        }
      }
      if (context != null) {
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      if (context != null) {
        setLoading(false);
        notifyListeners();
      }
      CustomLogger.logPrint('SA offline sync exception: $e');
    }
  }
}
