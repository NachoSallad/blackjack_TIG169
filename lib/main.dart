//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:my_first_app/blackjack.dart';
import 'package:my_first_app/how_to_play.dart';
import 'package:my_first_app/start_page.dart';
import 'package:my_first_app/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HowToPlay()),
      ChangeNotifierProvider(
        create: (context) => BlackJack(),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'blackjack:)',
      home: const StartPage(),
      theme: ThemeCustom.StandardTheme,
      darkTheme: ThemeCustom.DarkTheme,
      themeMode: ThemeMode.system,
    ),
  ));
}
