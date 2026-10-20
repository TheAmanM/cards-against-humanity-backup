import 'package:cards_against_humanity/pages/game_page.dart';
import 'package:cards_against_humanity/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget CustomButton(String text, bool whiteBackground, Function onTap) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          // 88 * 36
          decoration: BoxDecoration(
            color: whiteBackground ? Colors.white : Colors.black,
            border: Border(
              top: BorderSide(
                // color: whiteBackground ? Colors.black : Colors.white,
                color: Colors.white,
              ),
              bottom: BorderSide(
                // color: whiteBackground ? Colors.black : Colors.white,
                color: Colors.white,
              ),
              left: BorderSide(
                // color: whiteBackground ? Colors.black : Colors.white,
                color: Colors.white,
              ),
              right: BorderSide(
                // color: whiteBackground ? Colors.black : Colors.white,
                color: Colors.white,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Text(
              text,
              style: TextStyle(
                height: 1.2,
                fontSize: 16,
                color: whiteBackground ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool showButtons = false;
  bool isDark = false;

  void changeButtonState() async {
    // await Future.delayed(
    //   Duration(
    //     seconds: 1,
    //   ),
    // );
    var data = await getJson();
    // print("---");
    // print(data);
    // print("---");
    setState(() {
      showButtons = true;
    });
  }

  @override
  void initState() {
    changeButtonState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isDark = getTheme(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Cards Against\nHumanity',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /* FlatButton(
                      color: Colors.black,
                      onPressed: () {},
                      // highlightColor: Colors.grey[800],
                      highlightColor: Colors.white.withOpacity(0.2),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Text(
                            'SINGLEPLAYER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        // side: BorderSide(
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {},
                      // highlightColor: Colors.grey[800],
                      highlightColor: Colors.white.withOpacity(0.2),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          'MULTIPLAYER',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ), */
                    // showButtons
                    //     ? CustomButton(
                    //         "SINGLEPLAYER",
                    //         false,
                    //       )
                    //     : SizedBox.shrink(),
                    // showButtons
                    //     ? CustomButton(
                    //         "MULTIPLAYER",
                    //         true,
                    //       )
                    //     : SizedBox.shrink(),
                    if (showButtons)
                      // ...buttons
                      CustomButton(
                        "SINGLEPLAYER",
                        false,
                        () {},
                      ),
                    if (showButtons)
                      CustomButton(
                        "MULTIPLAYER",
                        true,
                        () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) {
                                return GamePage();
                              },
                            ),
                          );
                        },
                      ),
                    if (!showButtons)
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(9),
                          child: Text(
                            'INITIALIZING...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
