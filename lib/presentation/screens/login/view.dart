import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/color_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/router/route_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/strings_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/state.dart';
import 'package:flutterboilerplateblocpattern/ui_components/appbar_com.dart';
import 'package:flutterboilerplateblocpattern/ui_components/textField.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'event.dart';

class LoginPage extends StatelessWidget {
  // final _formKey = GlobalKey<FormState>(); // Form Key for validation
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: BlocProvider(
      create: (context) => LoginBloc()..add(InitEvent()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) => _buildPage(context, state),
      ),
    ));
  }

  Widget _buildPage(BuildContext context, LoginState state) {
    switch (state.status) {
      case LoginStatus.initial:
        return Scaffold(
          body: Center(child: Text("Initial", style: GoogleFonts.openSans())),
        );
      case LoginStatus.loading:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case LoginStatus.loaded:
        return Scaffold(
          body: Page(state: state),
        );
      case LoginStatus.error:
        return Scaffold(
          body: Center(child: Text("Error", style: GoogleFonts.openSans())),
        );
      case LoginStatus.success:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.bottomNavigationMainPage,
            (Route<dynamic> route) => false,
          );
        });
        return const Scaffold(
          body: Center(
              child: CircularProgressIndicator()), // Prevents black screen
        );
      default:
        return Scaffold(
          body: Center(
            child: Text("Default Case Loaded", style: GoogleFonts.openSans()),
          ),
        );
    }
  }
}

class Page extends StatelessWidget {
  final LoginState state;
  Page({super.key, required this.state});
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size(scWidth, 60),
          child: CustomAppBar(
            onLeadingPressed: () {
              context.read<LoginBloc>().add(BackEvent(context: context));
            },
            leadingIcon: const Icon(Icons.arrow_back),
            title: "",
          )),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Welcome Back 👋",
                  style: GoogleFonts.openSans(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign to your account",
                  style: GoogleFonts.openSans(fontSize: 16),
                ),
                const SizedBox(height: 20),

                // Email Field Label
                Text("Email",
                    style: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                InputField(
                  regExp: RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
                  controller: state.emailController,
                  width: double.infinity,
                  hint: "Your email",
                  labelText: "Your Email",
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                // Password Field Label
                Text("Password",
                    style: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                InputField(
                  regExp: RegExp(
                      r'^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{6,}$'),
                  controller: state.passwordController,
                  width: double.infinity,
                  hint: "Your password",
                  labelText: "Your Password",
                  hideText: state.obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: ColorManager.grey,
                    ),
                    onPressed: () {
                      context
                          .read<LoginBloc>()
                          .add(TogglePasswordVisibilityEvent());
                    },
                  ),
                ),

                Row(
                  children: [
                    SizedBox(
                      height: 24, // Set Checkbox height to 24px
                      child: Checkbox(
                        value: state.rememberMe,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(ToggleRememberMeEvent()),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // Apply 5px border radius
                        ),
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // Reduce tap size
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return ColorManager
                                  .primary; // When checked, set to primary color
                            }
                            return Colors
                                .transparent; // Default unselected color
                          },
                        ),
                        checkColor: Colors.white, // Check mark color
                      ),
                    ),
                    Text("Remember Me",
                        style: GoogleFonts.openSans(
                            fontSize: 14, color: ColorManager.primary)),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager
                          .primary, // Change to your preferred color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(48), // Apply border radius
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14), // Better button height
                    ),
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              SubmitEvent(
                                context: context,
                                email: state.emailController.text,
                                password: state.passwordController.text,
                              ),
                            );
                      }
                    },
                    child: Text(
                      AppStrings.login,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white, // Text color set to white
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Keeps content centered and compact
                    children: [
                      Text(
                        AppStrings.dontHaveAcc,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.grey, // Adjust color if needed
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<LoginBloc>()
                              .add(NavigateRegisterPageEvent(context: context));

                          // Handle register action
                        },
                        child: Text(
                          AppStrings.register,
                          style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorManager
                                  .primary // Adjust color as per UI design
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: ColorManager.signInBorder,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or with",
                        style: GoogleFonts.openSans(
                            color: ColorManager.signInBorder,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: ColorManager.signInBorder,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Google & Apple Sign-in (Images to be added manually)
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Google Sign-In Button
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          Fluttertoast.showToast(
                            msg: AppStrings.commingSoon,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorManager.primary,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border:
                                Border.all(color: ColorManager.signInBorder),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 10), // Space between icon and text
                              Text(
                                AppStrings.signGoogle,
                                style: GoogleFonts.openSans(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Apple Sign-In Button
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          Fluttertoast.showToast(
                            msg: AppStrings.commingSoon,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorManager.primary,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border:
                                Border.all(color: ColorManager.signInBorder),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 10), // Space between icon and text
                              Text(
                                AppStrings.signApple,
                                style: GoogleFonts.openSans(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
