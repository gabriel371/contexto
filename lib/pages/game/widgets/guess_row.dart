import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/guess_model.dart';

class GuessRow extends StatelessWidget {
  GuessModel guess;
  bool highlighted;

  GuessRow({
    Key? key,
    required this.guess,
    required this.highlighted,
  }) : super(key: key);

  Color getColor() {
    if (guess.distance <= 1000) {
      return kRowRightColor;
    } else if (guess.distance > 1000 && guess.distance <= 3000) {
      return kRowAverageColor;
    } else {
      return kRowWrongColor;
    }
  }

  double getWidth(double d) {
    double getExp(double e) {
      return 0.5 * math.exp(-0.5 * e);
    }

    double n = getExp(0);
    double r = getExp(100);
    return (getExp(d / 111155 * 100) - r) / (n - r) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 40.0,
          width: 450.0,
          decoration: BoxDecoration(
            color: kRowBackgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        Container(
          height: 40.0,
          width: getWidth(guess.distance.toDouble()) *
              (MediaQuery.of(context).size.width / 100),
          decoration: BoxDecoration(
            color: getColor(),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 40.0,
          width: 450.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: highlighted
                ? Border.all(color: kHighlightBorderColor, width: 3.0)
                : Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                guess.text,
                style: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              Text(
                guess.distance.toString(),
                style: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
