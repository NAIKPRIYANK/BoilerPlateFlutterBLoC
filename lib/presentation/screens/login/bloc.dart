import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplateblocpattern/database/sqflite_database_service.dart';
import 'package:flutterboilerplateblocpattern/local_user/local_user.dart';
import 'package:flutterboilerplateblocpattern/models/models.dart';
import 'package:flutterboilerplateblocpattern/models/user_info.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/event.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/state.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/router/route_manager.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<InitEvent>(_init);
    on<SubmitEvent>(_submit);
    on<ToggleRememberMeEvent>(_toggleRememberMe);
    on<TogglePasswordVisibilityEvent>(_togglePasswordVisibility);
    on<NavigateRegisterPageEvent>(_navigateRegisterPage);
    on<BackEvent>(_back);
  }

  void _init(InitEvent event, Emitter<LoginState> emit) {
    emit(state.clone(status: LoginStatus.loaded));
  }

  void _toggleRememberMe(
      ToggleRememberMeEvent event, Emitter<LoginState> emit) {
    emit(state.clone(rememberMe: !state.rememberMe));
  }

  void _togglePasswordVisibility(
      TogglePasswordVisibilityEvent event, Emitter<LoginState> emit) {
    emit(state.clone(obscurePassword: !state.obscurePassword));
  }

  void _navigateRegisterPage(
      NavigateRegisterPageEvent event, Emitter<LoginState> emit) {
    Navigator.of(event.context).pushNamed(Routes.registerPage);
  }

  void _back(BackEvent event, Emitter<LoginState> emit) {
    Navigator.pop(event.context);
  }

  ///  **Handles user login & stores session**
  Future<void> _submit(SubmitEvent event, Emitter<LoginState> emit) async {
    String email = event.email.trim();
    String password = event.password.trim();

    if (!_isValidEmail(email)) {
      _showToast("Invalid email format", Colors.red);
      return;
    }

    if (!_isValidPassword(password)) {
      _showToast("Password must be at least 6 characters", Colors.red);
      return;
    }

    bool loginSuccess =
        await DatabaseHelper.instance.loginUser(email, password);

    if (loginSuccess) {
      UserModel? user = await DatabaseHelper.instance.getUserByEmail(email);

      if (user != null) {
        log('User logged in: ${user.toMap()}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("userId", user.id ?? 0);

        //  Convert `UserModel` to `LocalUserModel`
        LocalUserModel localUser = LocalUserModel(
          id: user.id,
          username: user.username,
          email: user.email,
          password: user.password,
          ageGroup: user.ageGroup,
          gender: user.gender,
          interests: user.interests,
          jwt: "sample_jwt_token", // Add JWT if applicable
        );

        //  Store user session in SharedPreferences
        await LocalUser().setUser(localUser, localUser.jwt ?? "");
        _showToast("Login successful!", Colors.green);
        emit(state.clone(status: LoginStatus.success));
      } else {
        _showToast("User not found", Colors.red);
        return;
      }
    } else {
      _showToast("Invalid credentials", Colors.red);
      return;
      // emit(state.clone(status: LoginStatus.loaded));
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
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
}
