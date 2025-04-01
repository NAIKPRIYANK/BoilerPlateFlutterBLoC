import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/color_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/router/route_manager.dart';


import 'bloc.dart';
import 'state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.initial:
              // No action needed during initialization
              break;

            case SplashStatus.success:
              // Determine navigation based on login status
              Future.delayed(const Duration(seconds: 2), () {
                // if (context.mounted) {
                  // Check here before accessing context
                  // if (state.isLoggedIn == true) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginPage,
                      (Route<dynamic> route) => false,
                    );
                  } 
                // }
              );
              break;

            case SplashStatus.failed:
              // Display an error message if initialization fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorText ?? "An error occurred")),
              );
              break;
          }
        },
        builder: (context, state) => _buildPage(context),
      ),
    );
  }

  /// Builds the Splash screen UI
  Widget _buildPage(BuildContext context) {
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          body: const Center(
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensures Row takes only required space
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
