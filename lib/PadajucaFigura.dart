import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fondigital_hackathon/Game.dart';
import 'package:fondigital_hackathon/IgracFigura.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Figura.dart';

class PadajucaFigura extends Figura {
  static final double limitY = 50;
  // static final String pathDoSlikePadajuceFigure = 'assets/apple.png';
  static final List<String> pathovi = ['chips', 'fuel_can', 'coffe'];

  static const double fallingSpeed = 150;
  static const double screenHeight = 320;

  double x = 0, y = 0;

  IgracFigura igrac;
  bool zavrsen = false;

  PadajucaFigura(double x0, double y0, Size size, ImageMap imageMap,
      IgracFigura igracFigura)
      : igrac = igracFigura,
        super('assets/${pathovi[new Random().nextInt(pathovi.length)]}.png', x0,
            y0, size, imageMap) {
    x = x0;
    y = y0;
    Vx = 0;
    Vy = fallingSpeed;
  }

  @override
  update(double dt) {
    super.update(dt);
    x += Vx * dt;
    y += Vy * dt;
    // double tempX=160+y*5/320*(x-160);
    // position = Offset(x, y);
    if (position.dy < this.size.height / 2)
      this.visible = false;
    else if (!zavrsen) this.visible = true;
    if (this.visible) {
      if (igrac.checkCollision(this)) {
        this.visible = false;
        GameState.score++;
        print(GameState.score);
        zavrsen = true;
      }
    }
    if (position.dy >= screenHeight) {
      position += const Offset(0,
          -GameState.numberOfCollectibles * GameState.baseCollectibleHeighGap);
      // Random random = Random();
      this.visible = true;
      zavrsen = false;
    }
  }
}
