import 'package:equatable/equatable.dart';

/// Enum representing different states of the Splash screen
enum SplashStatus { initial, success, failed }

class SplashState extends Equatable {
  final SplashStatus status;
  final String? errorText;
  final bool? isLoggedIn;

  const SplashState({required this.status, this.errorText, this.isLoggedIn});

  /// Returns the initial state of the Splash screen
  factory SplashState.initial() => const SplashState(status: SplashStatus.initial);

  /// Creates a new instance of SplashState with updated values
  SplashState clone({SplashStatus? status, String? errorText, bool? isLoggedIn}) {
    return SplashState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [status, isLoggedIn, errorText];
}
