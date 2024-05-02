import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_user/features/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignUpEvent>(authSignUpEvent);
    on<AuthSignInEvent>(authSignInEvent);
  }

  FutureOr<void> authSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async{
    try{
      await AuthRepo.signUp(event.email, event.password, event.fName, event.lName);
    }catch(e){
      log(e.toString());
    }
  }

  FutureOr<void> authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async{
    try{
      await AuthRepo.signIn(event.email, event.password);
    }catch(e){
      log(e.toString());
    }
  }
}
