import 'package:cards_against_humanity/pages/game.dart';
import 'package:cards_against_humanity/pages/home.dart';
import 'package:cards_against_humanity/pages/home2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: "HelvNeue",
      ),
      home: Game(),
    ),
  );
}
