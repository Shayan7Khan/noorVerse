import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/colors.dart';
import 'package:flutter_antonx_boilerplate/core/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String mainText;
  final String translation;
  final String? reference;
  final String? surahName;
  final int? verseNumber;
  final String? narrator;
  final String backgroundImage;

  const DetailScreen({
    super.key,
    required this.title,
    required this.mainText,
    required this.translation,
    this.reference,
    this.surahName,
    this.verseNumber,
    this.narrator,
    this.backgroundImage = 'assets/images/home_background.png',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(backgroundImage, fit: BoxFit.cover),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: primaryColor,
                        ),
                        onPressed: () => Get.back()
                      ),
                      Expanded(
                        child: Center(
                          child: Text(title, style: appWideTextEnglish.copyWith(color: primaryColor)),
                        ),
                      ),
                      38.horizontalSpace,
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: primaryColor,
                              width: 1.2.w,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (surahName != null || verseNumber != null)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Text(
                                    '${surahName ?? ''}${ ' • ' }${verseNumber ?? ''}',
                                    style: appWideTextArabic.copyWith(fontSize: 16.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              Text(
                                mainText,
                                textAlign: TextAlign.center,
                                style: appWideTextArabic,
                              ),

                              20.verticalSpace,
                              Divider(color: primaryColor),
                              20.verticalSpace,
                              Text(
                                translation,
                                textAlign: TextAlign.center,
                                style: appWideTextEnglish.copyWith(fontSize: 20),
                              ),
                              if (reference != null) ...[
                                20.verticalSpace,
                                Text(
                                  reference!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: primaryColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],

                              if (narrator != null) ...[
                                10.verticalSpace,
                                Text(
                                  narrator!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white70,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
