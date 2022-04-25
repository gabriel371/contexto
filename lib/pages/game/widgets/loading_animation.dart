import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.varelaRound(
        color: kTextLoadingColor,
        fontWeight: FontWeight.w700,
        fontSize: 20.0,
      ),
      child: AnimatedTextKit(
        animatedTexts: [WavyAnimatedText("Carregando...")],
        isRepeatingAnimation: true,
      ),
    );
  }
}
