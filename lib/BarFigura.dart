import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fonis_hackathon/Game.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Figura.dart';

class BarFigura extends Figura {
  // static final double limitY = 50;
  static final String pathDoSlikePadajuceFigure = 'assets/bluebar.png';




  // IgracFigura igrac;
  // bool zavrsen=false;

  BarFigura(double x0, double y0, Size size, ImageMap imageMap):
        super(pathDoSlikePadajuceFigure, x0, y0, size, imageMap) {
    Vx = 0;
    Vy = 0;
  }

}
