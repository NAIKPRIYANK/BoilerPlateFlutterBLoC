import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum LoginStatus { initial, success, loading, failed, loaded, error }

class LoginState extends Equatable {
  final LoginStatus? status;
  final String? errorText;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool obscurePassword;

  LoginState({
    this.status,
    this.errorText,
    required this.emailController,
    required this.passwordController,
    this.rememberMe = false,
    this.obscurePassword = true,
  });

  static LoginState initial() => LoginState(
        status: LoginStatus.initial,
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
      );

  LoginState clone({
    LoginStatus? status,
    String? errorText,
    bool? rememberMe,
    bool? obscurePassword,
  }) =>
      LoginState(
        status: status ?? this.status,
        errorText: errorText ?? this.errorText,
        emailController: emailController,
        passwordController: passwordController,
        rememberMe: rememberMe ?? this.rememberMe,
        obscurePassword: obscurePassword ?? this.obscurePassword,
      );

  @override
  List<Object?> get props => [status, errorText, emailController, passwordController, rememberMe, obscurePassword];
}
