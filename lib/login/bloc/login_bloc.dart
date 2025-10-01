import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': event.email,
            'password': event.password,
          }),
        );
        if (response.statusCode == 201) {
         
          emit(LoginSuccess(email: event.email, password: event.password));
        } else {
          emit(LoginError(message: 'Credenciales incorrectas o error del servidor.'));
        }
  
      } catch (e) {
        emit(LoginError(message: 'Error de red: ${e.toString()}'));
      }
      
    });
  }
}
