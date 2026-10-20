import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardState {
  final double phase1X;
  final double phase1Y;
  final double phase2X;
  final double phase2Y;
  final double angle;
  final bool isQuestion;
  final bool flipClockwise;

  CardState({
    @required this.phase1X,
    @required this.phase1Y,
    @required this.phase2X,
    @required this.phase2Y,
    @required this.angle,
    @required this.flipClockwise,
    this.isQuestion = false,
  });
}

class SlowCurve extends Curve {
  @override
  double transformInternal(double t) {
    return -1 * math.pow(math.e, -1 * 4.7 * t).toDouble() + 1;
  }
}

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  bool isPhase1 = true;

  void nextPhase() {
    if (animation.value == 0) {
      setState(() {
        isPhase1 = false;
        print('isPhase1: $isPhase1');
        animationController.animateTo(0.5);
      });
      /* animationController.forward();
      await Future.delayed(
        Duration(milliseconds: 500),
      );
      animationController.stop(); */
    }
  }

  void initializeGame() async {
    await Future.delayed(
      Duration(
        seconds: 1,
      ),
    );
    nextPhase();
  }

  CardState centralState = new CardState(
    phase1X: 0.325,
    phase1Y: 0.375,
    angle: 0,
    isQuestion: false,
    flipClockwise: false,
  );

  List<List<CardState>> cardStates = [
    [
      CardState(
        phase1X: 0,
        phase1Y: 0.75,
        phase2X: 0,
        phase2Y: 0,
        angle: 0.06,
        flipClockwise: false,
      ),
    ],
    [
      CardState(
        phase1X: 0.65,
        phase1Y: 0.75,
        phase2X: 0,
        phase2Y: 0,
        angle: 0.01,
        flipClockwise: true,
      ),
    ],
    [
      CardState(
        phase1X: 0.7,
        phase1Y: 0.4,
        phase2X: 0,
        phase2Y: 0,
        angle: -0.03,
        flipClockwise: true,
      ),
    ],
    [
      CardState(
        phase1X: 0,
        phase1Y: 0.4,
        phase2X: 0,
        phase2Y: 0,
        angle: 0.05,
        flipClockwise: false,
      ),
    ],
    [
      CardState(
        phase1X: 0,
        phase1Y: 0.05,
        phase2X: 0,
        phase2Y: 0,
        angle: -0.02,
        flipClockwise: false,
      ),
    ],
    [
      CardState(
        phase1X: 0.65,
        phase1Y: 0.05,
        phase2X: 0,
        phase2Y: 0,
        angle: 0.01,
        flipClockwise: true,
      ),
    ],
  ];

  @override
  void initState() {
    animationController = new AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    animation = new CurvedAnimation(
      curve: SlowCurve(),
      parent: animationController,
    );
    // nextPhase();
    initializeGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(animation.value);

    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          ...cardStates.map((currentCard) {
            return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  // print(animation.value);
                  print(animationController.value);
                  return Positioned(
                    left: (size.width *
                            currentCard[0].phase1X *
                            animation.value) +
                        (size.width *
                            centralState.phase1X *
                            (1 - animation.value)),
                    // top: heightVal,
                    top: (size.height *
                            currentCard[0].phase1Y *
                            animation.value) +
                        (centralState.phase1Y *
                            (1 - animation.value) *
                            size.height),
                    child: GestureDetector(
                      onTap: nextPhase,
                      child: Transform.rotate(
                        // angle: angleVal,
                        // angle: animation.value,
                        angle: 2 *
                            math.pi *
                            (currentCard[0].angle * animation.value +
                                centralState.angle * (1 - animation.value)),
                        child: Transform(
                          // transform: Matrix4.identity()
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(
                              currentCard[0].flipClockwise
                                  ? 1 * math.pi * animation.value
                                  : -1 * math.pi * animation.value,
                            )
                          /* ..setEntry(
                              3,
                              2,
                              0.0015,
                            )
                            ..rotateY(
                              math.pi * 2 * 0.5 * animation.value,
                            ) */
                          ,
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                /* BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                  spreadRadius: 0.5,
                                ), */
                              ],
                              color: currentCard[0].isQuestion
                                  ? Colors.black
                                  : Colors.white,
                              border: Border.all(
                                color: currentCard[0].isQuestion
                                    ? Colors.white
                                    : Colors.black,
                                width: 8,
                              ),
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }).toList(),
          GestureDetector(
            onTap: () {
              //startGame(duration: Duration(seconds: 0));
              setState(() {
                nextPhase();
              });
            },
            child: Center(
              // height: 0.5,
              // width: 0.5,
              child: Container(
                width: size.width * 0.35,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    /* BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          spreadRadius: 0.5,
                        ), */
                  ],
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.white,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Center(
                  child: Text(
                    animationController.value.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
