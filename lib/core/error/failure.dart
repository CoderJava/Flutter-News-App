import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/core/util/constant_error_message.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String errorMessage;

  ServerFailure(this.errorMessage);

  @override
  List<Object?> get props => [
    errorMessage,
  ];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $errorMessage}';
  }
}

class ConnectionFailure extends Failure {
  final String errorMessage = ConstantErrorMessage().connectionError;

  @override
  List<Object?> get props => [
    errorMessage,
  ];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $errorMessage}';
  }
}

class ParsingFailure extends Failure {
  final String errorMessage;

  ParsingFailure(this.errorMessage);

  @override
  List<Object?> get props => [
    errorMessage,
  ];

  @override
  String toString() {
    return 'ParsingFailure{errorMessage: $errorMessage}';
  }
}