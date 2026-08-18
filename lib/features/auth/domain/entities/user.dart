import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String name;
  final String accessToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.accessToken,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, username, email, name, accessToken];
}