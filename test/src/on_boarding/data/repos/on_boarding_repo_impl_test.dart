import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSoruce {}

void main() {
  late OnBoardingLocalDataSoruce localDataSoruce;
  late OnBoardingRepoImpl repoImpl;

  setUp(() {
    localDataSoruce = MockOnBoardingLocalDataSrc();
    repoImpl = OnBoardingRepoImpl(localDataSoruce);
  });

  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepoImpl>());
  });

  group('cacheFirstTimer', () {
    // success
    test('should complete successfully when call to local source successful',
        () async {
      // Future.value() is a way to create a completed future
      // with no specific value
      when(() => localDataSoruce.cacheFirstTimer()).thenAnswer(
        (_) async => Future.value(),
      );

      final result = await repoImpl.cacheFirstTiemr();

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDataSoruce.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSoruce);
    });

    test(
        'should return [CacheFailure] when call to '
        'local source is unsuccessfull', () async {
      when(() => localDataSoruce.cacheFirstTimer()).thenThrow(
        const CacheException(message: 'Insufficient storage'),
      );

      final result = await repoImpl.cacheFirstTiemr();

      expect(
        result,
        Left<CacheFailure, dynamic>(
          CacheFailure(
            message: 'Insufficient storage',
            statusCode: 500,
          ),
        ),
      );

      verify(() => localDataSoruce.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSoruce);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test('should return true when user is first timer', () async {
      when(() => localDataSoruce.checkIfUserIsFirstTimer())
          .thenAnswer((_) => Future.value(true));

      final result = await repoImpl.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => localDataSoruce.checkIfUserIsFirstTimer()).called(1);

      verifyNoMoreInteractions(localDataSoruce);
    });

    test('should return false when user is not first timer', () async {
      when(() => localDataSoruce.checkIfUserIsFirstTimer())
          .thenAnswer((_) => Future.value(false));

      final result = await repoImpl.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(false)));
      verify(() => localDataSoruce.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSoruce);
    });

    test(
        'should return CacheFailure when call to local date source '
        'is unsuccessfull', () async {
      when(() => localDataSoruce.checkIfUserIsFirstTimer()).thenThrow(
        const CacheException(
          message: 'Insufficient permission',
          statusCode: 403,
        ),
      );

      final result = await repoImpl.checkIfUserIsFirstTimer();

      expect(
        result,
        equals(
          Left<CacheFailure, bool>(
            CacheFailure(
              message: 'Insufficient permission',
              statusCode: 403,
            ),
          ),
        ),
      );
      verify(() => localDataSoruce.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSoruce);
    });
  });
}
