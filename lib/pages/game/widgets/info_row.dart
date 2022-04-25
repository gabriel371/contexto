import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';
import '../../../models/guess_model.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.gameIndex,
    required this.guesses,
    required this.hints,
  }) : super(key: key);

  final int gameIndex;
  final List<GuessModel> guesses;
  final int hints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "JOGO: ",
            style: GoogleFonts.varelaRound(
              color: kTextColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "#$gameIndex",
            style: GoogleFonts.varelaRound(
              color: kTextColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 15.0),
          Text(
            "TENTATIVAS: ",
            style: GoogleFonts.varelaRound(
              color: kTextColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "${guesses.length}",
            style: GoogleFonts.varelaRound(
              color: kTextColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Visibility(
            visible: hints > 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 15.0),
                Text(
                  "DICAS: ",
                  style: GoogleFonts.varelaRound(
                    color: kTextColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "$hints",
                  style: GoogleFonts.varelaRound(
                    color: kTextColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
