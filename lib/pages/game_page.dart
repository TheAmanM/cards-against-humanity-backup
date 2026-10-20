import 'package:cards_against_humanity/services/models.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  int currentState = 0;
  AnimationController animController;
  Animation animation;

  List<CardState> states;

  void onSelect() {
    setState(() {
      print("incremented: $currentState");
      currentState++;
    });
  }

  @override
  void initState() {
    animController = new AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    animation = new CurvedAnimation(
      curve: Curves.easeOut,
      parent: animController,
    );
    states = [
      CardState(
        xOffset: 50,
        yOffset: 50,
        degrees: 45,
        controller: animation,
      ),
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        degrees: 0,
        controller: animation,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white, //remove later
      body: Stack(
        children: [
          // GameCard(
          //   text: "A test",
          //   isQuestion: true,
          // ),
          GestureDetector(
            onTap: onSelect,
            child: GameCard(
              text: "A second test",
              isQuestion: true,
              cardState: states[currentState % states.length],
              animation: animation,
            ),
          ),
        ],
      ),
    );
  }
}
