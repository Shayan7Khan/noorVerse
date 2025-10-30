import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/colors.dart';
import 'package:flutter_antonx_boilerplate/core/constants/styles.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/detail_screen/detail_screen.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/hadith_screen/hadith_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HadithViewModel(),
      child: Consumer<HadithViewModel>(
        builder: (context, model, child) {
          final filteredHadiths = model.filteredHadiths;
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/home_background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  child: SizedBox(
                    height: 200.h,
                    width: 435.w,
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
                          child: Text('Hadith', style: titleStyle),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 192.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: primaryColor),
                      
                    ),
                    child: TextField(
                      onChanged: model.updateSearchText,
                      cursorColor: primaryColor,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search Hadith',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 250.h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: filteredHadiths.length,
                    itemBuilder: (context, index) {
                      final hadith = filteredHadiths[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            DetailScreen(
                              title: hadith.title,
                              mainText: hadith.arabicText,
                              translation: hadith.englishTranslation,
                              reference: hadith.reference,
                              narrator: hadith.narrator,
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Text(
                            hadith.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
