import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';

late ImageMap _imageMap;

class Figura extends NodeWithSize {
  double Vx = 20;
  double Vy = 10;

  Figura(String imagePath, double x0, double y0, Size size, ImageMap imageMap)
      : super(size) {
    var image = imageMap[imagePath];

    Sprite sprite = Sprite.fromImage(image!);
    sprite.size = size;

    position = Offset(x0, y0);

    this.addChild(sprite);
  }

  @override
  update(double dt) {
    position += Offset(Vx * dt, Vy * dt);
  }

  void changeVelocity(double Vx0, double Vy0) {
    Vx = Vx0;
    Vy = Vy0;
  }
}
