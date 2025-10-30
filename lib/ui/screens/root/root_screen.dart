import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/colors.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/root/root_screen_view_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootScreenViewModel(),
      child: Consumer<RootScreenViewModel>(
        builder: (context, model, child) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            final status = await Get.dialog(
              AlertDialog(
                title: const Text('Caution!'),
                content: const Text(
                  'Do you really want to close the application?',
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
            );

            /// In case user has chosen not to be kept logged in,
            /// he will get logged out of the app on exit.
            // if (status && !locator<AuthService>().isRememberMe) {
            //   await locator<AuthService>().logout();
            // }

            return status;
          },
          child: SafeArea(
            child: Scaffold(
              body: model.allScreen[model.selectedScreen],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: scaffoldBackgroundColor,
                selectedItemColor: primaryColor,
                unselectedItemColor: Colors.white70,
                currentIndex: model.selectedScreen,
                onTap: model.updatedScreenIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded),
                    label: 'Quran',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book_rounded),
                    label: 'Hadith',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
