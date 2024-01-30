/// This file defines abstract classes for usecases.
/// Usecases represent individual operations
/// or business logic of the application.
library;

import 'package:dashboard_bloc_tdd/core/utils/typdefs.dart';

// An abstract class for usecases that require input parameters.
abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

// An abstract class for usecases that do not require input parameters.
abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
