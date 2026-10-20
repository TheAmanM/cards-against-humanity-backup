import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardState {
  final double xOffset;
  final double yOffset;
  final double angle;
  final bool flipClockwise;
  final bool isQuestion;

  CardState({
    @required this.xOffset,
    @required this.yOffset,
    @required this.angle,
    @required this.flipClockwise,
    this.isQuestion = false,
  });
}

class Home2 extends StatefulWidget {
  const Home2({Key key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class SlowCurve extends Curve {
  @override
  double transformInternal(double t) {
    return -1 * math.pow(math.e, -1 * 4.7 * t).toDouble() + 1;
  }
}

class _Home2State extends State<Home2> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  bool isInitial = true;

  CardState questionCard = new CardState(
    xOffset: 0.5,
    yOffset: 0.5,
    angle: 0,
    isQuestion: true,
    flipClockwise: null,
  );

  List<List<CardState>> cardStates = [
    [
      /* CardState(
        xOffset: 0.15,
        yOffset: 0.7,
        angle: 0.02,
      ), */
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        angle: 0,
        flipClockwise: false,
      ),
      CardState(
        xOffset: 0,
        yOffset: 0.75,
        angle: 0.06,
        flipClockwise: false,
      ),
    ],
    [
      /* CardState(
        xOffset: 0.6,
        yOffset: 0.7,
        angle: 0.06,
      ), */
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        angle: 0,
        flipClockwise: true,
      ),
      CardState(
        xOffset: 0.65,
        yOffset: 0.75,
        angle: 0.01,
        flipClockwise: true,
      ),
    ],
    [
      /* CardState(
        xOffset: 0.6,
        yOffset: 0.35,
        angle: -0.02,
      ), */
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        angle: 0,
        flipClockwise: true,
      ),
      CardState(
        xOffset: 0.7,
        yOffset: 0.4,
        angle: -0.03,
        flipClockwise: true,
      ),
    ],
    [
      /* CardState(
        xOffset: 0.1,
        yOffset: 0.4,
        angle: 0.03,
      ), */
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        angle: 0,
        flipClockwise: false,
      ),
      CardState(
        xOffset: 0,
        yOffset: 0.4,
        angle: 0.05,
        flipClockwise: false,
      ),
    ],
    [
      /* CardState(
        xOffset: 0.15,
        yOffset: 0.1,
        angle: 0.01,
      ), */
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        angle: 0,
        flipClockwise: false,
      ),
      CardState(
        xOffset: 0,
        yOffset: 0.05,
        angle: -0.02,
        flipClockwise: false,
      ),
    ],
    [
      /*  CardState(
        xOffset: 0.6,
        yOffset: 0.1,
        angle: 0.03,
      ), */
      CardState(
        xOffset: 0.325,
        yOffset: 0.375,
        angle: 0,
        flipClockwise: true,
      ),
      CardState(
        xOffset: 0.65,
        yOffset: 0.05,
        angle: 0.01,
        flipClockwise: true,
      ),
    ],
    // QUESTION CARD BELOW
    /* [
      CardState(
        xOffset: 0.5,
        yOffset: 0.5,
        angle: 0,
        isQuestion: true,
      ),
      CardState(
        xOffset: 0.5,
        yOffset: 0.5,
        angle: 0,
      ), 
    ],*/
  ];

  void startGame({Duration duration = const Duration(seconds: 0)}) async {
    isInitial = !isInitial;
    await Future.delayed(
      // Duration(seconds: 1),
      duration,
    );
    controller.forward();
  }

  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );

    startGame(duration: Duration(seconds: 1));

    animation = new CurvedAnimation(
      // curve: Curves.easeOut,
      curve: SlowCurve(),
      // reverseCurve: Curves.easeIn,
      reverseCurve: SlowCurve().flipped,
      parent: controller,
    );
    super.initState();
  }

  void processPress() {
    setState(() {
      // isInitial ? backward() : forward();
      isInitial = !isInitial;
      if (isInitial) {
        backward();
      } else {
        forward();
      }
      // controller.forward();
      print("isInitial: $isInitial");
    });
  }

  void forward() {
    controller.forward();
    /* print("");
    print("Forward");
    print(""); */
  }

  void backward() {
    controller.reverse();
    /* print("");
    print("Reverse");
    print(""); */
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: Stack(
        children: [
          ...cardStates.map((List<CardState> cardState) {
            /* double widthVal =
              (size.width * cardState[1].xOffset * animation.value) +
                  (size.width * cardState[0].xOffset * (1 - animation.value)); */
            double heightVal = (size.height *
                    cardState[1].yOffset *
                    animation.value) +
                (cardState[0].yOffset * (1 - animation.value) * size.height);
            double angleVal = 2 *
                math.pi *
                (cardState[1].angle * animation.value +
                    cardState[0].angle * (1 - animation.value));
            print(animation.value);
            return AnimatedBuilder(
              animation: controller,
              builder: (context, w) {
                return Positioned(
                  left: (size.width * cardState[1].xOffset * animation.value) +
                      (size.width *
                          cardState[0].xOffset *
                          (1 - animation.value)),
                  // top: heightVal,
                  top: (size.height * cardState[1].yOffset * animation.value) +
                      (cardState[0].yOffset *
                          (1 - animation.value) *
                          size.height),
                  child: GestureDetector(
                    onTap: processPress,
                    child: Transform.rotate(
                      // angle: angleVal,
                      // angle: animation.value,
                      angle: 2 *
                          math.pi *
                          (cardState[1].angle * animation.value +
                              cardState[0].angle * (1 - animation.value)),
                      child: Transform(
                        // transform: Matrix4.identity()
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0015)
                          ..rotateY(
                            cardState[0].flipClockwise
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
                            color: cardState[0].isQuestion
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(
                              color: cardState[0].isQuestion
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
              },
            );
          }).toList(),
          GestureDetector(
            onTap: () {
              startGame(duration: Duration(seconds: 0));
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
