import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';

class AppLogger {
  AppLogger._privateConstructor();
  static final AppLogger _instance = AppLogger._privateConstructor();
  static AppLogger get instance => _instance;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart
    )
  );

  void debug(String message, [dynamic error, StackTrace? trace]) {
    _logger.d("${DateTime.now()} => message", error: error, stackTrace: trace);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message, [dynamic error, StackTrace? trace]) {
    if(kDebugMode) {
      _logger.w(message, error: error, stackTrace: trace);
    } else {
      // prodcution release mode kirim warning ke FirebaseCrashlytic
    }
  }

  void error(String message, [dynamic error, StackTrace? trace]) {
    if(kDebugMode) {
      _logger.e(message, error: error, stackTrace: trace);
    } else {
      // prodcution release mode kirim warning ke FirebaseCrashlytic
    }
  }
}