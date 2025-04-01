import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../presentation/resources/color_manager.dart';

class Dropdown extends StatefulWidget {
  final List<String> items;
  final String? title;
  final String hint;
  final ValueChanged<String> onItemSelected;
  final String? errorText;
  final String? selectedItem;
  final double width;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;

  const Dropdown({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.title,
    required this.hint,
    this.selectedItem,
    this.errorText,
    this.width = 200,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(Dropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      setState(() {
        selectedItem = widget.selectedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedItem != null && !widget.items.contains(selectedItem)) {
      selectedItem = null;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60, // Set the desired height
              child: DropdownButtonFormField<String>(
                value: selectedItem,
                autovalidateMode: widget.autovalidateMode,
                dropdownColor: ColorManager.white, 
                hint: Text(
                  widget.hint,
                  style: GoogleFonts.roboto(
                  color: ColorManager.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                items: widget.items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12),
                      softWrap: true,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                  widget.onItemSelected(newValue!);
                },
                validator: widget.validator,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorManager.textFieldColor, // Background color
                  labelText: widget.title,
                  labelStyle: GoogleFonts.openSans(
                      color: ColorManager.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  errorText: widget.errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // 8px border radius
                    borderSide: BorderSide.none, // No visible border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16, // Adjust padding inside dropdown
                    horizontal: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
