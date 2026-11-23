part of 'home_cubit.dart';

sealed class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeDashboard dashboard;

  HomeSuccess(this.dashboard);
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
