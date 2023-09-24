import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fonis_hackathon/Game.dart';
import 'package:fonis_hackathon/IgracFigura.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Figura.dart';

class PadajucaFigura extends Figura {
  static final double limitY = 50;
  static final String pathDoSlikePadajuceFigure = 'assets/apple.png';

  static const double fallingSpeed = 90;
  static const double screenHeight = 320;



  IgracFigura igrac;
  double startingY = 0;
  bool zavrsen=false;

  PadajucaFigura(double x0, double y0, Size size, ImageMap imageMap,
      IgracFigura igracFigura)
      : igrac = igracFigura,
        super(pathDoSlikePadajuceFigure, x0, y0, size, imageMap) {
    Vx = 0;
    Vy = fallingSpeed;
    startingY = y0;
  }

  @override
  update(double dt) {
    super.update(dt);
    if(position.dy<this.size.height/2) this.visible=false;
    else if(!zavrsen) this.visible=true;
    if (this.visible) {
      if (igrac.checkCollision(this)) {
        this.visible = false;
        GameState.score++;
        print(GameState.score);
        zavrsen=true;
      }
    }
    if (position.dy >= screenHeight) {
      position += const Offset(0,
          -GameState.numberOfCollectibles * GameState.baseCollectibleHeighGap);
      Random random = Random();
      this.visible = true;
      zavrsen=false;
    }
  }
}
