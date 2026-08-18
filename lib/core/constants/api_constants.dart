class ApiConstants {
  static const bool isDev = true;

  static const String devBaseUrl = '';
  static const String prodBaseUrl = '';

  static String get baseUrl => isDev ? devBaseUrl : prodBaseUrl;

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}