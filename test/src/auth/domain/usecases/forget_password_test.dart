import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late ForgotPassword usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = ForgotPassword(repo);
  });

  group('Tests call the [AuthRepo.forgotPassword]', () {
    test('should call the [AuthRepo.forgotPassword] - failure', () async {
      when(() => repo.forgotPassword('email')).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Unknown Error',
            statusCode: 500,
          ),
        ),
      );

      final result = await usecase('email');

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

      verify(() => repo.forgotPassword('email')).called(1);
      verifyNoMoreInteractions(repo);
    });

    test('should call the [AuthRepo.forgotPassword] - success', () async {
      when(() => repo.forgotPassword(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase('email');

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => repo.forgotPassword('email')).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
