import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/enums/view_state.dart';
import 'package:flutter_antonx_boilerplate/core/others/base_view_model.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/hadith_screen/hadith_screen.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/quran_screen/quran_screen.dart';

class RootScreenViewModel extends BaseViewModel {
  List<Widget> allScreen = const [
    QuranScreen(),
    HadithScreen()
  ];
  int selectedScreen = 0;

  bool isEnableBottomBar = true;

  void updatedScreenIndex(int index) {
    setState(ViewState.busy);
    selectedScreen = index;
    setState(ViewState.idle);
  }

  void updateBottomBarStatus(bool val) {
    isEnableBottomBar = val;
    notifyListeners();
  }
}
