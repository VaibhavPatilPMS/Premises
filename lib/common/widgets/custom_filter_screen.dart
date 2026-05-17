import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';

class CustomFilterScreen extends StatefulWidget {
  final CustomFilterArgs? args;

  const CustomFilterScreen({super.key, this.args});

  @override
  State<CustomFilterScreen> createState() => _CustomFilterScreenState();
}

class _CustomFilterScreenState extends State<CustomFilterScreen> {
  FilterModel filterModel = FilterModel();

  // SafetyObservationProvider? safetyObservationProvider;
  // TaskProvider? taskProvider;
  // NoticeViolationDebitNoteProvider? violationNoticeProvider;
  // CheckListProvider? checklistProvider;
  // ProjectLaborsProvider? projectLaborsProvider;
  // AttendanceProvider? attendanceProvider;
  Map? filterReturnResult;
  List<FilterUIModel> filterFields = [];
  DateTime? selectedDateTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // safetyObservationProvider =
    //     Provider.of<SafetyObservationProvider>(context, listen: false);
    // checklistProvider = Provider.of<CheckListProvider>(context, listen: false);
    // projectLaborsProvider =
    //     Provider.of<ProjectLaborsProvider>(context, listen: false);
    // attendanceProvider = Provider.of<AttendanceProvider>(context, listen: false);
    // taskProvider = Provider.of<TaskProvider>(context, listen: false);

    Map filterReturnResult = widget.args!.filterReturnResult ?? {};
    List<FilterUIModel> originFilterFields = widget.args!.filterFields!;

    if (filterReturnResult.containsKey(FilterConstants.FILTER_LIST_KEY)) {
      for (int i = 0; i < originFilterFields.length; i++) {
        List<FilterUIModel> tempFilterList =
            filterReturnResult[FilterConstants.FILTER_LIST_KEY];
        for (var element in tempFilterList) {
          if (element.title == originFilterFields[i].title) {
            originFilterFields[i].value = element.value;
          }
        }
      }
    }

