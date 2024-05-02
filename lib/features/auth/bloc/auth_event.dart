part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String fName;
  final String lName;
  final String email;
  final String password;

  AuthSignUpEvent(
      {required this.fName,
      required this.lName,
      required this.email,
      required this.password});
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});
}
