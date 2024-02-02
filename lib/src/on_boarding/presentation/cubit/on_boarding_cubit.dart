import 'package:bloc/bloc.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CheckIfUserIsFirstTimer checkingIfUserIsFistTimer,
    required CacheFirstTimer cacheFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkingIfUserIsFistTimer = checkingIfUserIsFistTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkingIfUserIsFistTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(OnBoardingError(failure.errorMessage)),
      (success) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFistTimer());
    final result = await _checkingIfUserIsFistTimer();

    result.fold(
      (failure) => emit(const OnBoardingStatus(isFisFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFisFirstTimer: status)),
    );
  }
}
