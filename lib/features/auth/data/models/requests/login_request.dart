class LoginRequest {
  final String login;
  final String password;
  final bool isRememberMe;

  LoginRequest({required this.login, required this.password, required this.isRememberMe});

  Map<String, dynamic> toJson() => {
    'login': login,
    'password': password,
    'remember_me': isRememberMe
  };
}