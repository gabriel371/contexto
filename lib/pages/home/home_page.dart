import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../pages/game/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SliverGridDelegate _delegate;

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: mediaQuerySize.width * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40.0),
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
                        Icons.menu,
                        color: kTextColor,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: 60,
                    itemBuilder: (_, index) {
                      return ElevatedButton(
                        child: Text(index.toString()),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GamePage(gameIndex: index),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
