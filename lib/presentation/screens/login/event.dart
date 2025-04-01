import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class LoginEvent extends Equatable {}

class InitEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class SubmitEvent extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  SubmitEvent({required this.context, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password, context];
}

class ToggleRememberMeEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class TogglePasswordVisibilityEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class NavigateRegisterPageEvent extends LoginEvent {
  final BuildContext context;
  NavigateRegisterPageEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class BackEvent extends LoginEvent {
  final BuildContext context;
  BackEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
