import 'package:dartz/dartz.dart';
import 'package:dashboard_bloc_tdd/core/errors/failures.dart';

/// definition of custom type ResultFuture
/// whenever ResultFuture is used its this type
/// Failure on the Left and successfull returned generic type on the Right
typedef ResultFuture<T> = Future<Either<Failure, T>>;

// definition of DataMap so we don't have to type it over again.
typedef DataMap = Map<String, dynamic>;
