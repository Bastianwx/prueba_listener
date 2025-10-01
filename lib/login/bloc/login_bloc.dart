import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      // Simulación de login
      await Future.delayed(Duration(seconds: 2));

      if (event.email == 'sebas@gmail.com' && event.password == '123456') {
        emit(LoginSuccess(email: event.email, password: event.password));
      } else {
        emit(LoginError(message: 'Credenciales inválidas'));
      }
    });
  }
}
