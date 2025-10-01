abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomeLoaded extends HomeState {
  final String phone;
  final String website;
  
  HomeLoaded({
    required this.phone,
    required this.website,
  });
}
