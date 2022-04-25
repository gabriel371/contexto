import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../constants/api.dart';
import '../../constants/colors.dart';
import '../../models/guess_model.dart';
import 'widgets/guess_field.dart';
import 'widgets/guess_row.dart';
import 'widgets/info_card.dart';
import 'widgets/info_row.dart';
import 'widgets/loading_animation.dart';

class GamePage extends StatefulWidget {
  int gameIndex = 0;

  GamePage({
    Key? key,
    required this.gameIndex,
  }) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  GuessModel? currentGuess;
  List<GuessModel> guesses = <GuessModel>[];
  bool loading = false;
  bool duplicateWord = false;
  bool wrongWord = false;
  int hints = 0;

  Future<String> getResponse(String guess) async {
    Uri url = Uri.parse(apiUrl + "${widget.gameIndex}/$guess");
    final response = await http.get(url);
    return response.body;
  }

  Widget getResult() {
    if (guesses.isNotEmpty) {
      if (!loading) {
        if (duplicateWord) {
          return RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: GoogleFonts.varelaRound(
                color: kTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              children: <TextSpan>[
                const TextSpan(text: "A palavra "),
                TextSpan(
                  text: currentGuess!.text.toLowerCase(),
                  style: GoogleFonts.varelaRound(
                    color: kTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const TextSpan(text: " já foi."),
              ],
            ),
          );
        } else if (wrongWord) {
          return Text(
            "Perdão, não conheço essa palavra.",
            style: GoogleFonts.varelaRound(
              color: kTextColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          );
        } else {
          return GuessRow(guess: currentGuess!, highlighted: true);
        }
      } else {
        return const LoadingAnimation();
      }
    } else {
      if (!loading) {
        if (wrongWord) {
          return Text(
            "Perdão, não conheço essa palavra.",
            style: GoogleFonts.varelaRound(
              color: kTextColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          );
        } else {
          return const InfoCard();
        }
      } else {
        return const LoadingAnimation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: kTextColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              "CONTEXTO",
                              style: GoogleFonts.varelaRound(
                                color: kTextColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.lightbulb,
                                color: kTextColor,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        InfoRow(
                            gameIndex: widget.gameIndex,
                            guesses: guesses,
                            hints: hints),
                        const SizedBox(height: 5.0),
                        GuessField(
                          controller: _controller,
                          focusNode: _node,
                          enabled: !loading,
                          onSubmitted: (_) {
                            setState(() {
                              loading = true;
                              duplicateWord = false;
                              wrongWord = false;
                            });
                            getResponse(_controller.text.toLowerCase())
                                .then((value) {
                              Map<String, dynamic> result = jsonDecode(value);
                              if (result['distance'] as int != -1) {
                                currentGuess = GuessModel(
                                  text: _controller.text.toLowerCase(),
                                  distance: (result['distance'] as int) + 1,
                                );
                                if (guesses.contains(currentGuess)) {
                                  setState(() => duplicateWord = true);
                                } else {
                                  guesses.add(currentGuess!);
                                }
                                guesses.sort(((a, b) =>
                                    a.distance.compareTo(b.distance)));
                              } else {
                                setState(() => wrongWord = true);
                              }
                              _controller.clear();
                              setState(() => loading = false);
                              Future<void>.delayed(
                                      const Duration(milliseconds: 10))
                                  .then((_) {
                                _node.requestFocus();
                              });
                            });
                          },
                        ),
                        const SizedBox(height: 20.0),
                        getResult(),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: guesses.isNotEmpty && !loading,
                    child: Expanded(
                      flex: 5,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ...guesses.map(
                            (guess) {
                              return GuessRow(
                                guess: guess,
                                highlighted: currentGuess!.text == guess.text,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
