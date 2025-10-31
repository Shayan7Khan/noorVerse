import 'package:flutter_antonx_boilerplate/core/models/hadith_model.dart';
import 'package:flutter_antonx_boilerplate/core/services/api_services.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';

class HadithApiService {
  final String apiKey =
      r'$2y$10$hk6DmGQUmDohDf4hpapjUej5b7mY2z50DVXTbYi6KD2wQF2IcBXi';
  final ApiServices _apiServices = locator<ApiServices>();

  Future<List<Hadith>> fetchHadithList({int page = 1}) async {
    try {
      final response = await _apiServices.get(
        endPoint:
            'https://hadithapi.com/api/hadiths?apiKey=$apiKey&page=$page',
      );

      final List hadithsData = response.data["hadiths"]["data"];
      return hadithsData.map((json) => Hadith.fromApi(json)).toList();
    } catch (e) {
      throw Exception("Error fetching Hadith list: $e");
    }
  }
}



