import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/styles.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/onboarding/onboarding_view_model.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/root/root_screen.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/root/root_screen_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

///
/// Flow logic is already done. Just need
/// to add the UI and UI Logic.
///

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('@onboardingScreen');
    return ChangeNotifierProvider(
      create: (context) =>
          // ignore: unnecessary_this
          OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, model, child) => SafeArea(
          child: SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF202020),
        body: Column(
          children: [
            SizedBox(
              height: 200.h,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/background_image_2.png',
                    height: 180.h,
                    width: 291.w,
                  ),
                   Positioned(
                    bottom: 30.h,
                    child: Text(
                      'NoorVerse',
                      style: titleStyle,
                    ),
                  ),
                ],
              ),
            ),
            35.verticalSpace,
             Image.asset(
              'assets/images/onboarding_image.png',
              height: 350.25.h,
              width: 366.67.w,
            ),
            120.verticalSpace,
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE2BE7F),
                foregroundColor: Colors.black,
                minimumSize: Size(300.w, 55.h),
                elevation: 6,
                shadowColor: Colors.black.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              onPressed: () {
               Get.to(() => ChangeNotifierProvider(
                 create: (_) => RootScreenViewModel(),
                 child: const RootScreen(),
               ));
              },
              child: Text(
                'Get Started',
                style: appWideTextEnglish.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    ))));
  }
      
  
  }

