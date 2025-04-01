import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class RegisterEvent extends Equatable {}

class InitEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class NavigateLoginPageEvent extends RegisterEvent {
  final BuildContext context;
  NavigateLoginPageEvent({required this.context});

  @override
  List<Object?> get props => [context];
}


class BackEvent extends RegisterEvent {
  final BuildContext context;
  BackEvent({required this.context});

  @override
  List<Object?> get props => [context];
}


class SubmitRegisterEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String ageGroup;
  final String gender;
  final List<String> interests;
  final BuildContext context;

  SubmitRegisterEvent({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
    required this.ageGroup,
    required this.gender,
    required this.interests,
  });

  @override
  List<Object?> get props =>
      [name, email, password, ageGroup, gender, interests, context];
}

class UpdateGenderEvent extends RegisterEvent {
  final String gender;

  UpdateGenderEvent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class ToggleInterestEvent extends RegisterEvent {
  final String interest;

  ToggleInterestEvent(this.interest);

  @override
  List<Object?> get props => [interest];
}

class TogglePasswordVisibilityEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
