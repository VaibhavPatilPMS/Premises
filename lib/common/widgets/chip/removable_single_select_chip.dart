import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/common/models/models.dart';
import 'package:premises/common/widgets/widgets.dart';
import 'package:premises/common/resources/resources.dart';

class RemovableSingleSelectChipWidget extends StatefulWidget {
  final List<RadioButtonListTileModel> radioListTileModelList;
  final String title;
  final RadioButtonListTileModel? initialValue;
  final Function(RadioButtonListTileModel? selectedItem) onSelectionChanged;
  final bool showSearchBar;

  const RemovableSingleSelectChipWidget({
    super.key,
    required this.title,
    required this.radioListTileModelList,
    required this.initialValue,
    required this.onSelectionChanged,
    this.showSearchBar = false,
  });

  @override
  State<RemovableSingleSelectChipWidget> createState() =>
      _RemovableSingleSelectChipWidget();
}

class _RemovableSingleSelectChipWidget
    extends State<RemovableSingleSelectChipWidget> {
  late List<RadioButtonListTileModel>? radioListTileList = [];
  late ChipStateManageProvider _removableChipProvider;
  int? selectedRadioListTileIndex = -1;
  RadioButtonListTileModel? selectedRadioListTile;
  List<RadioButtonListTileModel>? selectedSingleSelectionList = [];

  @override
  void initState() {
    radioListTileList!.addAll(widget.radioListTileModelList);
    _removableChipProvider =
        Provider.of<ChipStateManageProvider>(context, listen: false);
    setInitialSelectedRadioTile();
    super.initState();
  }

  void setInitialSelectedRadioTile() {
    if (widget.initialValue != null) {
      for (int i = 0; i < radioListTileList!.length; i++) {
        if (widget.initialValue!.title == radioListTileList![i].title) {
          radioListTileList![i].isCheck = true;
          selectedRadioListTileIndex = i;
          selectedSingleSelectionList!.add(radioListTileList![i]);
        }
      }
    }
  }

  void _deleteSingleSelectionChip(int id) {
    for (var element in radioListTileList!) {
      element.isCheck = false;
    }
    selectedRadioListTileIndex = -1;
    selectedRadioListTile = null;
    selectedSingleSelectionList!.clear();
    widget.onSelectionChanged(selectedRadioListTile);
    _removableChipProvider.notifyListener();
  }

  void setSelectedRadioTile(
      int index, ChipStateManageProvider chipStateManageProvider) {
    for (var element in radioListTileList!) {
      element.isCheck = false;
    }
    radioListTileList![index].isCheck = true;
    selectedRadioListTileIndex = index;
    // widget.onSelectionChanged(radioListTileList![index]);
    chipStateManageProvider.notifyListener();
  }

  _buildBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes().bottomSheetCornerRadius)),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return DraggableScrollableSheet(
                  expand: false,
                  maxChildSize: 0.9,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Consumer<ChipStateManageProvider>(
                      builder: (context, removableChipProvider, child) {
                        return Column(children: <Widget>[
                          Padding(
                            padding: MarginPadding().xmediumLeftRightTop,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText.smallBrandSecondaryBold(
                                        widget.title),
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
                                    onChanged: (searchKeyWord) {
                                      radioListTileList = widget
                                          .radioListTileModelList
                                          .where((user) => user.title
                                              .toLowerCase()
                                              .contains(
                                                  searchKeyWord.toLowerCase()))
                                          .toList();
                                      _removableChipProvider.notifyListener();
                                    },
                                  ),
                              ],
                            ),
                          ),
                          if (widget.showSearchBar) Spacing().smallVertical,
                          Expanded(
                            child: ListView.builder(
                                controller: scrollController,
                                itemCount: radioListTileList!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: MarginPadding().xxsmallTopBottom,
                                    child: RadioButtonListTileWidget(
                                      onChanged: (val) {
                                        setSelectedRadioTile(
                                            index, removableChipProvider);
                                      },
                                      title: radioListTileList![index]
                                                  .subTitle !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                  AppText.smallGreyMedium(
                                                      radioListTileList![index]
                                                          .title
                                                          .toBeginningOfSentence()),
                                                  Spacing().xsmallVertical,
                                                  AppText.smallGreyG1Regular(
                                                      radioListTileList![index]
                                                          .subTitle!
                                                          .toBeginningOfSentence()),
                                                ])
                                          : AppText.smallGreyMedium(
                                              radioListTileList![index]
                                                  .title
                                                  .toBeginningOfSentence()),
                                      isCheck:
                                          radioListTileList![index].isCheck,
                                      index: index,
                                      selectedIndex:
                                          selectedRadioListTileIndex!,
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: MarginPadding().mediumAll,
                            child: AppButton(
                                buttonName:
                                    AppStrings().addToList.toUpperCase(),
                                backgroundColor: AppColors.color_primary,
                                onPressed: () {
                                  selectedRadioListTile = radioListTileList!
                                      .firstWhere(
                                          (element) => element.isCheck == true);
                                  selectedSingleSelectionList =
                                      radioListTileList!
                                          .where((element) =>
                                              element.isCheck == true)
                                          .toList();
                                  widget.onSelectionChanged(
                                      selectedRadioListTile!);
                                  _removableChipProvider.notifyListener();
                                  Navigator.pop(context);
                                }),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).padding.bottom),
                        ]);
                      },
                    );
                  });
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            radioListTileList!.clear();
            radioListTileList!.addAll(widget.radioListTileModelList);
            FocusManager.instance.primaryFocus?.unfocus();
            _buildBottomSheet();
          },
          child: Consumer<ChipStateManageProvider>(
            builder: (context, removableChipProvider, _) {
              return Container(
                width: double.infinity,
                height: AppSizes().defaultButtonHeight,
                padding: MarginPadding().mediumLeft,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppSizes().dropDownCornerRadius),
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.text_grey_g2,
                    width: AppSizes().dropDownBorderWidth,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: selectedSingleSelectionList != null &&
                              selectedSingleSelectionList!.isNotEmpty
                          ? Wrap(
                              spacing: 10,
                              children: selectedSingleSelectionList!
                                  .map((chip) => Chip(
                                        shape: const StadiumBorder(
                                          side: BorderSide(
                                              color: AppColors.color_primary),
                                        ),
                                        key: ValueKey(chip.id),
                                        label: Text(
                                          chip.title,
                                          style: TextStyle(
                                              color: AppColors.text_grey,
                                              fontSize: TextSize().small,
                                              fontWeight: FontWeight.w400),
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
                                            _deleteSingleSelectionChip(
                                                chip.id!),
                                      ))
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
              );
            },
          ),
        ),
      ],
    );
  }
}
