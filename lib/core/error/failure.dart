import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

final String messageConnectionFailure = 'messageConnectionFailure';

class ServerFailure extends Failure {
  final String errorMessage;

  ServerFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $errorMessage}';
  }
}

class CacheFailure extends Failure {
  final String errorMessage;

  CacheFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'CacheFailure{errorMessage: $errorMessage}';
  }
}

class ConnectionFailure extends Failure {
  final String errorMessage = messageConnectionFailure;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $errorMessage}';
  }
}