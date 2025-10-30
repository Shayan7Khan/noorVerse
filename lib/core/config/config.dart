import 'package:flutter_antonx_boilerplate/core/enums/env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  final Env _env;
   String _quranBaseUrl = '';
   String _hadithBaseUrl = '';
   String _hadithApiKey = '';
  final String _devBaseUrl = '';
  final String _testBaseUrl = '';
  final String _productionBaseUrl = '';
  late String _baseUrl;

  /// Getters
  Env get env => _env;
  String get baseUrl => _baseUrl;
  String get quranBaseUrl => _quranBaseUrl;
  String get hadithBaseUrl => _hadithBaseUrl;
  String get hadithApiKey => _hadithApiKey;

  /// Constructor
  Config(this._env) {
    _setupBaseUrl();
  }

  loadEnv() async {
    await dotenv.load(fileName: ".env");
    _quranBaseUrl = dotenv.env['Quran_Base_Url '] ?? '';
    _hadithBaseUrl = dotenv.env['Hadith_Base_Url'] ?? '';
    _hadithApiKey = dotenv.env['Hadith_Api_key'] ?? '';
  }

  
  _setupBaseUrl() {
    if (_env == Env.production) {
      _baseUrl = _productionBaseUrl;
    } else if (_env == Env.test) {
      _baseUrl = _testBaseUrl;
    } else if (_env == Env.dev) {
      _baseUrl = _devBaseUrl;
    }
  }
}
