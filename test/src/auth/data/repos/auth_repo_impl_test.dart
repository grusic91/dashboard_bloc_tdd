import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/enums/update_user.dart';
import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:dashboard_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:dashboard_bloc_tdd/src/auth/data/repos/auth_repo_impl.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthRepoImpl(remoteDataSource);

    registerFallbackValue(UpdateUserAction.password);
  });

  const tEmail = 'Test Email';
  const tPassword = 'Test Password';
  const tFullName = 'Test FullName';
  const tUpdateAction = UpdateUserAction.password;
  const tUserData = 'New password';
  const tUser = LocalUserModel.empty();

  group('forgetPassword', () {
    test('should return void when call to remote source is successfully',
        () async {
      when(() => remoteDataSource.forgotPassword(any()))
          .thenAnswer((_) async => Future.value());

      final result = await repoImpl.forgotPassword(tEmail);
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return [ServerFailure] when call to remote source fail',
        () async {
      when(
        () => remoteDataSource.forgotPassword(any()),
      ).thenThrow(
        const ServerException(
          message: 'User does not exist',
          statusCode: '404',
        ),
      );

      final result = await repoImpl.forgotPassword(tEmail);

      expect(
        result,
        equals(
          Left<dynamic, void>(
            ServerFailure(
              message: 'User does not exist',
              statusCode: '404',
            ),
          ),
        ),
      );

      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signIn', () {
    test('should return LocalUser whne call to remote source is successfull',
        () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(
            named: 'password',
          ),
        ),
      ).thenAnswer((_) async => tUser);

      final result = await repoImpl.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(
        result,
        equals(
          const Right<dynamic, LocalUser>(tUser),
        ),
      );

      verify(
        () => remoteDataSource.signIn(email: tEmail, password: tPassword),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'shuld return [ServerFailure] when call to remot source is '
        'unsuccessful', () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const ServerException(
          message: 'User does not exist',
          statusCode: '404',
        ),
      );

      final result = await repoImpl.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(
        result,
        equals(
          Left<dynamic, void>(
            ServerFailure(
              message: 'User does not exist',
              statusCode: '404',
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.signIn(email: tEmail, password: tPassword),
      ).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    group('signUp', () {
      test('should return void when call to remote suorce is successful',
          () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repoImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      });

      test(
          'should return [ServerFailure] when call to remote '
          'source is unsuccessfull', () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ServerException(
            message: 'User already exists',
            statusCode: '400',
          ),
        );
        final result = await repoImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(
          result,
          equals(
            Left<dynamic, ServerFailure>(
              ServerFailure(
                message: 'User already exists',
                statusCode: '400',
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      });
    });

    group('updateUser', () {
      test('should return void when called to remote source is successful',
          () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<dynamic>(named: 'userData'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repoImpl.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        );

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(
          () => remoteDataSource.updateUser(
            action: tUpdateAction,
            userData: tUserData,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      });

      test(
          'should return [ServerFailure] when call to remote source is '
          'unsuccessful', () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<dynamic>(
              named: 'userData',
            ),
          ),
        ).thenThrow(
          const ServerException(
            message: 'User does not exist',
            statusCode: '404',
          ),
        );

        final result = await repoImpl.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        );

        expect(
          result,
          equals(
            Left<dynamic, ServerFailure>(
              ServerFailure(
                message: 'User does not exist',
                statusCode: '404',
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.updateUser(
            action: tUpdateAction,
            userData: tUserData,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      });
    });
  });
}
