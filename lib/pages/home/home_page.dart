import 'dart:convert';

import 'package:contexto/constants/colors.dart';
import 'package:contexto/models/guess_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int gameIndex = 40;

  final TextEditingController _controller = TextEditingController();

  List<GuessModel> guesses = <GuessModel>[];
  bool loading = false;

  Future<String> getResponse(String guess) async {
    Uri url = Uri.parse("https://contexto.me/game/$gameIndex/$guess");
    final response = await http.get(url);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    print(guesses);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      cursorColor: kTextColor,
                      maxLength: 22,
                      autofocus: true,
                      enabled: !loading,
                      decoration: const InputDecoration(
                        fillColor: kTextFieldBackgroundColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: kTextFieldBorderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: kTextFieldBorderColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: kTextFieldLoadingBorderColor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: kTextFieldBorderColor),
                        ),
                        hintText: "digite uma palavra",
                        hintStyle: TextStyle(
                          color: kHintTextColor,
                          fontSize: 24.0,
                        ),
                      ),
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 24.0,
                      ),
                      onSubmitted: (_) {
                        setState(() => loading = true);
                        getResponse(_controller.text.toLowerCase())
                            .then((value) {
                          Map<String, dynamic> result = jsonDecode(value);
                          // guesses.add({
                          //   _controller.text: result['distance'] as int,
                          // });
                          if ((guesses.firstWhere((guess) =>
                                  guess.text ==
                                  _controller.text.toLowerCase())) ==
                              null) {
                            if (result['distance'] as int != -1) {
                              guesses.add(
                                GuessModel(
                                  text: _controller.text.toLowerCase(),
                                  distance: result['distance'] as int,
                                ),
                              );
                            } else {
                              // TODO: handle error/invalid word
                            }
                          } else {
                            // TODO: handle word duplication
                          }
                          _controller.clear();
                          setState(() => loading = false);
                          print(result['distance']); // setState here
                          print(guesses);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              !loading
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      height: 40.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kRowBackgroundColor,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: kHighlightBorderColor, width: 3.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "aaaaaa",
                            style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "23252",
                            style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Text(
                      "Carregando...",
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
              const SizedBox(height: 15.0),
              ...guesses.map(
                (guess) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 40.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kRowBackgroundColor,
                      borderRadius: BorderRadius.circular(5.0),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
