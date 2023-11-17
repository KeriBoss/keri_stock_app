part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object?> get props => [];
}

class OnLoginEvent extends AuthorizationEvent {
  final String phoneNumber;
  final String password;

  const OnLoginEvent(this.phoneNumber, this.password);
}

class OnRegisterEvent extends AuthorizationEvent {
  final User newUser;

  const OnRegisterEvent(this.newUser);
}

class OnLogoutEvent extends AuthorizationEvent {}

class OnChangePasswordEvent extends AuthorizationEvent {
  final String phoneNumber;
  final String newPassword;

  const OnChangePasswordEvent(this.newPassword, this.phoneNumber);
}

class OnGetUserInfoEvent extends AuthorizationEvent {
  final String phoneNumber;

  const OnGetUserInfoEvent(this.phoneNumber);
}
