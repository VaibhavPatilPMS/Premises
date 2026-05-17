import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/resources/resources.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/widgets/widgets.dart';

class RemovableMultiSelectChipWidget extends StatefulWidget {
  final List<CheckBoxListTileModel> checkBoxListTileModel;
  final String title;
  final String? recordLimitErrorMessage;
  final int? recordLimit;
  final String? expansionTileTitle;
  final String? otherText;
  final Function({
    String? otherValue,
    required List<CheckBoxListTileModel> selectedList,
  })
  onSelectionChanged;
  final List<CheckBoxListTileModel>? initialValue;
  final bool showSearchBar;
  final bool isFixedHeight;
  final bool isNotApplicable;
  final bool isSelectInSequence;
  final Function(String str)? onChanged;

  const RemovableMultiSelectChipWidget({
    super.key,
    required this.title,
    required this.checkBoxListTileModel,
    required this.initialValue,
    required this.onSelectionChanged,
    this.onChanged,
    this.showSearchBar = false,
    this.isFixedHeight = false,
    this.recordLimitErrorMessage,
    this.expansionTileTitle,
    this.recordLimit,
    this.otherText,
    this.isNotApplicable = false,
    this.isSelectInSequence = false,
  });

  @override
  State<RemovableMultiSelectChipWidget> createState() =>
      _RemovableMultiSelectChipWidget();
}

