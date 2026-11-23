import 'package:easy_shop_admin/core/networking/api_error_handler.dart';
import 'package:easy_shop_admin/features/home/domain/entities/home_dashboard.dart';
import 'package:easy_shop_admin/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDashboardUseCase _getHomeDashboard;

  HomeCubit(this._getHomeDashboard) : super(HomeLoading());

  Future<void> load() async {
    emit(HomeLoading());
    try {
      emit(HomeSuccess(await _getHomeDashboard()));
    } catch (error) {
      emit(HomeFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
