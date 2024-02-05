import 'package:dashboard_bloc_tdd/core/enums/update_user.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LocalUser> signIn({
    required String emai,
    required String password,
  });

  ResultFuture<void> signUp({
    required String emai,
    required String fullName,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
