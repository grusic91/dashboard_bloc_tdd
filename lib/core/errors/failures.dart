/// This file defines Failure classes,
/// which are used to represent domain-level errors.
/// Failures are part of the domain logic
/// and are expected as part of normal application flow.
library;

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  //.fromException is a named constructor for the ServerFailure class.
  // it can be renamed later of I find better name
  // It takes a ServerFailure object as an argument, which
  // is the source of the data for the new ServerFailure instance being created.
  // This constructor is useful when catching a ServerException
  // and want to convert it to a ServerFailure
  ServerFailure.fromException(ServerFailure exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
