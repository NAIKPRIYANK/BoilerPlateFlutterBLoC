import 'package:flutter/material.dart';

enum Gender { male, female }

Gender? getGenderEnum(String? gender) {
  switch (gender?.toLowerCase()) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    default:
      return null; // Return null if no match is found
  }
}

class GenderSelectionWidget extends StatelessWidget {
  final ValueChanged<Gender> onGenderSelected;
  final FormFieldValidator<Gender>? validator;
  final Gender? selectedGender;
  final AutovalidateMode autovalidateMode; // Added autovalidateMode parameter

  const GenderSelectionWidget({
    super.key,
    required this.onGenderSelected,
    this.selectedGender,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled, // Default is disabled
  });

  @override
  Widget build(BuildContext context) {
    return FormField<Gender>(
      initialValue: selectedGender,
      validator: validator,
      autovalidateMode: autovalidateMode, // Set the autovalidateMode here
      builder: (FormFieldState<Gender> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 35,
              ),
              children: [
                Row(
                  children: [
                    Radio<Gender>(
                      value: Gender.male,
                      groupValue: field.value,
                      onChanged: (Gender? value) {
                        field.didChange(
                            value); // Notify form field of the change
                        onGenderSelected(value!);
                      },
                    ),
                    const Text("male"),
                  ],
                ),
                Row(
                  children: [
                    Radio<Gender>(
                      value: Gender.female,
                      groupValue: field.value,
                      onChanged: (Gender? value) {
                        field.didChange(
                            value); // Notify form field of the change
                        onGenderSelected(value!);
                      },
                    ),
                    const Text("female"),
                  ],
                ),
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
}
