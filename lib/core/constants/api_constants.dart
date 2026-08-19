class ApiConstants {
  // pencegahan class ini di-instansiasi
  ApiConstants._();

  static const bool isDev = true;

  static const String devBaseUrl = '';
  static const String prodBaseUrl = '';

  static String get baseUrl => isDev ? devBaseUrl : prodBaseUrl;

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  static const Endpoints endpoints = Endpoints._();
}

class Endpoints {
  const Endpoints._();

  final String login = "/login";
}