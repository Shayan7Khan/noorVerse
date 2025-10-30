import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/styles.dart';
import 'package:flutter_antonx_boilerplate/core/models/other_models/onboarding.dart';
import 'package:flutter_antonx_boilerplate/core/others/logger_customizations/custom_logger.dart';
import 'package:flutter_antonx_boilerplate/core/services/auth_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/notifications_service.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/dialogs/network_error_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../locator.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final _authService = locator<AuthService>();
  // final _localStorageService = locator<LocalStorageService>();
  // final _notificationService = locator<NotificationsService>();
  // List<Onboarding> onboardingList = [];
  final Logger log = CustomLogger(className: 'Splash Screen');

  // @override
  // void didChangeDependencies() {
  //   _initialSetup();
  //   super.didChangeDependencies();
  // }

  // _initialSetup() async {
  //   await _localStorageService.init();

  //   ///
  //   /// If not connected to internet, show an alert dialog
  //   /// to activate the network connection.
  //   ///
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     Get.dialog(const NetworkErrorDialog());
  //     return;
  //   }

    ///
    ///initializing notification services
    ///

  //   await _notificationService.initConfigure();

  //   ///
  //   /// Use the below [_getOnboardingData] method if the
  //   /// onboarding is dynamic (Means onboarding data coming from
  //   /// the apis)
  //   ///
  //   onboardingList = await _getOnboardingData();

  //   ///
  //   /// Routing to the last onboarding screen user seen
  //   ///
  //   if (_localStorageService.onBoardingPageCount + 1 < onboardingList.length) {
  //     ///
  //     /// For better user experience we precache onboarding images in case
  //     /// they are coming from a remote server.
  //     /// Remove it if onboarding is static.
  //     ///
  //     final List<Image> preCachedImages =
  //         await _preCacheOnboardingImages(onboardingList);
  //     await Get.to(() => OnboardingScreen(
  //         currentIndex: _localStorageService.onBoardingPageCount,
  //         onboardingList: onboardingList,
  //         preCachedImages: preCachedImages));
  //     return;
  //   }
  //   await _authService.doSetup();

  //   ///
  //   ///checking if the user is login or not
  //   ///
  //   log.d('@_initialSetup. Login State: ${_authService.isLogin}');
  //   if (_authService.isLogin) {
  //     Get.off(() => const RootScreen());
  //   } else {
  //     Get.off(() => LoginScreen());
  //   }
  // }

  // Future<List<Image>> _preCacheOnboardingImages(
  //     List<Onboarding> onboardingList) async {
  //   List<Image> preCachedImages =
  //       onboardingList.map((e) => Image.network(e.imgUrl!)).toList();
  //   for (Image preCacheImg in preCachedImages) {
  //     await precacheImage(preCacheImg.image, context);
  //   }
  //   return preCachedImages;
  // }

  // // ignore: unused_element
  // _getOnboardingData() async {
  //   ///uncomment below code

  //   // final response = await _dbService.getOnboardingData();
  //   // if (response.success) {
  //   //   return response.onboardingsList;
  //   // } else {
  //   //   return [];
  //   // }
  //   List<Onboarding> onboardings = [];
  //   return onboardings;
  // }


@override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.off(OnboardingScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    ///
    /// Splash Screen UI goes here.
    ///
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            //background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/splash_background_image.png',
                fit: BoxFit.cover,
              ),
            ),
            //glow bulb
            Positioned(
              top: 0.h,
              left: 329.w,
              child: Image.asset('assets/images/background_image_3.png'),
            ),

            //mosque
            Positioned(
              top: 30.h,
              left: 69.w,
              right: 57.w,
              child: Image.asset('assets/images/background_image_2.png'),
            ),
            //left image
            Positioned(
              top: 187.h,
              left: 0.w,
              right: 330.w,
              child: Image.asset('assets/images/background_image_4.png'),
            ),
            //right image
            Positioned(
              top: 550.h,
              left: 329.w,
              right: 0.w,
              child: Image.asset('assets/images/background_image_5.png'),
            ),

            //bottom image
            Positioned(
              bottom: 76.h,
              left: 125.w,
              right: 125.w,
              child: Image.asset('assets/images/splash_background_2.png'),
            ),
            //center image
            Positioned(
              top: 154.86.h,
              bottom: 154.86.h,

              left: 30.w,
              right: 13,
              child: Image.asset('assets/images/background_image_6.png'),
            ),
            Positioned(
              top: 510.h,
              left: 55.w,
              child: Text(
                'NoorVerse',
                style: titleStyle.copyWith(fontSize: 80.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