    filterFields.addAll(originFilterFields);
    selectedDateTime = filterModel.selectedFromDateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen.commonScreenWithAppbar(
      appbarWidget: CommonAppBar(
        title: AppStrings().filter,
        zeroElevation: true,
        showBackIcon: false,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  alignment: Alignment.center,
                  padding: MarginPadding().xsmallAll,
                  onPressed: () {
                    Navigator.pop(context);
                    // checklistProvider!.selectedFilterValue = -1;
                  },
                  icon: AppIcon(
                    icon: AppIcons().ic_close_icon,
                    iconHeight: IconSize().large,
                    iconWidth: IconSize().large,
                    iconColor: AppColors.text_grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      buildScreenColor: AppColors.white,
      screenWidget: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _buildFilterUI(context),
              ),
            ),
          ),
          _buildButtons(context)
        ],
      ),
      noDefaultPadding: true,
      context: context,
      scaffoldKey: _scaffoldKey,
    );
  }

  List<Widget> _buildFilterUI(BuildContext context) {
    List<Widget> widgets = [];
    Map filterReturnResult = widget.args!.filterReturnResult ?? {};
    if (widget.args!.showDateWidgets!) {
      filterModel.selectedFromDateTime =
          filterReturnResult[FilterConstants.FROM_DATE_KEY];
      filterModel.selectedToDateTime =
          filterReturnResult[FilterConstants.TO_DATE_KEY];
      if (widget.args!.screenFlag == FilterConstants.CEHCKLIST) {
        selectedDateTime = filterModel.selectedFromDateTime;
      }

      // widgets.add(_datePicker(context));
    }
    if (widget.args!.showFromToDateAlert!) {
      filterModel.selectedFromDateAlert =
          filterReturnResult[FilterConstants.FROM_DATE_ALERT_KEY];
      filterModel.selectedToDateAlert =
          filterReturnResult[FilterConstants.TO_DATE_ALERT_KEY];
      widgets.add(_datePickerAlert(context));
    }

    // for (int i = 0; i < filterFields.length; i++) {
    //   if (FieldType.dropDown == filterFields[i].fieldType) {
    //     widgets.add(
    //       Container(
    //         margin: MarginPadding().xlargeTop,
    //         padding: MarginPadding().xmediumLeftRight,
    //         child: Column(
    //           children: [
    //             AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //             Spacing().xxsmallVertical,
    //             AppDropDown<CommonDropDownModel>(
    //               dropdownItems:
    //                   filterFields[i].arr as List<CommonDropDownModel>,
    //               hint: filterFields[i].hintText!,
    //               onChanged: (value) {
    //                 filterFields[i].value = value;
    //                 if (widget.args!.screenFlag ==
    //                         FilterConstants.PROJECT_LABOR ||
    //                     widget.args!.screenFlag ==
    //                         FilterConstants.PROJECT_LABOR_ACTIVE) {
    //                   if (filterFields[i].title != AppStrings().labour_status) {
    //                     projectLaborsProvider!.getContractorFirms(
    //                         contractorGroupName: value.lable,
    //                         isResetFilter: false);
    //                     projectLaborsProvider!.selectedMainAreas!.clear();
    //                     setState(() {
    //                       filterFields[3].value = null;
    //                     });
    //                   }
    //                 }
    //                 if (widget.args!.screenFlag == FilterConstants.CEHCKLIST ||
    //                     widget.args!.screenFlag ==
    //                         FilterConstants.ON_DEMAND_CHECKLIST) {
    //                   checklistProvider!.getSpotsNamesFilters(
    //                     groupCode: value.code,
    //                   );
    //                 }
    //               },
    //               value: filterFields[i].value,
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   } else if (FieldType.multiselectChips == filterFields[i].fieldType) {
    //     widgets.add(
    //       Container(
    //         margin: MarginPadding().xlargeTop,
    //         padding: MarginPadding().xmediumLeftRight,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //             Spacing().xxsmallVertical,
    //             MultiSelectChip(
    //               chipsList: filterFields[i].arr as List<String>,
    //               existingSelectedChoices: filterFields[i].value,
    //               onSelectionChanged: (selectedList) {
    //                 filterFields[i].value = selectedList;
    //                 setState(() {});
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   } else if (FieldType.removeChips == filterFields[i].fieldType) {
    //     widgets.add(_chipsWithRemoveSelected(
    //       filterFields[i].title!,
    //       filterFields[i].hintText!,
    //       filterFields[i].arr,
    //     ));
    //   } else if (FieldType.peopleBottomsheetList == filterFields[i].fieldType) {
    //     List<AssigneesListFormUiModel>? selectedAssigneeList =
    //         safetyObservationProvider!.assigneeList!
    //             .where((element) => element.id == filterFields[i].value)
    //             .toList();

    //     widgets.add(
    //       Consumer<SafetyObservationProvider>(
    //           builder: (context, safetyObservationProvider, child) {
    //         return Padding(
    //           padding: MarginPadding().xmediumAll,
    //           child: Column(
    //             children: [
    //               Spacing().smallVertical,
    //               AppText.xsmallGreyG1Regular(
    //                 //AppStrings().select_assignee,
    //                 filterFields[i].title,
    //                 isAsteriskVisible: true,
    //               ),
    //               Spacing().xsmallVertical,
    //               selectedAssigneeList.isEmpty
    //                   ? Align(
    //                       alignment: Alignment.center,
    //                       child: AppBorderedButton(
    //                         width: 180,
    //                         buttonName: filterFields[i].hintText!.toUpperCase(),
    //                         onPressed: () {
    //                           safetyObservationProvider.resetAssigneeList();
    //                           showAssigneeModalBottomSheet(
    //                             context,
    //                             onSelect: (id) {
    //                               filterFields[i].value = id;
    //                               setState(() {});
    //                             },
    //                           );
    //                         },
    //                         backgroundColor: AppColors.white,
    //                       ),
    //                     )
    //                   : _buildAssignee(
    //                       selectedAssigneeList, safetyObservationProvider,
    //                       clear: () {
    //                       filterFields[i].value = null;
    //                       setState(() {});
    //                     })
    //             ],
    //           ),
    //         );
    //       }),
    //     );
    //   } else if (FieldType.peopleAssigneeList == filterFields[i].fieldType) {
    //     List<FilterAssigneesDataUiModel>? selectedAssigneeList = taskProvider!
    //         .taskAssigneeList!
    //         .where((element) => element.username == filterFields[i].value)
    //         .toList();

    //     widgets.add(
    //       Consumer<TaskProvider>(
    //           builder: (context, safetyObservationProvider, child) {
    //         return Padding(
    //           padding: MarginPadding().xmediumAll,
    //           child: Column(
    //             children: [
    //               Spacing().smallVertical,
    //               AppText.xsmallGreyG1Regular(
    //                 //AppStrings().select_assignee,
    //                 filterFields[i].title,
    //                 isAsteriskVisible: true,
    //               ),
    //               Spacing().xsmallVertical,
    //               selectedAssigneeList.isEmpty
    //                   ? Align(
    //                       alignment: Alignment.center,
    //                       child: AppBorderedButton(
    //                         width: 150,
    //                         buttonName: filterFields[i].hintText!.toUpperCase(),
    //                         onPressed: () {
    //                           safetyObservationProvider.resetAssigneeList();
    //                           showTaskAssigneeModalBottomSheet(context,
    //                               onSelect: (id) {
    //                             filterFields[i].value = id;
    //                             setState(() {});
    //                           }, title: filterFields[i].title);
    //                         },
    //                         backgroundColor: AppColors.white,
    //                       ),
    //                     )
    //                   : _buildTaskAssignee(
    //                       selectedAssigneeList, safetyObservationProvider,
    //                       clear: () {
    //                       filterFields[i].value = null;
    //                       setState(() {});
    //                     })
    //             ],
    //           ),
    //         );
    //       }),
    //     );
    //   } else if (FieldType.singleSelectBottomShit ==
    //       filterFields[i].fieldType) {
    //     widgets.add(Padding(
    //       padding: MarginPadding().mediumAll,
    //       child: Column(
    //         children: [
    //           AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //           Spacing().xxsmallVertical,
    //           RemovableSingleSelectChipWidget(
    //             title: filterFields[i].title!,
    //             radioListTileModelList:
    //                 filterFields[i].arr as List<RadioButtonListTileModel>,
    //             onSelectionChanged: (selectedList) {
    //               filterFields[i].value = selectedList;
    //               setState(() {});
    //             },
    //             initialValue: filterFields[i].value,
    //           ),
    //         ],
    //       ),
    //     ));
    //   } else if (FieldType.multiSelectBottomShit == filterFields[i].fieldType) {
    //     if (filterFields[i].value == null) {
    //       for (var element
    //           in (filterFields[i].arr as List<CheckBoxListTileModel>)) {
    //         element.isCheck = false;
    //       }
    //     }
    //     widgets.add(Consumer<ProjectLaborsProvider>(
    //         builder: (context, snapshot, child) {
    //       return Padding(
    //         padding: MarginPadding().mediumAll,
    //         child: Column(
    //           children: [
    //             AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //             Spacing().xxsmallVertical,
    //             (widget.args!.screenFlag == FilterConstants.PROJECT_LABOR ||
    //                     widget.args!.screenFlag ==
    //                         FilterConstants.PROJECT_LABOR_ACTIVE)
    //                 ? RemovableMultiSelectChipWidget(
    //                     showSearchBar: true,
    //                     title: filterFields[i].title!,
    //                     checkBoxListTileModel:
    //                         Provider.of<ProjectLaborsProvider>(context,
    //                                 listen: false)
    //                             .contractorList as List<CheckBoxListTileModel>,
    //                     onSelectionChanged: (
    //                         {otherValue, required selectedList}) {
    //                       projectLaborsProvider!.selectedMainAreas =
    //                           selectedList;
    //                       projectLaborsProvider!.setSelectedContractors(
    //                           selectedList, widget.args!.screenFlag);
    //                       filterFields[i].value = selectedList;
    //                       setState(() {});
    //                     },
    //                     initialValue: snapshot.selectedMainAreas,
    //                   )
    //                 : RemovableMultiSelectChipWidget(
    //                     showSearchBar: true,
    //                     title: filterFields[i].title!,
    //                     checkBoxListTileModel:
    //                         filterFields[i].arr as List<CheckBoxListTileModel>,
    //                     onSelectionChanged: (
    //                         {otherValue, required selectedList}) {
    //                       filterFields[i].value = selectedList;
    //                       setState(() {});
    //                     },
    //                     initialValue: filterFields[i].value,
    //                   ),
    //           ],
    //         ),
    //       );
    //     }));
    //   } else if (FieldType.singleSelectRadioButtons ==
    //       filterFields[i].fieldType) {
    //     widgets.add(
    //       Container(
    //         margin: MarginPadding().xlargeTop,
    //         padding: MarginPadding().xmediumLeftRight,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //             Spacing().xsmallVertical,
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: HorizontalRoundedRadioButton(
    //                       title: 'Scheduled',
    //                       onChanged: (val) {
    //                         checklistProvider!.onFilterRadioChange(val as int);
    //                         filterFields[i].value = null;
    //                       },
    //                       index: 0,
    //                       isCheck: false,
    //                       selectedIndex: context
    //                           .watch<CheckListProvider>()
    //                           .selectedFilterValue!),
    //                 ),
    //                 Expanded(
    //                   child: HorizontalRoundedRadioButton(
    //                       title: 'On Demand',
    //                       onChanged: (val) {
    //                         checklistProvider!.onFilterRadioChange(val as int);
    //                         filterFields[i].value = null;
    //                       },
    //                       index: 1,
    //                       isCheck: false,
    //                       selectedIndex: context
    //                           .watch<CheckListProvider>()
    //                           .selectedFilterValue!),
    //                 ),
    //               ],
    //             ),
    //             if (context.watch<CheckListProvider>().selectedFilterValue! !=
    //                 -1)
    //               Container(
    //                 margin: MarginPadding().xlargeTop,
    //                 padding: MarginPadding().xmediumLeftRight,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     AppText.xsmallGreyG1Regular(filterFields[i].title! ==
    //                             AppStrings().checklist_type
    //                         ? AppStrings().checklist_status
    //                         : filterFields[i].title! == AppStrings().form_type
    //                             ? AppStrings().form_status
    //                             : filterFields[i].title),
    //                     Spacing().xxsmallVertical,
    //                     MultiSelectChip(
    //                       chipsList: context
    //                                   .watch<CheckListProvider>()
    //                                   .selectedFilterValue! ==
    //                               1
    //                           ? checklistProvider!.onDemandStatuses
    //                           : checklistProvider!.selectedTab ==
    //                                   CheckListTab.ALL
    //                               ? checklistProvider!.scheduledStatusesAllTab
    //                               : checklistProvider!.selectedTab ==
    //                                       CheckListTab.FOR_REVIEW
    //                                   ? checklistProvider!
    //                                       .scheduledStatusesReviewTab
    //                                   : checklistProvider!.scheduledStatuses,
    //                       existingSelectedChoices: filterFields[i].value,
    //                       onSelectionChanged: (selectedList) {
    //                         filterFields[i].value = selectedList;
    //                         setState(() {});
    //                       },
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             //     if (context.watch<CheckListProvider>().selectedFilterValue! ==
    //             //         1)
    //             //      Container(
    //             // margin: MarginPadding().xlargeTop,
    //             // padding: MarginPadding().xmediumLeftRight,
    //             // child: Column(
    //             //   crossAxisAlignment: CrossAxisAlignment.start,
    //             //   children: [
    //             //     AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //             //     Spacing().xxsmallVertical,
    //             //     MultiSelectChip(
    //             //       chipsList: filterFields[i].arr as List<String>,
    //             //       existingSelectedChoices: filterFields[i].value,
    //             //       onSelectionChanged: (selectedList) {
    //             //         filterFields[i].value = selectedList;
    //             //         setState(() {});
    //             //       },
    //             //     ),
    //             //     ],
    //             //   ),
    //             // ),
    //           ],
    //         ),
    //       ),
    //     );
    //   } else if (FieldType.textbox == filterFields[i].fieldType) {
    //     widgets.add(
    //       Container(
    //         margin: MarginPadding().xmediumTop,
    //         padding: MarginPadding().xmediumLeftRight,
    //         child: Column(
    //           children: [
    //             AppText.xsmallGreyG1Regular(filterFields[i].title!),
    //             Spacing().xxsmallVertical,
    //             CustomTextFormField(
    //               hinttext: filterFields[i].hintText!,
    //               textInputType: TextInputType.text,
    //               maxLines: 1,
    //               initialValue: filterFields[i].value ?? '',
    //               validator: (value) {
    //                 // Add validation logic for the min value
    //                 return null;
    //               },
    //               onChanged: (value) {
    //                 filterFields[i].value = value;
    //                 // Handle min value change
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   } else if (FieldType.minMaxrange == filterFields[i].fieldType) {
    //     widgets.add(
    //       Container(
    //         margin: MarginPadding().xlargeTop,
    //         padding: MarginPadding().xmediumLeftRight,
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       AppText.xsmallGreyG1Regular(
    //                           'Minimum ${filterFields[i].title!}'),
    //                       Spacing().xxsmallVertical,
    //                       CustomTextFormField(
    //                         hinttext: 'Enter ${filterFields[i].title!}',
    //                         textInputType: TextInputType.number,
    //                         maxLines: 1,
    //                         onChanged: (value) {
    //                           filterFields[i].value =
    //                               '$value , ${filterFields[i].value}';
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Spacing().lmediumHorizontal,
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       AppText.xsmallGreyG1Regular(
    //                           'Maximum ${filterFields[i].title!}'),
    //                       Spacing().xxsmallVertical,
    //                       CustomTextFormField(
    //                         hinttext: 'Enter ${filterFields[i].title!}',
    //                         textInputType: TextInputType.number,
    //                         maxLines: 1,
    //                         validator: (value) {
    //                           // Add validation logic for the max value
    //                           return null;
    //                         },
    //                         onChanged: (value) {
    //                           filterFields[i].value =
    //                               '${filterFields[i].value} , $value';
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   } else if (FieldType.timeSelect == filterFields[i].fieldType) {
    //     widgets.add(Container(
    //       margin: MarginPadding().xlargeTop,
    //       padding: MarginPadding().xmediumLeftRight,
    //       child: Column(children: [
    //         AppText.xsmallGreyG1Regular(
    //           filterFields[i].title!,
    //           isAsteriskVisible: false,
    //         ),
    //         Container(
    //           padding: MarginPadding().mediumAll,
    //           decoration: BoxDecoration(
    //             borderRadius:
    //                 BorderRadius.circular(AppSizes().dropDownCornerRadius),
    //             color: AppColors.white,
    //             border: Border.all(
    //               color: AppColors.text_grey_g2,
    //               width: AppSizes().dropDownBorderWidth,
    //             ),
    //           ),
    //           child: InkWell(
    //             onTap: () async {
    //               Color customColor = AppColors.color_primary;
    //               MaterialColor customMaterialColor = MaterialColor(
    //                 customColor.value,
    //                 <int, Color>{
    //                   50: customColor.withOpacity(0.1),
    //                   100: customColor.withOpacity(0.2),
    //                   200: customColor.withOpacity(0.3),
    //                   300: customColor.withOpacity(0.4),
    //                   400: customColor.withOpacity(0.5),
    //                   500: customColor.withOpacity(0.6),
    //                   600: customColor.withOpacity(0.7),
    //                   700: customColor.withOpacity(0.8),
    //                   800: customColor.withOpacity(0.9),
    //                   900: customColor.withOpacity(1.0),
    //                 },
    //               );

    //               TimeOfDay? startTime = await showTimePicker(
    //                 context: context,
    //                 initialTime: attendanceProvider!.startTime,
    //                 initialEntryMode: TimePickerEntryMode.dialOnly,
    //                 // Set initial entry mode to input
    //                 helpText: 'Select Start Time',
    //                 // Customize the help text
    //                 builder: (BuildContext context, Widget? child) {
    //                   return Theme(
    //                     data: ThemeData(
    //                       primarySwatch: customMaterialColor,
    //                     ),
    //                     child: child!,
    //                   );
    //                 },
    //               );

    //               if (startTime != null) {
    //                 attendanceProvider!.startTime = startTime;
    //                 Color customColor = AppColors.color_primary;
    //                 MaterialColor customMaterialColor = MaterialColor(
    //                   customColor.value,
    //                   <int, Color>{
    //                     50: customColor.withOpacity(0.1),
    //                     100: customColor.withOpacity(0.2),
    //                     200: customColor.withOpacity(0.3),
    //                     300: customColor.withOpacity(0.4),
    //                     400: customColor.withOpacity(0.5),
    //                     500: customColor.withOpacity(0.6),
    //                     600: customColor.withOpacity(0.7),
    //                     700: customColor.withOpacity(0.8),
    //                     800: customColor.withOpacity(0.9),
    //                     900: customColor.withOpacity(1.0),
    //                   },
    //                 );
    //                 TimeOfDay? endTime = await showTimePicker(
    //                   context: context,
    //                   initialTime: attendanceProvider!.endTime,
    //                   initialEntryMode: TimePickerEntryMode.dialOnly,
    //                   // Set initial entry mode to input
    //                   helpText: 'Select End Time',
    //                   // Customize the help text
    //                   builder: (BuildContext context, Widget? child) {
    //                     return Theme(
    //                       data: ThemeData(
    //                         primarySwatch: customMaterialColor,
    //                       ),
    //                       child: child!,
    //                     );
    //                   },
    //                 );
    //                 if (endTime != null) {
    //                   attendanceProvider!.endTime = endTime;
    //                   String timeRange =
    //                       '${startTime.format(context)} - ${endTime.format(context)}';

    //                   // Update your UI or state variable with the time range
    //                   // For example:
    //                   setState(() {
    //                     filterFields[i].value = timeRange;
    //                   });
    //                 }
    //               }
    //             },
    //             child: (filterFields[i].value != null)
    //                 ? AppText.smallGreyMedium(filterFields[i].value)
    //                 : AppText.smallGreyG2Regular(
    //                     AppStrings().select_duration_of_work,
    //                   ),
    //           ),
    //         )
    //       ]),
    //     ));
    //   } else if (FieldType.checkbox == filterFields[i].fieldType) {
    //     widgets.add(
    //       Container(
    //         margin: MarginPadding().xlargeTop,
    //         child: Column(
    //           children: [
    //             CheckBoxListTileWidget(
    //               title: AppText.smallGreyMedium(filterFields[i]
    //                   .title!
    //                   .toString()
    //                   .toBeginningOfSentence()),
    //               isCheck: filterFields[i].value ?? false,
    //               onChanged: (val) {
    //                 setState(() {
    //                   filterFields[i].value = val;
    //                 });
    //               },
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //   } else {
    //     widgets.add(Container());
    //   }
    // }
    return widgets;
  }

  // Widget _datePicker(BuildContext context) {
  //   return Column(
  //     children: [
  //       if (widget.args!.showFromToDateAlert!)
  //         Padding(
  //           padding: const EdgeInsets.only(left: 14),
  //           child: AppText.xsmallGreyG1Regular(
  //               widget.args!.screenFlag == FilterConstants.INCIDENT_LIST
  //                   ? 'Reported Date'
  //                   : 'Task'),
  //         ),
  //       Spacing().xxsmallVertical,
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(right: 8.0, left: 16.0),
  //               child: Column(
  //                 children: [
  //                   AppText.xsmallGreyG1Regular(AppStrings().fromDate),
  //                   Spacing().xxsmallVertical,
  //                   Container(
  //                     padding: MarginPadding().mediumAll,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(
  //                           AppSizes().dropDownCornerRadius),
  //                       color: AppColors.white,
  //                       border: Border.all(
  //                         color: AppColors.text_grey_g2,
  //                         width: AppSizes().dropDownBorderWidth,
  //                       ),
  //                     ),
  //                     child: InkWell(
  //                       onTap: () async {
  //                         selectedDateTime = await AppCalendar().appCalendar(
  //                             type: CalendarType.DATE_PICKER,
  //                             context: context,
  //                             startInitialDate: widget.args!.screenFlag ==
  //                                     FilterConstants.CEHCKLIST
  //                                 ? filterModel.selectedFromDateTime
  //                                 : null,
  //                             endDate: widget.args!.screenFlag ==
  //                                     FilterConstants.CEHCKLIST
  //                                 ? null
  //                                 : DateTime.now());
  //                         filterModel.selectedFromDateTime = selectedDateTime;
  //                         widget.args!.filterReturnResult ??= {};
  //                         if (widget.args!.filterReturnResult!
  //                             .containsKey(FilterConstants.FROM_DATE_KEY)) {
  //                           widget.args!.filterReturnResult![FilterConstants
  //                               .FROM_DATE_KEY] = selectedDateTime;
  //                         } else {
  //                           widget.args!.filterReturnResult!.putIfAbsent(
  //                               FilterConstants.FROM_DATE_KEY,
  //                               () => selectedDateTime);
  //                         }
  //                         setState(() {});
  //                       },
  //                       child: filterModel.selectedFromDateTime == null
  //                           ? AppText.smallGreyG2Regular(
  //                               AppStrings().selectDate)
  //                           : AppText.smallGreyRegular(
  //                               DateTimeUtil().getDateWithMonthNameYear(
  //                                   filterModel.selectedFromDateTime
  //                                       .toString()),
  //                             ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(right: 16.0, left: 8.0),
  //               child: Column(
  //                 children: [
  //                   AppText.xsmallGreyG1Regular(AppStrings().toDate),
  //                   Spacing().xxsmallVertical,
  //                   Container(
  //                     padding: MarginPadding().mediumAll,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(
  //                           AppSizes().dropDownCornerRadius),
  //                       color: AppColors.white,
  //                       border: Border.all(
  //                         color: AppColors.text_grey_g2,
  //                         width: AppSizes().dropDownBorderWidth,
  //                       ),
  //                     ),
  //                     child: InkWell(
  //                       onTap: () async {
  //                         if (widget.args!.screenFlag ==
  //                                 FilterConstants.CEHCKLIST &&
  //                             selectedDateTime == null) {
  //                           AppStrings()
  //                               .error_valid_fromDate_filter
  //                               .showAsToast(
  //                                   context: context,
  //                                   type: ToastType.TOAST_ERROR);
  //                           return;
  //                         }
  //                         DateTime twelveMonthsLater = DateTime(
  //                             selectedDateTime!.year,
  //                             selectedDateTime!.month + 12,
  //                             selectedDateTime!.day);
  //                         DateTime selectedDateTime2 = await AppCalendar()
  //                             .appCalendar(
  //                                 type: CalendarType.DATE_PICKER,
  //                                 context: context,
  //                                 startDate: widget.args!.screenFlag ==
  //                                         FilterConstants.CEHCKLIST
  //                                     ? selectedDateTime
  //                                     : null,
  //                                 //filterModel.selectedToDateTime ??
  //                                 startInitialDate: widget.args!.screenFlag ==
  //                                         FilterConstants.CEHCKLIST
  //                                     ? filterModel.selectedToDateTime ??
  //                                         selectedDateTime
  //                                     : null,
  //                                 endDate: widget.args!.screenFlag ==
  //                                         FilterConstants.CEHCKLIST
  //                                     ? twelveMonthsLater
  //                                     : DateTime.now());
  //                         filterModel.selectedToDateTime = selectedDateTime2;
  //                         widget.args!.filterReturnResult ??= {};
  //                         if (widget.args!.filterReturnResult!
  //                             .containsKey(FilterConstants.TO_DATE_KEY)) {
  //                           widget.args!.filterReturnResult![FilterConstants
  //                               .TO_DATE_KEY] = selectedDateTime2;
  //                         } else {
  //                           widget.args!.filterReturnResult!.putIfAbsent(
  //                               FilterConstants.TO_DATE_KEY,
  //                               () => selectedDateTime2);
  //                         }
  //                         setState(() {});
  //                       },
  //                       child: filterModel.selectedToDateTime == null
  //                           ? AppText.smallGreyG2Regular(
  //                               AppStrings().selectDate)
  //                           : AppText.smallGreyRegular(
  //                               DateTimeUtil().getDateWithMonthNameYear(
  //                                   filterModel.selectedToDateTime.toString()),
  //                             ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _datePickerAlert(BuildContext context) {
    return Column(
      children: [
        Spacing().smallVertical,
        if (widget.args!.showFromToDateAlert!)
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: AppText.xsmallGreyG1Regular(
                widget.args!.screenFlag == FilterConstants.INCIDENT_LIST
                    ? 'Incident Date'
                    : 'Alert'),
          ),
        Spacing().xsmallVertical,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                child: Column(
                  children: [
                    AppText.xsmallGreyG1Regular(AppStrings().fromDate),
                    Spacing().xxsmallVertical,
                    Container(
                      padding: MarginPadding().mediumAll,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSizes().dropDownCornerRadius),
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.text_grey_g2,
                          width: AppSizes().dropDownBorderWidth,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          DateTime selectedDateTime =
                              await AppCalendar().appCalendar(
                            type: CalendarType.DATE_PICKER,
                            context: context,
                            endDate: widget.args!.screenFlag ==
                                    FilterConstants.INCIDENT_LIST
                                ? DateTime.now()
                                : null,
                            // endDate: DateTime.now()
                          );
                          filterModel.selectedFromDateAlert = selectedDateTime;
                          widget.args!.filterReturnResult ??= {};
                          if (widget.args!.filterReturnResult!.containsKey(
                              FilterConstants.FROM_DATE_ALERT_KEY)) {
                            widget.args!.filterReturnResult![FilterConstants
                                .FROM_DATE_ALERT_KEY] = selectedDateTime;
                          } else {
                            widget.args!.filterReturnResult!.putIfAbsent(
                                FilterConstants.FROM_DATE_ALERT_KEY,
                                () => selectedDateTime);
                          }
                          setState(() {});
                        },
                        child: filterModel.selectedFromDateAlert == null
                            ? AppText.smallGreyG2Regular(
                                AppStrings().selectDate)
                            : AppText.smallGreyRegular(
                                DateTimeUtil().getDateWithMonthNameYear(
                                    filterModel.selectedFromDateAlert
                                        .toString()),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                child: Column(
                  children: [
                    AppText.xsmallGreyG1Regular(AppStrings().toDate),
                    Spacing().xxsmallVertical,
                    Container(
                      padding: MarginPadding().mediumAll,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSizes().dropDownCornerRadius),
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.text_grey_g2,
                          width: AppSizes().dropDownBorderWidth,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          DateTime selectedDateTime =
                              await AppCalendar().appCalendar(
                            type: CalendarType.DATE_PICKER,
                            context: context,
                            endDate: widget.args!.screenFlag ==
                                    FilterConstants.INCIDENT_LIST
                                ? DateTime.now()
                                : null,
                            // endDate: DateTime.now()
                          );
                          filterModel.selectedToDateAlert = selectedDateTime;
                          widget.args!.filterReturnResult ??= {};
                          if (widget.args!.filterReturnResult!
                              .containsKey(FilterConstants.TO_DATE_ALERT_KEY)) {
                            widget.args!.filterReturnResult![FilterConstants
                                .TO_DATE_ALERT_KEY] = selectedDateTime;
                          } else {
                            widget.args!.filterReturnResult!.putIfAbsent(
                                FilterConstants.TO_DATE_ALERT_KEY,
                                () => selectedDateTime);
                          }
                          setState(() {});
                        },
                        child: filterModel.selectedToDateAlert == null
                            ? AppText.smallGreyG2Regular(
                                AppStrings().selectDate)
                            : AppText.smallGreyRegular(
                                DateTimeUtil().getDateWithMonthNameYear(
                                    filterModel.selectedToDateAlert.toString()),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chipsWithRemoveSelected(
      String title, String hint, List<CheckBoxListTileModel> arr) {
    return Container(
      margin: MarginPadding().xlargeTop,
      padding: MarginPadding().xmediumLeftRight,
      child: Column(
        children: [
          AppText.xsmallGreyG1Regular(title),
          Spacing().xxsmallVertical,
          RemovableMultiSelectChipWidget(
            title: title,
            checkBoxListTileModel: arr,
            onSelectionChanged: ({otherValue, required selectedList}) {},
            initialValue: const [],
          ),
        ],
      ),
    );
  }

  // Widget _buildAssignee(List<AssigneesListFormUiModel>? assigneeList,
  //     SafetyObservationProvider safetyObservationProvider,
  //     {Function? clear}) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: assigneeList!.length,
  //     itemBuilder: (context, index) {
  //       return AssigneeCard(
  //         assigneesListFormUiModel: assigneeList[index],
  //         removeSelectedAssignee: () {
  //           safetyObservationProvider.resetAssigneeList();
  //           clear!();
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget _buildTaskAssignee(List<FilterAssigneesDataUiModel>? assigneeList,
  //     TaskProvider safetyObservationProvider,
  //     {Function? clear}) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: assigneeList!.length,
  //     itemBuilder: (context, index) {
  //       return TaskFilterAssigneeCard(
  //         assigneesListFormUiModel: assigneeList[index],
  //         removeSelectedAssignee: () {
  //           safetyObservationProvider.resetAssigneeList();
  //           clear!();
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _buildButtons(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: MarginPadding().xlargeAll,
      child: AppCombinedActionButtons(
        rightButtonOnPressed: () {
          _onTapApplyFilter(context);
        },
        leftButtonOnPressed: () {
          _onResetFilter();
        },
        rightButtonName: AppStrings().applyFilter,
        leftButtonName: AppStrings().resetFilter,
        leftButtonBackgroundColor: Colors.white,
      ),
    );
  }

  void _onTapApplyFilter(BuildContext context) {
    Map<String, dynamic> map = <String, dynamic>{};
    if (widget.args!.showDateWidgets!) {
      if (filterModel.selectedFromDateTime != null) {
        map.putIfAbsent(FilterConstants.FROM_DATE_KEY,
            () => filterModel.selectedFromDateTime!);
      }
      if (filterModel.selectedToDateTime != null) {
        map.putIfAbsent(
            FilterConstants.TO_DATE_KEY, () => filterModel.selectedToDateTime!);
      }
    }
    if (widget.args!.showFromToDateAlert!) {
      if (filterModel.selectedFromDateAlert != null) {
        map.putIfAbsent(FilterConstants.FROM_DATE_ALERT_KEY,
            () => filterModel.selectedFromDateAlert!);
      }
      if (filterModel.selectedToDateAlert != null) {
        map.putIfAbsent(FilterConstants.TO_DATE_ALERT_KEY,
            () => filterModel.selectedToDateAlert!);
      }
    }

    map.putIfAbsent(
        FilterConstants.FILTER_LIST_KEY, () => widget.args!.filterFields);
    Navigator.of(context).pop(map);
  }

  void _onResetFilter() {
    if (widget.args!.showDateWidgets!) {
      filterModel.selectedFromDateTime = null;
      filterModel.selectedToDateTime = null;
    }
    if (widget.args!.showFromToDateAlert!) {
      filterModel.selectedFromDateAlert = null;
      filterModel.selectedToDateAlert = null;
    }
    if (widget.args!.filterReturnResult != null) {
      widget.args!.filterReturnResult!.clear();
    }
    for (int i = 0; i < widget.args!.filterFields!.length; i++) {
      widget.args!.filterFields![i].value = null;
    }
    // if (widget.args!.screenFlag == FilterConstants.SAFETY_ACTIONABLE_ASSIGNOR) {
    //   SafetyObservationProvider safetyObservationProvider =
    //       Provider.of<SafetyObservationProvider>(context, listen: false);
    //   safetyObservationProvider.resetAssigneeList();
    // }
    // if (widget.args!.screenFlag == FilterConstants.PROJECT_LABOR_ACTIVE) {
    //   // SafetyObservationProvider safetyObservationProvider =
    //   //     Provider.of<SafetyObservationProvider>(context, listen: false);
    //   projectLaborsProvider!.getContractorFirms(isResetFilter: true);
    //   projectLaborsProvider!.contractorFirms!.clear();
    // }
    // if (widget.args!.screenFlag == FilterConstants.PROJECT_LABOR) {
    //   projectLaborsProvider!.getContractorFirms(isResetFilter: true);
    //   projectLaborsProvider!.contractorFirmsImportLabor!.clear();
    // }
    // if (widget.args!.screenFlag == FilterConstants.WORK_FORCE) {
    //   attendanceProvider!.category = '';
    // }
    // if (widget.args!.screenFlag == FilterConstants.CEHCKLIST) {
    //   checklistProvider!.selectedFilterValue = -1;
    //   checklistProvider!.filterRadioType = null;
    // }

    // attendanceProvider!.startTime = TimeOfDay.now();
    // attendanceProvider!.endTime = TimeOfDay.now();
    setState(() {});
    _onTapApplyFilter(context); //VSA2-971
  }
}

class CustomFilterArgs {
  List<FilterUIModel>? filterFields;
  String? screenFlag;
  bool? showDateWidgets;
  bool? showFromToDateAlert;
  Map? filterReturnResult;

  CustomFilterArgs({
    this.screenFlag,
    this.filterFields,
    this.showDateWidgets = true,
    this.showFromToDateAlert = true,
    this.filterReturnResult,
  });
}
