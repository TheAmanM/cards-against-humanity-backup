import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardState {
  /*final*/ double phase1X;
  /*final*/ double phase1Y;
  /*final*/ double phase2X;
  /*final*/ double phase2Y;
  /*final*/ double angle;
  /*final*/ bool isQuestion;
  /*final*/ bool flipClockwise;

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

/* class SlowCurve extends Curve {
  @override
  double transformInternal(double t) {
    return -1 * math.pow(math.e, -1 * 4.7 * t).toDouble() + 1;
  }
} */

/* double slowCurveTransform(double input) {
  return -1 * math.pow(math.e, -1 * 4.7 * input).toDouble() + 1;
}

double secondPhaseTransform(double input) {
  return 1 - math.pow(math.e, -10 * (input - 0.5)).toDouble();
} */

double slowCurveTransform(double input) {
  // return -1 * math.pow(math.e, -1 * 4.7 * input).toDouble() + 1;
  return -57 * math.pow(math.e, -1 * 8 * (input + 0.5)) + 1.03;
}

double secondPhaseTransform(double input) {
  // return 1 - math.pow(math.e, -10 * (input - 0.5)).toDouble();
  return -57 * math.pow(math.e, -1 * 8 * input) + 1.03;
}

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  // Animation animation;
  double animationVal;
  bool isPhase1 = false;
  double opacity = 0.0;

  void nextPhase() async {
    double controllerVal = animationController.value;
    if (isPhase1 == false) {
      // setState(() {
      isPhase1 = true;
      print('isPhase1: $isPhase1');
      print('Animating from ${controllerVal} to 0.5');
      animationController.animateTo(0.5);
      // });
      /* animationController.forward();
      await Future.delayed(
        Duration(milliseconds: 500),
      );
      animationController.stop(); */
    } else {
      // setState(() async {
      isPhase1 = false;
      print('isPhase1: $isPhase1');
      print('Animating from ${controllerVal} to 1');
      animationController.animateTo(1);
      // ..whenComplete(() async {
      await Future.delayed(Duration(seconds: 2));
      animationController.reset();
      // await Future.delayed(Duration(seconds: 1));
      print('Round complete. Resetting');
      // setState(() {
      nextPhase();
      // });
      // });
      // });
    }
  }

  void initializeGame() async {
    opacity = 0;
    /* await Future.delayed(
      Duration(
        seconds: 1,
      ),
    ); */
    for (List<CardState> cardState in cardStates) {
      cardState[0].phase2Y = cardState[0].phase1Y - 1;
    }
    print('Initializing game');
    nextPhase();
    /* await Future.delayed(
      Duration(
        seconds: 3,
      ),
    );
    animationController.reset(); */
  }

  CardState centralState = new CardState(
    phase1X: 0.325,
    phase1Y: 0.375,
    phase2X: 0.325,
    phase2Y: 0.375,
    angle: 0.0,
    isQuestion: false,
    flipClockwise: false,
  );

  List<List<CardState>> cardStates = [
    [
      CardState(
        phase1X: 0.0,
        phase1Y: 0.75,
        phase2X: 0.0,
        phase2Y: 0.25,
        angle: 0.06,
        flipClockwise: false,
      ),
    ],
    [
      CardState(
        phase1X: 0.65,
        phase1Y: 0.75,
        phase2X: 0.65,
        phase2Y: 0.25,
        angle: 0.01,
        flipClockwise: true,
      ),
    ],
    [
      CardState(
        phase1X: 0.7,
        phase1Y: 0.4,
        phase2X: 0.7,
        phase2Y: 0.15,
        angle: -0.03,
        flipClockwise: true,
      ),
    ],
    [
      CardState(
        phase1X: 0.0,
        phase1Y: 0.4,
        phase2X: 0.0,
        phase2Y: 0.4 - 0.25 * 3,
        angle: 0.05,
        flipClockwise: false,
      ),
    ],
    [
      CardState(
        phase1X: 0.0,
        phase1Y: 0.05,
        phase2X: 0.0,
        phase2Y: -0.20,
        angle: -0.02,
        flipClockwise: false,
      ),
    ],
    [
      CardState(
        phase1X: 0.65,
        phase1Y: 0.05,
        phase2X: 0.65,
        phase2Y: -0.20,
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
/*     animation = new CurvedAnimation(
      curve: SlowCurve(),
      parent: animationController,
    ); */
    // nextPhase();
    initializeGame();
    super.initState();
  }

  setQuestionOpacity() async {
    double controllerVal = animationController.value;
    await Future.delayed(
      Duration(
        milliseconds: 5,
      ),
    );
    opacity = isPhase1
        ? 1 - slowCurveTransform(1 - 2 * controllerVal)
        // ? controllerVal * 2
        : secondPhaseTransform(1 - controllerVal);
    opacity = opacity < 0 ? 0 : opacity;
    print('opacity: $opacity');
  }

  @override
  Widget build(BuildContext context) {
    // print(animationVal);

    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ...cardStates.map((currentCard) {
              return AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    double controllerVal = animationController.value;
                    // print(animationVal);
                    // print(controllerVal);
                    animationVal = controllerVal <= 0.5
                        ? slowCurveTransform(controllerVal * 2)
                        : (2 * controllerVal) - 1;
                    // : (controllerVal + 1) / 2;
                    print(animationVal);
                    /* double leftValue = isPhase1
                        ? (size.width * currentCard[0].phase1X * animationVal) +
                            (size.width *
                                centralState.phase1X *
                                (1 - animationVal))
                        : (size.width * currentCard[0].phase2X * animationVal) +
                            (size.width *
                                currentCard[0].phase1X *
                                (1 - animationVal));
                    // print('Calculated leftValue: $leftValue');
                    double topValue = isPhase1
                        ? (size.height *
                                currentCard[0].phase1Y *
                                animationVal) +
                            (centralState.phase1Y *
                                (1 - animationVal) *
                                size.height)
                        : (size.height * /* currentCard[0].phase2Y*/ (currentCard[
                                            0]
                                        .phase1Y -
                                    3) *
                                animationVal) +
                            (currentCard[0].phase1Y *
                                (1 - animationVal) *
                                size.height);
                    // print('Calculated topValue: $topValue');
 */
                    return Positioned(
                      /* left: isPhase1
                        ? (size.width * currentCard[0].phase1X * animationVal) +
                            (size.width *
                                centralState.phase1X *
                                (1 - animationVal))
                        : (size.width * currentCard[0].phase2X * animationVal) +
                            (size.width *
                                centralState.phase1X *
                                (1 - animationVal)),
                    top: isPhase1
                        ? (size.height *
                                currentCard[0].phase1Y *
                                animationVal) +
                            (centralState.phase1Y *
                                (1 - animationVal) *
                                size.height)
                        : (size.height *
                                currentCard[0].phase2Y *
                                animationVal) +
                            (centralState.phase1Y *
                                (1 - animationVal) *
                                size.height), */
                      /* left: isPhase1
                          ? (size.width *
                                  currentCard[0].phase1X *
                                  animationVal) +
                              (size.width *
                                  centralState.phase1X *
                                  (1 - animationVal))
                          : (size.width *
                                  currentCard[0].phase2X *
                                  animationVal) +
                              (size.width *
                                  centralState.phase1X *
                                  (1 - animationVal)), */
                      left: isPhase1
                          ? (size.width *
                                  currentCard[0].phase1X *
                                  animationVal) +
                              (centralState.phase1X *
                                  (1 - animationVal) *
                                  size.width)
                          : (size.width *
                                  // secondPhaseTransform(controllerVal) *
                                  secondPhaseTransform(controllerVal) *
                                  // currentCard[0].phase2X) +
                                  centralState.phase2X +
                              (size.width *
                                  (1 - secondPhaseTransform(controllerVal)) *
                                  // controllerVal *
                                  currentCard[0].phase1X)),
                      /* top: isPhase1
                        ? (size.height *
                                currentCard[0].phase1Y *
                                animationVal) +
                            (centralState.phase1Y *
                                (1 - animationVal) *
                                size.height)
                        : (size.height *
                                currentCard[0].phase2Y *
                                animationVal) +
                            (centralState.phase1Y *
                                (1 - animationVal) *
                                size.height), */
                      top: isPhase1
                          ? (size.height *
                                  currentCard[0].phase1Y *
                                  animationVal) +
                              (centralState.phase1Y *
                                  (1 - animationVal) *
                                  size.height)
                          : (size.height *
                                  // secondPhaseTransform(controllerVal) *
                                  secondPhaseTransform(controllerVal) *
                                  currentCard[0].phase2Y) +
                              (size.height *
                                  (1 - secondPhaseTransform(controllerVal)) *
                                  // controllerVal *
                                  currentCard[0].phase1Y),
                      child: GestureDetector(
                        onTap: nextPhase,
                        child: Transform.rotate(
                          // angle: angleVal,
                          // angle: animationVal,
                          angle: isPhase1
                              ? 2 *
                                  math.pi *
                                  (currentCard[0].angle * animationVal +
                                      centralState.angle * (1 - animationVal))
                              : currentCard[0].angle,
                          child: Transform(
                            // transform: Matrix4.identity()
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(
                                isPhase1
                                    ? currentCard[0].flipClockwise
                                        ? 1 * math.pi * animationVal
                                        : -1 * math.pi * animationVal
                                    : currentCard[0].flipClockwise
                                        ? 1 * math.pi
                                        : -1 * math.pi,
                              )
                            /* ..setEntry(
                              3,
                              2,
                              0.0015,
                            )
                            ..rotateY(
                              math.pi * 2 * 0.5 * animationVal,
                            ) */
                            ,
                            child: Container(
                              width: size.width * 0.35,
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1,
                                    spreadRadius: 0.2,
                                  ),
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
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                double controllerVal = animationController.value;
                /* double opacity = isPhase1
                    ? slowCurveTransform(controllerVal)
                    : secondPhaseTransform(1 - controllerVal); */
                opacity = isPhase1
                    ? 1 - slowCurveTransform(1 - 2 * controllerVal)
                    // ? controllerVal * 2
                    : secondPhaseTransform(1 - controllerVal);
                opacity = opacity < 0 ? 0 : opacity;
                opacity = opacity > 1 ? 1 : opacity;
                print('opacity: $opacity');
                return GestureDetector(
                  onTap: nextPhase,
                  child: Center(
                    // height: 0.5,
                    // width: 0.5,
                    child: Container(
                      width: size.width * 0.35,
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            spreadRadius: 0.5,
                          ),
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
                        child: Opacity(
                          opacity: opacity,
                          child: Text(
                            // opacity.toString(),
                            'твой вопрос',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