class _RemovableMultiSelectChipWidget
    extends State<RemovableMultiSelectChipWidget> {
  late List<CheckBoxListTileModel>? checkBoxListTileModel;
  late ChipStateManageProvider _removableChipProvider;
  List<CheckBoxListTileModel>? selectedMultiSelectionChipList = [];
  List<CheckBoxListTileModel>? selectedMultiSelectionChipTempList = [];
  final TextEditingController _otherTextController = TextEditingController();
  Map<String, int> selectionOrderMap = {};
  int selectionCounter = 0;

  @override
  void initState() {
    // _allChips = widget.arr;
    super.initState();
    checkBoxListTileModel = widget.checkBoxListTileModel;
    _removableChipProvider = Provider.of<ChipStateManageProvider>(
      context,
      listen: false,
    );
    //_removableChipProvider.checkBoxListTileModel=checkBoxListTileModel;
    setInitialSelectedRadioTile();
  }

  void setInitialSelectedRadioTile() {
    selectedMultiSelectionChipList!.clear();
    selectionOrderMap.clear();
    selectionCounter = 0;
    if (widget.otherText != null && widget.otherText!.isNotEmpty) {
      _otherTextController.text = widget.otherText!;
    }
    checkBoxListTileModel?.forEach((element) => element.isCheck = false);
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      for (int j = 0; j < widget.initialValue!.length; j++) {
        for (int i = 0; i < checkBoxListTileModel!.length; i++) {
          if (widget.initialValue![j].title ==
                  checkBoxListTileModel![i].title &&
              widget.initialValue![j].username ==
                  checkBoxListTileModel![i].username) {
            checkBoxListTileModel![i].isCheck = true;
            selectedMultiSelectionChipList!.add(checkBoxListTileModel![i]);
            selectionOrderMap[checkBoxListTileModel![i].id] =
                selectionCounter++;
          }
        }
      }
    }
    setTempCheckedValues();
  }

  setSelectedList() {
    CustomLogger.logPrint(
      'total revierwer list ${widget.checkBoxListTileModel.length}',
    );
    checkBoxListTileModel?.forEach((element) => element.isCheck = false);
    if (widget.otherText != null && widget.otherText!.isNotEmpty) {
      _otherTextController.text = widget.otherText!;
    }
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      for (int i = 0; i < checkBoxListTileModel!.length; i++) {
        for (int j = 0; j < widget.initialValue!.length; j++) {
          if (widget.initialValue![j].title ==
                  checkBoxListTileModel![i].title &&
              widget.initialValue![j].username ==
                  checkBoxListTileModel![i].username) {
            checkBoxListTileModel![i].isCheck = true;
            //selectedMultiSelectionChipList!.add(checkBoxListTileModel![i]);
          }
        }
      }
    }
    setTempCheckedValues();
  }

  void _deleteChip({String? id}) {
    setSelectedList();
    try {
      checkBoxListTileModel!
              .where((element) => element.id == id)
              .first
              .isCheck =
          false;
      if (id != null) {
        selectionOrderMap.remove(id);
      }
      if (checkBoxListTileModel!
                  .where((element) => element.id == id)
                  .first
                  .title
                  .toLowerCase() ==
              'any other' ||
          checkBoxListTileModel!
                  .where((element) => element.id == id)
                  .first
                  .title
                  .toLowerCase() ==
              'other') {
        _otherTextController.clear();
      }
      selectedMultiSelectionChipList = checkBoxListTileModel!
          .where((element) => element.isCheck == true)
          .toList();
      selectedMultiSelectionChipList!.sort((a, b) {
        int orderA = selectionOrderMap[a.id] ?? 0;
        int orderB = selectionOrderMap[b.id] ?? 0;
        return orderA.compareTo(orderB);
      });

      _removableChipProvider.notifyListener();

      widget.onSelectionChanged(
        selectedList: selectedMultiSelectionChipList!,
        otherValue: _otherTextController.text.trim().isNotEmpty
            ? _otherTextController.text.toString().trim()
            : null,
      );
    } catch (e) {
      CustomLogger.logPrint('exception in delete chip $e');
      resetTraineeSearchList();
      setSelectedList();
      checkBoxListTileModel!
              .where((element) => element.id == id)
              .first
              .isCheck =
          false;
      if (id != null) {
        selectionOrderMap.remove(id);
      }
      if (checkBoxListTileModel!
                  .where((element) => element.id == id)
                  .first
                  .title
                  .toLowerCase() ==
              'any other' ||
          checkBoxListTileModel!
                  .where((element) => element.id == id)
                  .first
                  .title
                  .toLowerCase() ==
              'other') {
        _otherTextController.clear();
      }
      selectedMultiSelectionChipList = checkBoxListTileModel!
          .where((element) => element.isCheck == true)
          .toList();
      selectedMultiSelectionChipList!.sort((a, b) {
        int orderA = selectionOrderMap[a.id] ?? 0;
        int orderB = selectionOrderMap[b.id] ?? 0;
        return orderA.compareTo(orderB);
      });
      _removableChipProvider.notifyListener();
      widget.onSelectionChanged(
        selectedList: selectedMultiSelectionChipList!,
        otherValue: _otherTextController.text.trim().isNotEmpty
            ? _otherTextController.text.toString().trim()
            : null,
      );
    }
  }

  _buildBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes().bottomSheetCornerRadius),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateBottomSheet) {
              return DraggableScrollableSheet(
                expand: false,
                maxChildSize: 1.0,
                minChildSize: 0.8,
                initialChildSize: 0.8,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Consumer<ChipStateManageProvider>(
                    builder: (context, removableChipProvider, child) {
                      return Column(
                        children: <Widget>[
                          Container(
                            padding: MarginPadding().xmediumLeftRightTop,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  AppSizes().bottomSheetCornerRadius,
                                ),
                                topRight: Radius.circular(
                                  AppSizes().bottomSheetCornerRadius,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText.smallBrandSecondaryBold(
                                      widget.title,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                if (widget.showSearchBar)
                                  CustomSearch(
                                    onChanged:
                                        context
                                                .watch<
                                                  ChipStateManageProvider
                                                >()
                                                .isNetworkConnected &&
                                            widget.onChanged != null
                                        ? (searchKeyWord) {
                                            widget.onChanged!(searchKeyWord);
                                            _removableChipProvider
                                                .notifyListener();
                                          }
                                        : (searchKeyWord) {
                                            searchOnList(
                                              searchKeyWord: searchKeyWord
                                                  .toLowerCase(),
                                            );
                                            _removableChipProvider
                                                .notifyListener();
                                          },
                                  ),
                              ],
                            ),
                          ),
                          if (widget.showSearchBar) Spacing().smallVertical,
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: checkBoxListTileModel!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CheckBoxListTileWidget(
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        top: 2,
                                        bottom: 2,
                                      ),
                                      onChanged: (val) {
                                        if (widget.isNotApplicable == true) {
                                          if (index == 0) {
                                            for (var element
                                                in checkBoxListTileModel!) {
                                              element.isCheck = false;
                                              selectionOrderMap.clear();
                                              selectionCounter = 0;
                                            }
                                            checkBoxListTileModel![index]
                                                    .isCheck =
                                                val!;
                                            if (val) {
                                              selectionOrderMap[checkBoxListTileModel![index]
                                                      .id] =
                                                  selectionCounter++;
                                            }
                                            _removableChipProvider
                                                .notifyListener();
                                          } else {
                                            checkBoxListTileModel![0].isCheck =
                                                false;
                                            selectionOrderMap.remove(
                                              checkBoxListTileModel![0].id,
                                            );
                                            checkBoxListTileModel![index]
                                                    .isCheck =
                                                val!;
                                            if (val) {
                                              selectionOrderMap[checkBoxListTileModel![index]
                                                      .id] =
                                                  selectionCounter++;
                                            } else {
                                              selectionOrderMap.remove(
                                                checkBoxListTileModel![index]
                                                    .id,
                                              );
                                            }
                                            _removableChipProvider
                                                .notifyListener();
                                          }
                                          checkBoxListTileModel![index]
                                                  .isCheck =
                                              val;
                                          setTempCheckedValues();
                                          _removableChipProvider
                                              .notifyListener();
                                        } else {
                                          if (widget.recordLimit != null) {
                                            if ((selectedMultiSelectionChipTempList!
                                                        .length <
                                                    widget.recordLimit!) &&
                                                val == true) {
                                              checkBoxListTileModel![index]
                                                      .isCheck =
                                                  val!;
                                              selectionOrderMap[checkBoxListTileModel![index]
                                                      .id] =
                                                  selectionCounter++;

                                              setTempCheckedValues();
                                              _removableChipProvider
                                                  .notifyListener();
                                            } else if (val == false) {
                                              checkBoxListTileModel![index]
                                                      .isCheck =
                                                  val!;
                                              selectionOrderMap.remove(
                                                checkBoxListTileModel![index]
                                                    .id,
                                              );

                                              setTempCheckedValues();
                                              _removableChipProvider
                                                  .notifyListener();
                                            } else {
                                              widget.recordLimitErrorMessage!
                                                  .showAsToast(
                                                    context: context,
                                                    type: ToastType.TOAST_ERROR,
                                                  );
                                            }
                                          } else {
                                            checkBoxListTileModel![index]
                                                    .isCheck =
                                                val!;
                                            if (val) {
                                              selectionOrderMap[checkBoxListTileModel![index]
                                                      .id] =
                                                  selectionCounter++;
                                            } else {
                                              selectionOrderMap.remove(
                                                checkBoxListTileModel![index]
                                                    .id,
                                              );
                                            }

                                            setTempCheckedValues();
                                            _removableChipProvider
                                                .notifyListener();
                                          }
                                        }
                                        if (checkBoxListTileModel![index].title
                                                    .toLowerCase() ==
                                                'other' ||
                                            checkBoxListTileModel![index].title
                                                    .toLowerCase() ==
                                                'any other') {
                                          _otherTextController.clear();
                                        }
                                      },
                                      title:
                                          checkBoxListTileModel![index]
                                                  .subTitle !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText.smallGreyMedium(
                                                  checkBoxListTileModel![index]
                                                      .title
                                                      .toBeginningOfSentence(),
                                                ),
                                                Spacing().xsmallVertical,
                                                AppText.smallGreyG1Regular(
                                                  checkBoxListTileModel![index]
                                                      .subTitle!
                                                      .toBeginningOfSentence(),
                                                ),
                                              ],
                                            )
                                          : AppText.smallGreyMedium(
                                              checkBoxListTileModel![index]
                                                  .title
                                                  .toBeginningOfSentence(),
                                            ),
                                      isCheck:
                                          checkBoxListTileModel![index].isCheck,
                                    ),
                                    if (checkBoxListTileModel![index].title
                                                .toLowerCase() ==
                                            'other' ||
                                        checkBoxListTileModel![index].title
                                                    .toLowerCase() ==
                                                'any other' &&
                                            checkBoxListTileModel![index]
                                                .isCheck) ...{
                                      Padding(
                                        padding: MarginPadding().smallLeftRight,
                                        child: CustomTextFormField(
                                          textInputType: TextInputType.text,
                                          hinttext: 'Other',
                                          controller: _otherTextController,
                                        ),
                                      ),
                                    },
                                  ],
                                );
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: MarginPadding().mediumAll,
                              child: Column(
                                children: [
                                  const HorizontalDivider(
                                    dividerMargin: EdgeInsets.zero,
                                  ),
                                  CustomListExpansionTile(
                                    trailing: Container(),
                                    title: AppText.smallBrandSecondaryBold(
                                      '${widget.expansionTileTitle ?? 'Selected Items'} ${selectedMultiSelectionChipTempList!.isNotEmpty ? '(${selectedMultiSelectionChipTempList!.length})' : ''}',
                                    ),
                                    initiallyExpanded: false,
                                    children:
                                        selectedMultiSelectionChipTempList!
                                            .isNotEmpty
                                        ? [
                                            ListView.builder(
                                              controller: scrollController,
                                              shrinkWrap: true,
                                              itemCount:
                                                  selectedMultiSelectionChipTempList!
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: MarginPadding()
                                                      .xxsmallBottom,
                                                  child: AppText.xsmallGreyG1Regular(
                                                    selectedMultiSelectionChipTempList![index]
                                                        .title,
                                                  ),
                                                );
                                              },
                                            ),
                                          ]
                                        : [
                                            Column(
                                              children: [
                                                if (checkBoxListTileModel!
                                                        .where(
                                                          (element) =>
                                                              element.isCheck ==
                                                              true,
                                                        )
                                                        .toList()
                                                        .isEmpty &&
                                                    widget.recordLimitErrorMessage !=
                                                        null) ...{
                                                  AppText.xsmallGreyG1Regular(
                                                    widget
                                                        .recordLimitErrorMessage,
                                                  ),
                                                },
                                              ],
                                            ),
                                          ],
                                  ),
                                  //},
                                  AppButton(
                                    buttonName: AppStrings().addToList
                                        .toUpperCase(),
                                    backgroundColor: AppColors.color_primary,
                                    onPressed: () {
                                      //_removableChipProvider.onButtonClickMultiSelectChip();
                                      // selectedMultiSelectionChipList =
                                      //     checkBoxListTileModel!
                                      //         .where((element) =>
                                      //             element.isCheck == true)
                                      //         .toList();
                                      if (widget.recordLimit != null &&
                                          selectedMultiSelectionChipTempList!
                                                  .length >
                                              widget.recordLimit!) {
                                        widget.recordLimitErrorMessage!
                                            .showAsToast(
                                              context: context,
                                              type: ToastType.TOAST_ERROR,
                                            );
                                      } else {
                                        setCheckedValues();
                                        // widget.onSelectionChanged(
                                        //     selectedMultiSelectionChipList!);
                                        _removableChipProvider.notifyListener();
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void searchOnList({String? searchKeyWord}) {
    if (searchKeyWord == null || searchKeyWord.isEmpty) {
      checkBoxListTileModel = List.from(widget.checkBoxListTileModel);
    } else {
      List<CheckBoxListTileModel> searchList = List.from(
        widget.checkBoxListTileModel,
      );

      // Filter list with startsWith and remove duplicates by id
      final Map<String, CheckBoxListTileModel> uniqueMap = {};
      for (var item in searchList) {
        if (item.title.toLowerCase().startsWith(searchKeyWord.toLowerCase())) {
          if (!uniqueMap.containsKey(item.id)) {
            uniqueMap[item.id] = item;
          }
        }
      }

      checkBoxListTileModel = uniqueMap.values.toList();

      // Optionally, sort by string length to show shortest best matches first
      checkBoxListTileModel!.sort(
        (a, b) => a.title.length.compareTo(b.title.length),
      );
    }

    _removableChipProvider.notifyListener();
  }

  void resetTraineeSearchList() {
    //traineesList?.clear();
    checkBoxListTileModel = widget.checkBoxListTileModel;
    _removableChipProvider.notifyListener();
  }

  void setCheckedValues() {
    List<CheckBoxListTileModel> chekedItemList = [];
    //CustomLogger.logPrint('selected initialValue value list ${widget.initialValue!.length}');
    //CustomLogger.logPrint('selected value list ${widget.checkBoxListTileModel.where((element) => element.isCheck).length}');
    for (var element in widget.checkBoxListTileModel) {
      if (element.isCheck) {
        chekedItemList.add(element);
      }
    }
    checkBoxListTileModel = chekedItemList;
    selectedMultiSelectionChipList = [];
    selectedMultiSelectionChipList = List.from(
      selectedMultiSelectionChipTempList!,
    );
    selectedMultiSelectionChipList!.sort((a, b) {
      int orderA = selectionOrderMap[a.id] ?? 0;
      int orderB = selectionOrderMap[b.id] ?? 0;
      return orderA.compareTo(orderB);
    });

    widget.onSelectionChanged(
      selectedList: selectedMultiSelectionChipList!,
      otherValue: _otherTextController.text.trim().isNotEmpty
          ? _otherTextController.text.toString().trim()
          : null,
    );
  }

  void setTempCheckedValues() {
    selectedMultiSelectionChipTempList = [];
    List<CheckBoxListTileModel> checkedItemList = [];
    // CustomLogger.logPrint(
    //     'selected initialValue value list ${widget.initialValue!.length}');
    //CustomLogger.logPrint('selected value list ${widget.checkBoxListTileModel.where((element) => element.isCheck).length}');
    for (var element in widget.checkBoxListTileModel) {
      if (element.isCheck) {
        checkedItemList.add(element);
      }
    }
    selectedMultiSelectionChipTempList = List.from(checkedItemList);
    selectedMultiSelectionChipTempList!.sort((a, b) {
      int orderA = selectionOrderMap[a.id] ?? 0;
      int orderB = selectionOrderMap[b.id] ?? 0;
      return orderA.compareTo(orderB);
    });

    CustomLogger.logPrint(
      'selected initialValue selectedMultiSelectionChipTempList ${selectedMultiSelectionChipTempList!.length}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            resetTraineeSearchList();
            setSelectedList();
            _buildBottomSheet();
          },
          child: Consumer<ChipStateManageProvider>(
            builder: (context, removableChipProvider, _) {
              return Container(
                width: double.infinity,
                height:
                    widget.isFixedHeight &&
                        selectedMultiSelectionChipList!.isNotEmpty
                    ? 150
                    : null,
                padding: MarginPadding().mediumLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSizes().dropDownCornerRadius,
                  ),
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.text_grey_g2,
                    width: AppSizes().dropDownBorderWidth,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Expanded(
                        child:
                            selectedMultiSelectionChipList != null &&
                                selectedMultiSelectionChipList!.isNotEmpty
                            ? Wrap(
                                spacing: 10,
                                children: selectedMultiSelectionChipList!
                                    .map(
                                      (chip) => Chip(
                                        shape: const StadiumBorder(
                                          side: BorderSide(
                                            color: AppColors.color_primary,
                                          ),
                                        ),
                                        key: ValueKey(randomAlphaNumeric(4)),
                                        label: Text(
                                          chip.title,
                                          style: TextStyle(
                                            color: AppColors.text_grey,
                                            fontSize: TextSize().small,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        deleteIcon: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.clear, size: 14),
                                        ),
                                        deleteIconColor:
                                            AppColors.color_primary,
                                        backgroundColor:
                                            AppColors.derived_color_one,
                                        onDeleted: () =>
                                            _deleteChip(id: chip.id),
                                      ),
                                    )
                                    .toList(),
                              )
                            : Text(
                                widget.title,
                                style: FormTextStyles.textFormFieldHintStyle,
                              ),
                      ),
                      Padding(
                        padding: MarginPadding().mediumAll,
                        child: AppIcon(
                          icon: AppIcons().ic_arrow_down,
                          iconHeight: IconSize().large,
                          iconWidth: IconSize().large,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
