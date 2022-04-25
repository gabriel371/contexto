import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class GuessField extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;

  const GuessField({
    Key? key,
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        cursorColor: kTextColor,
        maxLength: 22,
        autofocus: true,
        focusNode: focusNode,
        enabled: enabled,
        decoration: InputDecoration(
          counterText: "",
          fillColor: kTextFieldBackgroundColor,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: kTextFieldLoadingBorderColor),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: kTextFieldBorderColor),
          ),
          hintText: "digite uma palavra",
          hintStyle: GoogleFonts.varelaRound(
            color: kHintTextColor,
            fontSize: 24.0,
          ),
        ),
        style: const TextStyle(
          color: kTextColor,
          fontSize: 24.0,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
