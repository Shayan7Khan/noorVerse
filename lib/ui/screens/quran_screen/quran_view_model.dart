import 'package:flutter_antonx_boilerplate/core/others/base_view_model.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/quran_screen/dummy_data.dart';

class QuranViewModel extends BaseViewModel {
  String _searchText = '';
  String get searchText => _searchText;

  List get filteredVerses {
    return dummyQuranVerses.where((verse) {
      return verse.title.toLowerCase().contains(_searchText.toLowerCase()) ||
          verse.surahName.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
  }

  void updateSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }
}
