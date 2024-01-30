import 'package:dashboard_bloc_tdd/core/usecases/usecases.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/repos/on_boarding_repo.dart';

// A use case that encapsulates the logic
// for checking if the user is a first-time user.
class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
