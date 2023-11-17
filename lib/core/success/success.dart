import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  final String message;

  const Success(this.message);

  @override
  List<Object> get props => [message];
}

class ApiSuccessMessage extends Success {
  const ApiSuccessMessage(String message) : super(message);
}
