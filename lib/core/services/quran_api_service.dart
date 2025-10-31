import 'package:flutter_antonx_boilerplate/core/models/quran_verse_model.dart';
import 'package:flutter_antonx_boilerplate/core/services/api_services.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';

class QuranApiService {
  final ApiServices _apiServices = locator<ApiServices>();

  Future<List<QuranVerse>> fetchQuranData() async {
    try {
      final arabicRes = await _apiServices.get(
        endPoint: 'https://api.alquran.cloud/v1/quran/quran-simple',
      );

      final englishRes = await _apiServices.get(
        endPoint: 'https://api.alquran.cloud/v1/quran/en.asad',
      );

      final arabicSurahs = arabicRes.data['data']['surahs'];
      final englishSurahs = englishRes.data['data']['surahs'];

      List<QuranVerse> verses = [];

      for (int s = 0; s < arabicSurahs.length; s++) {
        final arabicAyahs = arabicSurahs[s]['ayahs'];
        final englishAyahs = englishSurahs[s]['ayahs'];

        for (int i = 0; i < arabicAyahs.length; i++) {
          verses.add(
            QuranVerse.fromApi(
              arabicData: arabicAyahs[i],
              englishData: englishAyahs[i],
            ),
          );
        }
      }

      return verses;
    } catch (e) {
      throw Exception("Failed to load Quran data: $e");
    }
  }
}
