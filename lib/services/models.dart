import 'package:flutter/material.dart';
import 'dart:math' as math;

class GameCard extends StatelessWidget {
  final String text;
  final bool isQuestion;
  final CardState cardState;
  final AnimationController animation;

  GameCard({
    Key key,
    this.text,
    this.isQuestion,
    this.cardState,
    this.animation,
  });

  Curve animationCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    Color decorations = isQuestion ? Colors.white : Colors.black;
    Color background = isQuestion ? Colors.black : Colors.white;
    return AnimatedBuilder(
        // animation: animationCurve,
        animation: this.animation,
        builder: (context, child) {
          return Positioned(
            left: cardState.xOffset,
            top: cardState.yOffset,
            child: Transform.rotate(
              angle: cardState.degrees * (math.pi / 180),
              child: AnimatedContainer(
                height: 320,
                width: 180,
                curve: animationCurve,
                duration: Duration(
                  milliseconds: 500,
                ),
                decoration: BoxDecoration(
                  color: background,
                  border: Border.all(
                    color: decorations,
                    width: 8,
                  ),
                ),
              ),
            ),
          );
        });

    /* Widget build(BuildContext context) {
    Color decorations = isQuestion ? Colors.white : Colors.black;
    Color background = isQuestion ? Colors.black : Colors.white;
    return AnimatedPositioned(
      duration: Duration(
        milliseconds: 500,
      ),
      curve: animationCurve,
      left: cardState.xOffset,
      top: cardState.yOffset,
      child: Transform.rotate(
        angle: cardState.degrees * (math.pi / 180),
        child: AnimatedContainer(
          height: 320,
          width: 180,
          curve: animationCurve,
          duration: Duration(
            milliseconds: 500,
          ),
          decoration: BoxDecoration(
            color: background,
            border: Border.all(
              color: decorations,
              width: 8,
            ),
          ),
        ),
      ),
    ); */
  }
}

Widget test = Transform.rotate(angle: 15);

class CardState {
  final double xOffset;
  final double yOffset;
  final double degrees;
  final AnimationController controller;

  CardState({
    this.xOffset,
    this.yOffset,
    this.degrees,
    this.controller,
  });
}
