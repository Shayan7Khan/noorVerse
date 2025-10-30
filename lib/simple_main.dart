import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/enums/env.dart';
import 'package:flutter_antonx_boilerplate/core/others/logger_customizations/custom_logger.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';
import 'package:flutter_antonx_boilerplate/simple_app.dart';

Future<void> main() async {
  final log = CustomLogger(className: 'Simple Main');

  try {
    log.i('Starting Simple Authentication Demo App');

    // Ensure Flutter binding is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Setup dependency injection
    await setupLocator(Env.development);

    log.d('Locator setup completed');

    // Run the app
    runApp(const SimpleApp(title: 'Auth Demo App'));
  } catch (e) {
    log.e("Error starting app: $e");
  }
}
