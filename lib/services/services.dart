import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:flutter/services.dart';

/*
  
  - Start with some data (some type of array) structure that holds rotation and 
  position values for initial and final state
  - bool initialState; // This will be set to false in some time
  so that the containers animate to their new locations
  Stack with children that loop over the array (1) and create
  List<AnimatedContainer>, use dataList.map((obj) {f(obj)}).toList();

*/

Future getJson() async {
  String loadString = await rootBundle.loadString('assets/data/data.json');
  return json.decode(loadString);
}

bool getTheme(context) {
  final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
  bool isDark = brightnessValue == Brightness.dark;
  return isDark;
}

showCustomSheet(BuildContext context, bool isDark) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: false,
    // isDismissible: false,
    builder: (context) {
      // return Scaffold(
      //   body: Container(),
      // );
      return Container(
        height: MediaQuery.of(context).size.height * 0.40,
        decoration: BoxDecoration(
          color: isDark ? Color(0xFF252525) : Colors.white,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dialog header',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontFamily: "Roboto",
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Opacity(
              opacity: 0.8,
              child: Text(
                // 'This text keeps the reader busy, and a developer can use this as sample text to cover areas that no not have functional information yet. Happy designing!',
                // 'Just a bunch of sample text to keep the reader busy',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras a dolor lorem. Aliquam finibus facilisis odio vitae bibendum. ',
                style: TextStyle(
                  height: 1.4,
                  fontFamily: "Roboto",
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            // SizedBox.expand(),
            // SizedBox(
            //   height: 32,
            // ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Action 1',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Opacity(
                  opacity: 0.15,
                  child: Container(
                    width: 2,
                    height: 20,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  'Action 2',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
