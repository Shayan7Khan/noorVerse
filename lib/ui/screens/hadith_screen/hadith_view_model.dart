import 'package:flutter_antonx_boilerplate/core/others/base_view_model.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/hadith_screen/dummy_data_hadith.dart';

class HadithViewModel extends BaseViewModel{
  String _searchText = '';
  String get searchText => _searchText;

  List get filteredHadiths {
    return dummyHadithList.where((verse) {
      return verse.title.toLowerCase().contains(_searchText.toLowerCase()) ||
          verse.title.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
  }

  void updateSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }
}