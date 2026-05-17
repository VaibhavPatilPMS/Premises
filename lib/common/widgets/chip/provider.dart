import 'package:premises/common/base/base.dart';
import 'package:premises/common/models/models.dart';

class ChipStateManageProvider extends BaseProvider {
  //For Multi Selection
  List<CheckBoxListTileModel>? checkBoxListTileModel = [];
  List<CheckBoxListTileModel>? selectedMultiSelectionChipList = [];

  //For Single Selection
  List<RadioButtonListTileModel>? radioListTileModelList = [];
  List<RadioButtonListTileModel>? selectedSingleSelectionList = [];
  RadioButtonListTileModel? selectedRadioListTile;
  int? selectedRadioLitTile = -1;

  updateMultiCheckSelection({required bool? value, required int index}) {
    checkBoxListTileModel![index].isCheck = value!;
    notifyListeners();
  }

  deleteSelectedMultiChip({required int id}) {
    checkBoxListTileModel!.where((element) => element.id == id).first.isCheck =
        false;
    selectedMultiSelectionChipList = checkBoxListTileModel!
        .where((element) => element.isCheck == true)
        .toList();
    notifyListeners();
  }

  onButtonClickMultiSelectChip() {
    selectedMultiSelectionChipList = checkBoxListTileModel!
        .where((element) => element.isCheck == true)
        .toList();
    notifyListeners();
  }

  void setSelectedRadioTile(int val, int index) {
    selectedRadioLitTile = val;
    for (var element in radioListTileModelList!) {
      element.isCheck = false;
    }
    radioListTileModelList![index].isCheck = true;
    selectedRadioListTile != radioListTileModelList![index];
    notifyListeners();
  }

  onButtonClickSingleSelectChip() {
    selectedSingleSelectionList = radioListTileModelList!
        .where((element) => element.isCheck == true)
        .toList();
    notifyListeners();
  }

  deleteSelectedSingleChip({required int id}) {
    for (var element in radioListTileModelList!) {
      element.isCheck = false;
    }
    selectedRadioLitTile = -1;
    selectedRadioListTile = null;
    selectedSingleSelectionList!.clear();
    notifyListeners();
  }

  void notifyListener() {
    notifyListeners();
  }
}
