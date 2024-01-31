import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';
import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/domain/repos/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  const OnBoardingRepoImpl(this._localdataSource);

  final OnBoardingLocalDataSoruce _localdataSource;

  @override
  ResultFuture<void> cacheFirstTiemr() async {
    try {
      await _localdataSource.cacheFirstTimer();

      /// Right(null); - Since the method doesn't have
      /// a meaningful value to return upon success (its return type is void),
      /// it returns Right(null) to indicate success.
      /// The null here is just a placeholder since there's no
      /// actual value to return.
      /// The important part is that it's wrapped in a Right,
      /// signaling that the operation was successful.
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() {
    throw UnimplementedError();
  }
}
