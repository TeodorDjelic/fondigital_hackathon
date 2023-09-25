import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fondigital_hackathon/Game.dart';
import 'package:fondigital_hackathon/PadajucaFigura.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Figura.dart';

class IgracFigura extends Figura {
  static final String pathDoSlikeIgracFigure = 'assets/car.png';

  static const double turnSpeed = 300;
  static const double turnAngle = 32.5;

  int desiredLane = 1;
  bool isRightTurn = false;

  IgracFigura(double x0, double y0, Size size, ImageMap imageMap)
      : super(pathDoSlikeIgracFigure, x0, y0, size, imageMap) {
    Vx = Vy = 0;
  }

  @override
  update(double dt) {
    super.update(dt);
    if (position.dx > GameState.lanes[desiredLane] && isRightTurn) {
      position = Offset(GameState.lanes[desiredLane], position.dy);
      Vx = 0;
      this.rotation = 0;
    } else if (position.dx < GameState.lanes[desiredLane] && !isRightTurn) {
      position = Offset(GameState.lanes[desiredLane], position.dy);
      Vx = 0;
      this.rotation = 0;
    }
  }

  void udesno() {
    if (desiredLane == GameState.lanes.length - 1) return;
    isRightTurn = true;
    Vx = turnSpeed;
    desiredLane += 1;
    this.rotation = turnAngle;
  }

  void ulevo() {
    if (desiredLane == 0) return;
    isRightTurn = false;
    Vx = -turnSpeed;
    desiredLane -= 1;
    this.rotation = -turnAngle;
  }

  bool checkCollision(PadajucaFigura pf) {
    return (pf.position.dy - position.dy) <= size.height &&
        (position.dy - pf.position.dy) <= pf.size.height &&
        (position.dx - pf.position.dx) <= pf.size.width &&
        (pf.position.dx - position.dx) <= size.width;
  }
}
