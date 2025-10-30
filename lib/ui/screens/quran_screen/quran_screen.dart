import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/constants/colors.dart';
import 'package:flutter_antonx_boilerplate/core/constants/styles.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/detail_screen/detail_screen.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/quran_screen/quran_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuranViewModel(),
      child: Consumer<QuranViewModel>(
        builder: (context, model, child) {
          final filteredVerses = model.filteredVerses;
          return SafeArea(
            child: Scaffold(
              backgroundColor: scaffoldBackgroundColor,
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
                            child: Text('Quran', style: titleStyle),
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
                        cursorColor: primaryColor,
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search Surah or Verse...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                        ),
                        onChanged: model.updateSearchText,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 250.h,
                    left: 10.w,
                    right: 10.w,
                    bottom: 0,
                    child: ListView.builder(
                      itemCount: filteredVerses.length,
                      itemBuilder: (context, index) {
                        final verse = filteredVerses[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () {
                              Get.to(
                                DetailScreen(
                                  title: verse.title,
                                  mainText: verse.arabicText,
                                  translation: verse.englishTranslation,
                                  verseNumber: verse.verseNumber,
                                  surahName: verse.surahName,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color:primaryColor.withValues(alpha: 0.7)
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          verse.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "${verse.surahName} (${verse.verseNumber})",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white54,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
