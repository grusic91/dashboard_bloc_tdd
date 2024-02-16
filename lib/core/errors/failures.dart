/// This file defines Failure classes,
/// which are used to represent domain-level errors.
/// Failures are part of the domain logic
/// and are expected as part of normal application flow.
library;

import 'package:dashboard_bloc_tdd/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage =>
      '$statusCode ${statusCode is String ? '' : 'Error'}: '
      'Error: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });

  //.fromException is a named constructor for the ServerFailure class.
  // it can be renamed later of I find better name
  // It takes a ServerException object as an argument, which
  // is the source of the data for the new ServerException instance.
  // This constructor is useful when catching a ServerException
  // and want to convert it to a ServerFailure
  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
