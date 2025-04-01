import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum RegisterStatus { initial, loaded, loading, error }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? errorText;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController ageGroupController;
  String selectedGender;
  final List<String> interests;
  final bool obscurePassword;

  RegisterState({
    required this.status,
    this.errorText,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.ageGroupController,
    this.selectedGender = '',
    this.interests = const [],
    this.obscurePassword = true,
  });

  factory RegisterState.initial() => RegisterState(
        status: RegisterStatus.initial,
        nameController: TextEditingController(),
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        ageGroupController: TextEditingController(),
      );

  RegisterState clone({
    RegisterStatus? status,
    String? errorText,
    String? selectedGender,
    List<String>? interests,
    bool? obscurePassword,
  }) =>
      RegisterState(
        status: status ?? this.status,
        errorText: errorText ?? this.errorText,
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        ageGroupController: ageGroupController,
        selectedGender: selectedGender ?? this.selectedGender,
        interests: interests ?? this.interests,
        obscurePassword: obscurePassword ?? this.obscurePassword,
      );

  @override
  List<Object?> get props => [status, errorText, selectedGender, interests,obscurePassword];
}
