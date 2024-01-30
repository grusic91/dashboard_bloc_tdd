import 'package:dashboard_bloc_tdd/core/usecases/usecases.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/repos/on_boarding_repo.dart';

// A use case that encapsulates the logic for caching the first-time user flag.
class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTiemr();
}
