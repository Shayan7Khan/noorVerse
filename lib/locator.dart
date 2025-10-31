import 'package:flutter_antonx_boilerplate/core/config/config.dart';
import 'package:flutter_antonx_boilerplate/core/enums/env.dart';
import 'package:flutter_antonx_boilerplate/core/services/hadith_api_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/quran_api_service.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api_services.dart';

GetIt locator = GetIt.instance;

setupLocator(Env env) async {
  locator.registerSingleton(Config(env));
  
  locator.registerSingleton<ApiServices>(ApiServices());
  locator.registerSingleton<QuranApiService>(QuranApiService());
  locator.registerSingleton<HadithApiService>(HadithApiService());
}






