import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  // dependency
  late OnBoardingRepo repo;

  // class
  late CacheFirstTimer usecase;

  // initialization
  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] '
    'and return the right data',
    () async {
      // stub
      when(() => repo.cacheFirstTiemr()).thenAnswer(
        (_) async =>
            Left(ServerFailure(message: 'Unknown Error', statusCode: 500)),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              message: 'Unknown Error',
              statusCode: 500,
            ),
          ),
        ),
      );

      verify(() => repo.cacheFirstTiemr()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
