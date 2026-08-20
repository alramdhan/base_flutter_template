class ApiConstants {
  // pencegahan class ini di-instansiasi
  ApiConstants._();

  static const bool isDev = true;

  static const String devBaseUrl = '';
  static const String prodBaseUrl = '';

  static const String prefixBaseUrl = '/api/v1';

  static final Uri uri = Uri.https(isDev ? devBaseUrl : prodBaseUrl, prefixBaseUrl);

  // static String get baseUrl => "${isDev ? devBaseUrl : prodBaseUrl}$prefixBaseUrl";
  static String get baseUrl => uri.toString();

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  static const Endpoints endpoints = Endpoints._();
}

class Endpoints {
  const Endpoints._();

  final String login = "/login";
  final String logout = "/logout";
  final String registerBiometric = "/biometric/register";
}