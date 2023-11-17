part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();
}

class AuthorizationInitial extends AuthorizationState {
  @override
  List<Object> get props => [];
}

class AuthorizationLoadingState extends AuthorizationState {
  @override
  List<Object?> get props => [];
}

class AuthorizationLoggedInState extends AuthorizationState {
  final User user;

  const AuthorizationLoggedInState(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthorizationRegisteredState extends AuthorizationState {
  final String message;

  const AuthorizationRegisteredState(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthorizationPasswordChangedState extends AuthorizationState {
  final String message;

  const AuthorizationPasswordChangedState(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthorizationGotUserInfoState extends AuthorizationState {
  final User user;

  const AuthorizationGotUserInfoState(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthorizationErrorState extends AuthorizationState {
  final String message;

  const AuthorizationErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
