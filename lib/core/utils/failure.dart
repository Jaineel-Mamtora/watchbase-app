import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({
    this.statusCode,
    String? message,
  }) : super(message ?? 'A server error occurred');
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({
    String message = 'Please check your internet connection',
  }) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
