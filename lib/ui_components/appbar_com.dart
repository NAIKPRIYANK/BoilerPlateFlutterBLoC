import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          : null,
      leading: leadingIcon != null
          ? IconButton(
              icon: leadingIcon!,
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
            )
          : const SizedBox.shrink(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
