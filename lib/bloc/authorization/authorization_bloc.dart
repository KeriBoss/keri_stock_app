import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/data/repositories/authorization_repository.dart';
import 'package:stock_market_project/data/static/app_value.dart';

import '../../data/entities/user.dart';
import '../../services/firebase_message_service.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final AuthorizationRepository _authorRepo;
  User? currentUser;

  AuthorizationBloc(this._authorRepo) : super(AuthorizationInitial()) {
    on<OnLoginEvent>((event, emit) async {
      emit(AuthorizationLoadingState());

      try {
        final response = await _authorRepo.login(
          event.phoneNumber,
          event.password,
        );

        response.fold(
          (failure) => emit(AuthorizationErrorState(failure.message)),
          (user) {
            currentUser = user;
            AppValue.currentUser = user;

            FirebaseMessageService.subscribeToTopic(user.phoneNumber);

            emit(AuthorizationLoggedInState(currentUser!));
          },
        );
      } catch (e, stackTrace) {
        debugPrint(
          'Caught login error: ${e.toString()} \n${stackTrace.toString()}',
        );
        emit(AuthorizationErrorState(e.toString()));
      }
    });

    on<OnGetUserInfoEvent>((event, emit) async {
      emit(AuthorizationLoadingState());

      try {
        final response = await _authorRepo.getUserInfo(
          event.phoneNumber,
        );

        response.fold(
          (failure) => emit(AuthorizationErrorState(failure.message)),
          (user) => emit(AuthorizationGotUserInfoState(user)),
        );
      } catch (e, stackTrace) {
        debugPrint(
          'Caught getting user info error: ${e.toString()} \n${stackTrace.toString()}',
        );
        emit(AuthorizationErrorState(e.toString()));
      }
    });

    on<OnChangePasswordEvent>((event, emit) async {
      emit(AuthorizationLoadingState());

      try {
        final response = await _authorRepo.updateUser(
          {'password': event.newPassword},
          event.phoneNumber,
        );

        response.fold(
          (failure) => emit(AuthorizationErrorState(failure.message)),
          (success) => emit(AuthorizationPasswordChangedState(success.message)),
        );
      } catch (e, stackTrace) {
        debugPrint(
          'Caught change password error: ${e.toString()} \n${stackTrace.toString()}',
        );
        emit(AuthorizationErrorState(e.toString()));
      }
    });

    on<OnRegisterEvent>((event, emit) async {
      emit(AuthorizationLoadingState());

      try {
        final response = await _authorRepo.register(event.newUser);

        response.fold(
          (failure) => emit(AuthorizationErrorState(failure.message)),
          (success) => emit(AuthorizationRegisteredState(success.message)),
        );
      } catch (e, stackTrace) {
        debugPrint(
          'Caught register error: ${e.toString()} \n${stackTrace.toString()}',
        );
        emit(AuthorizationErrorState(e.toString()));
      }
    });
  }
}
