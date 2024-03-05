import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  
  final String fullname;
  final String? userType;
  final String username;
  final String? image;
  final String email;
  final String password;

  const AuthEntity({
    this.id,
    this.userType,
    required this.fullname,
    required this.username,
    this.image,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id,fullname, userType,username, image, email, password];
}
