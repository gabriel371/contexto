import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: 400.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kRowBackgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.help_outline,
                color: kTextColor,
              ),
              const SizedBox(width: 10.0),
              Text(
                "Como jogar",
                style: GoogleFonts.varelaRound(
                  fontSize: 18.0,
                  color: kTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            "Descubra a palavra secreta. Você pode tentar quantas vezes precisar.",
            style: GoogleFonts.varelaRound(
              fontSize: 14.0,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "As palavras foram ordernadas por um algoritmo de inteligência artificial de acordo com a similaridade delas com a palavra secreta.",
            style: GoogleFonts.varelaRound(
              fontSize: 14.0,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Depois de enviar uma palavra, você verá a posição em que ela está. A palavra secreta é a número 1.",
            style: GoogleFonts.varelaRound(
              fontSize: 14.0,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "O algoritmo analisou milhares de textos em Português. Ele utiliza o contexto em que as palavras são utilizadas para calcular a similaridade entre elas.",
            style: GoogleFonts.varelaRound(
              fontSize: 14.0,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
