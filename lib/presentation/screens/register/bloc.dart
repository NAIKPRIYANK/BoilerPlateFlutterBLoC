import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplateblocpattern/database/sqflite_database_service.dart';
import 'package:flutterboilerplateblocpattern/models/user_info.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/router/route_manager.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'event.dart';
import 'state.dart';
import 'package:flutter/material.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    on<InitEvent>(_init);
    on<SubmitRegisterEvent>(_submit);
    on<UpdateGenderEvent>(_updateGender);
    on<ToggleInterestEvent>(_toggleInterest);
    on<NavigateLoginPageEvent>(_navigateToLogin);
    on<BackEvent>(_back);
    on<TogglePasswordVisibilityEvent>(_togglePasswordVisibility);
  }

  Future<void> _init(InitEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterState.initial());
  }

  void _updateGender(UpdateGenderEvent event, Emitter<RegisterState> emit) {
    emit(state.clone(selectedGender: event.gender));
  }

  void _toggleInterest(ToggleInterestEvent event, Emitter<RegisterState> emit) {
    List<String> updatedInterests = List.from(state.interests);
    if (updatedInterests.contains(event.interest)) {
      updatedInterests.remove(event.interest);
    } else {
      updatedInterests.add(event.interest);
    }
    emit(state.clone(interests: updatedInterests));
  }

  void _navigateToLogin(
      NavigateLoginPageEvent event, Emitter<RegisterState> emit) {
    Navigator.of(event.context).pushNamed(Routes.loginPage);
  }

  void _back(BackEvent event, Emitter<RegisterState> emit) {
    Navigator.pop(event.context);
  }

  Future<void> _submit(
      SubmitRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(state.clone(status: RegisterStatus.loading));

    try {
      final newUser = UserModel(
        username: event.name,
        email: event.email,
        password: event.password,
        ageGroup: event.ageGroup,
        gender: event.gender,
        interests: event.interests,
      );

      await DatabaseHelper.instance.registerUser(newUser);

      _showToast("Registration successful!", Colors.green);

      emit(state.clone(status: RegisterStatus.loaded));
    } catch (e) {
      _showToast("Registration failed: ${e.toString()}", Colors.red);
    }
  }

  //show toast messages with custom colors
  void _showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void _togglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<RegisterState> emit) {
    emit(state.clone(obscurePassword: !state.obscurePassword));
  }
}
