import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeFetchData>((event, emit) async {
      emit(HomeLoading());

      // delay para simular tiempo de carga
      await Future.delayed(const Duration(seconds: 3));

      try {
        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final phone = data['phone'];
          final website = data['website'];


          emit(HomeLoaded(
            phone: phone,
            website: website,
          ));
        } else {
          emit(HomeError());
        }
      } catch (e) {
        emit(HomeError());
      }
    });
  }
}
