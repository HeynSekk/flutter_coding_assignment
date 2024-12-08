import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.tec,
    required this.label,
    this.textInputType,
    required this.textFieldKey,
    this.obscureText,
  });
  final TextEditingController tec;
  final String label;
  final TextInputType? textInputType;
  final String textFieldKey;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4), // Changes position of the shadow
          ),
        ],
      ),
      child: TextField(
        key: ValueKey(textFieldKey),
        controller: tec,
        keyboardType: textInputType ?? TextInputType.name,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: InputBorder.none, // Removes the default border
          hintText: label,
        ),
      ),
    );
  }
}
