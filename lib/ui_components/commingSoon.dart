// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/color_manager.dart';

import 'package:google_fonts/google_fonts.dart';

class ComingSoonWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const ComingSoonWidget({
    super.key,
    this.title = "Coming Soon",
    this.message = "This feature is under development. Stay tuned!",
    this.icon = Icons.hourglass_empty, // Default icon
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: ColorManager.primary,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: ColorManager.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
