abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}

class LoginSuccess extends LoginState {
  final String email;
  final String password;

  LoginSuccess({required this.email, required this.password});
}
