import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/color_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/router/route_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/register/bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/register/state.dart';
import 'package:flutterboilerplateblocpattern/ui_components/appbar_com.dart';
import 'package:flutterboilerplateblocpattern/ui_components/dropdown.dart';
import 'package:flutterboilerplateblocpattern/ui_components/gender_radio_buttons.dart';
import 'package:flutterboilerplateblocpattern/ui_components/textField.dart';

import 'package:google_fonts/google_fonts.dart';

import 'event.dart'; // Import InputField component

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // Form Key for validation
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc()..add(InitEvent()),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          switch (state.status) {
            case RegisterStatus.loading:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
              break;
            case RegisterStatus.loaded:
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.loginPage,
                (Route<dynamic> route) => false,
              );
              // Close loading dialog
              break;
            case RegisterStatus.error:
              Navigator.pop(context); // Close loading dialog if open
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorText ?? '')),
              );
              break;
            default:
              break;
          }
        },
        builder: (context, state) => _buildPage(context, state),
      ),
    );
  }

  Widget _buildPage(BuildContext context, RegisterState state) {
    double scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          onLeadingPressed: () {
            context.read<RegisterBloc>().add(BackEvent(context: context));
          },
          leadingIcon: Icon(Icons.arrow_back),
          title: "",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 500), // Prevents stretch
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      /// **Title & Subtitle**
                      Text("Register",
                          style: GoogleFonts.openSans(
                              fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Create your account",
                          style: GoogleFonts.openSans(
                              fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 20),

                      /// **Name Field**
                      _buildLabel("Name"),
                      InputField(
                        regExp: RegExp(r'^[A-Za-z]+$'),
                        controller: state.nameController,
                        width: double.infinity,
                        hint: "Your name",
                        labelText: "Name",
                        validator: (value) => value == null || value.isEmpty
                            ? "Name is required"
                            : null,
                      ),
                      _buildLabel("Email"),
                      InputField(
                        controller: state.emailController,
                        width: double.infinity,
                        regExp: RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
                        hint: "Your email",
                        labelText: "Email",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {},
                      ),
                      _buildLabel("Password"),
                      InputField(
                        controller: state.passwordController,
                        width: double.infinity,
                        hint: "Your password",
                        labelText: "Password",
                        regExp: RegExp(
                            r'^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{6,}$'),
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
                                  .read<RegisterBloc>()
                                  .add(TogglePasswordVisibilityEvent());
                            }),
                        validator: (value) => value == null || value.length < 6
                            ? "Minimum 6 characters required"
                            : null,
                      ),
                      _buildLabel("Age Group"),
                      Dropdown(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: const ["18-24", "25-34", "35-44", "45+"],
                        onItemSelected: (value) {
                          state.ageGroupController.text = value;
                        },
                        // title: "Age Group",
                        hint: "Select your age group",
                        selectedItem: state.ageGroupController.text.isEmpty
                            ? null
                            : state.ageGroupController.text,
                        width: double.infinity,
                        validator: (value) =>
                            value == null ? "Please select an age group" : null,
                      ),
                      _buildLabel("Gender"),
                      _buildGenderSelection(
                          getGenderEnum(state.selectedGender), context),
                      _buildLabel("Interests"),
                      Row(
                        children: [
                          _buildCheckbox("Reading", state.interests, context),
                          _buildCheckbox("Music", state.interests, context),
                          _buildCheckbox("Playing", state.interests, context),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildRegisterButton(context, state),
                      const SizedBox(height: 12),
                      _buildLoginRow(context),
                      _buildTermsAndPrivacy(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Label for Form Fields**
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 5),
      child: Text(
        text,
        style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// **Radio Button Widget**
  Widget _buildRadio(
      Gender gender, Gender? selectedGender, BuildContext context) {
    return FormField<Gender>(
      initialValue: selectedGender,
      validator: (value) {
        if (value == null) {
          return "Please select a gender";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<Gender> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<Gender>(
                  value: gender,
                  groupValue: field.value,
                  onChanged: (Gender? value) {
                    field.didChange(value); // Notify FormField about the change
                    context
                        .read<RegisterBloc>()
                        .add(UpdateGenderEvent(value.toString()));
                  },
                ),
                Text(gender.toString().split('.').last), // Display gender text
              ],
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  field.errorText ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }

  /// **Checkbox Widget**
  Widget _buildCheckbox(
      String label, List<String> interests, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          activeColor: ColorManager.primary, // Fill color when checked
          value: interests.contains(label),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(ToggleInterestEvent(label)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side:
              BorderSide(color: ColorManager.primary, width: 2), // Border color
        ),
        Text(label),
      ],
    );
  }

  /// **Login Link**
  Widget _buildLoginRow(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Have an account? ",
              style:
                  GoogleFonts.openSans(fontSize: 14, color: ColorManager.grey)),
          TextButton(
            onPressed: () {
              context
                  .read<RegisterBloc>()
                  .add(NavigateLoginPageEvent(context: context));
            },
            child: Text("Login",
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary)),
          ),
        ],
      ),
    );
  }

  /// **Terms & Privacy Policy**
  Widget _buildTermsAndPrivacy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "By clicking Register, you agree to our Terms and Privacy Policy.",
          style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey),
          textAlign: TextAlign.center,
        ),
        Text(
          "Terms and Privacy Policy.",
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorManager.primary,
            decoration: TextDecoration.underline, // Underline the text
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// **Register Button**
  Widget _buildRegisterButton(BuildContext context, RegisterState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(48),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: () {
          if (_formKey.currentState!.validate()) {
            context.read<RegisterBloc>().add(
                  SubmitRegisterEvent(
                    context: context,
                    name: state.nameController.text,
                    email: state.emailController.text,
                    password: state.passwordController.text,
                    gender: state.selectedGender.toString().split('.').last,
                    ageGroup: state.ageGroupController.text,
                    // gender: state.selectedGender,
                    interests: state.interests,
                  ),
                );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              "Register",
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildGenderSelection(Gender? selectedGender, BuildContext context) {
  return FormField<Gender>(
    initialValue: selectedGender,
    validator: (value) {
      if (value == null) {
        return "Please select a gender";
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
    builder: (FormFieldState<Gender> field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: Gender.values.map((gender) {
              return Expanded(
                child: Row(
                  children: [
                    Radio<Gender>(
                      value: gender,
                      groupValue: field.value, // Ensures only one selection
                      onChanged: (Gender? value) {
                        field.didChange(value);
                        context.read<RegisterBloc>().add(
                              UpdateGenderEvent(
                                  value.toString().split('.').last),
                            );
                      },
                    ),
                    Text(gender.toString().split('.').last),
                  ],
                ),
              );
            }).toList(),
          ),
          if (field.hasError)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                field.errorText ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      );
    },
  );
}
