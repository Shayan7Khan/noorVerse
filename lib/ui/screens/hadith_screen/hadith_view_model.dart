import 'package:flutter_antonx_boilerplate/core/others/base_view_model.dart';
import 'package:flutter_antonx_boilerplate/core/services/hadith_api_service.dart';
import 'package:flutter_antonx_boilerplate/core/models/hadith_model.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';
import 'package:flutter_antonx_boilerplate/core/enums/view_state.dart';

class HadithViewModel extends BaseViewModel {
  final HadithApiService _hadithApiService = locator<HadithApiService>();

  String _searchText = '';
  String get searchText => _searchText;

  List<Hadith> _hadithList = [];
  List<Hadith> get hadithList =>
      _searchText.isEmpty ? _hadithList : _filteredHadiths;

  List<Hadith> _filteredHadiths = [];
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  HadithViewModel() {
    loadHadithData();
  }

  Future<void> loadHadithData() async {
    try {
      setState(ViewState.loading);
      _errorMessage = null;
      _hadithList = await _hadithApiService.fetchHadithList();
      setState(ViewState.idle);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load Hadith data: $e";
      setState(ViewState.error);
      notifyListeners();
    }
  }
  List<Hadith> get filteredHadiths {
    if (_searchText.isEmpty) {
      return _hadithList;
    }
    _filteredHadiths = _hadithList.where((hadith) {
      return hadith.title.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
    return _filteredHadiths;
  }
  void updateSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }
  void refreshData() {
    loadHadithData();
  }
}
