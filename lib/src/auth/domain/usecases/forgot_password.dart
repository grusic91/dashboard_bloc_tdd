import 'package:dashboard_bloc_tdd/core/usecases/usecases.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/repos/auth_repo.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
