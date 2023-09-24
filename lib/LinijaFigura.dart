import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fonis_hackathon/Game.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Figura.dart';

class LinijaFigura extends Figura {
  // static final double limitY = 50;
  static final String pathDoSlikePadajuceFigure = 'assets/linija.png';

  static const double fallingSpeed = 130;
  static const double screenHeight = 320;




  // IgracFigura igrac;
  // bool zavrsen=false;

  LinijaFigura(double x0, double y0, Size size, ImageMap imageMap):
        super(pathDoSlikePadajuceFigure, x0, y0, size, imageMap) {
    Vx = 0;
    Vy = fallingSpeed;
  }

  @override
  update(double dt) {
    super.update(dt);
    // double tempX=160+y*5/320*(x-160);
    // position = Offset(x, y);
    if(position.dy<this.size.height/2) this.visible=false;
    else this.visible=true;
    if (position.dy >= screenHeight) {
      position += const Offset(0,
          -GameState.numberOfCollectibles * GameState.baseCollectibleHeighGap);
      // Random random = Random();
      this.visible = true;
      // zavrsen=false;
    }
  }
}
