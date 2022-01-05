// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//klass som gör ett Standard tema på scaffold & appbar
class ThemeCustom {
  static ThemeData get StandardTheme {
    return ThemeData(
      primaryColor: Colors.green.shade800,
      scaffoldBackgroundColor: Colors.white,
      // fontFamily: 'Times new roman',
      //textTheme: TextTheme(
      //TextStyle
      // title: GoogleFonts.oswald(),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.green[800],
          textStyle: const TextStyle(fontSize: 25),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Times new roman',
          fontSize: 20,
        ),
      ),
    );
  }

//funktion som gör ett mörkt tema på scaffold & appbar
  static ThemeData get DarkTheme {
    return ThemeData(
      primaryColor: Colors.grey[600],
      scaffoldBackgroundColor: Colors.grey,
      fontFamily: 'Times new roman',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: Colors.grey[800],
              textStyle: const TextStyle(fontSize: 25))),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Times new roman',
          fontSize: 20,
        ),
      ),
      //ändrar färg på iconbuttons
      iconTheme: const IconThemeData(color: Colors.black),
      //ändrar font knappar
      textTheme: TextTheme(
        headline6: GoogleFonts.oswald(),
      ),
    );
  }
}
