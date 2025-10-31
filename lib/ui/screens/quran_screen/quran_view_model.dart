import 'package:flutter/foundation.dart';
import 'package:flutter_antonx_boilerplate/core/others/base_view_model.dart';
import 'package:flutter_antonx_boilerplate/core/services/quran_api_service.dart';
import 'package:flutter_antonx_boilerplate/core/models/quran_verse_model.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';
import 'package:flutter_antonx_boilerplate/core/enums/view_state.dart';

class QuranViewModel extends BaseViewModel {
  final QuranApiService _quranApiService = locator<QuranApiService>();

  String _searchText = '';
  String get searchText => _searchText;

  List<QuranVerse> _quranVerses = [];
  List<QuranVerse> get quranVerses =>
      _searchText.isEmpty ? _quranVerses : _filteredVerses;

  List<QuranVerse> _filteredVerses = [];
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  QuranViewModel() {
    loadQuranData();
  }

  Future<void> loadQuranData() async {
    try {
      setState(ViewState.loading);
      _errorMessage = null;

      final verses = await _quranApiService.fetchQuranData();
      if(kDebugMode){
        print(verses);
      }
      _quranVerses = verses;
      _filteredVerses = verses; 

      setState(ViewState.idle);
      notifyListeners(); 
    } catch (e) {
      _errorMessage = 'Failed to load Quran data: ${e.toString()}';
      setState(ViewState.error);
      notifyListeners();
    }
  }

  List<QuranVerse> get filteredVerses {
    if (_searchText.isEmpty) {
      return _quranVerses;
    }

    _filteredVerses = _quranVerses.where((verse) {
      return verse.title.toLowerCase().contains(_searchText.toLowerCase()) ||
          verse.surahName.toLowerCase().contains(_searchText.toLowerCase()) ||
          verse.arabicText.toLowerCase().contains(_searchText.toLowerCase()) ||
          verse.englishTranslation.toLowerCase().contains(
            _searchText.toLowerCase(),
          );
    }).toList();

    return _filteredVerses;
  }

  void updateSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void refreshData() {
    loadQuranData();
  }
}
