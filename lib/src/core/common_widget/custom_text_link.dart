import 'package:flutter/material.dart';

class CustomTextLink extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  const CustomTextLink({
    super.key,
    required this.text,
    this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontSize: style?.fontSize,
        ),
      ),
    );
  }
}
