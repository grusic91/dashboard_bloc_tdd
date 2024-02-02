import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFisrtTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;

  setUp(() {
    cacheFirstTimer = MockCacheFisrtTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnBoardingCubit(
      checkingIfUserIsFistTimer: checkIfUserIsFirstTimer,
      cacheFirstTimer: cacheFirstTimer,
    );
  });

  final tFailure = CacheFailure(
    message: 'Insufficient storage permissing',
    statusCode: 4032,
  );

  test('inital state should be [OnBoradingInitial]', () {
    expect(cubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [ChangingFirstTimer, OnBoardingState] when successfull',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [
        CachingFirstTimer(),
        UserCached(),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, OnBoardingError] when unsuccessfull',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimer(),
        OnBoardingError(tFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTimer())
            .thenAnswer((invocation) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFistTimer(),
        OnBoardingStatus(isFisFirstTimer: false),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus(true)] '
      'when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTimer())
            .thenAnswer((invocation) async => Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFistTimer(),
        OnBoardingStatus(isFisFirstTimer: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );
  });
}
