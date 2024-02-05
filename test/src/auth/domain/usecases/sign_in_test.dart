import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/entities/user.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignIn usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignIn(repo);
  });

  const tUser = LocalUser.empty();

  test('test call the [AuthRepo.signIn]', () async {
    when(
      () => repo.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));

    final result = await usecase(
      const SignInParams(
        email: tEmail,
        password: tPassword,
      ),
    );

    expect(result, const Right<dynamic, LocalUser>(tUser));

    verify(
      () => repo.signIn(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);

    verifyNoMoreInteractions(repo);
  });
}
