import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';
import 'Game.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  WidgetsFlutterBinding.ensureInitialized();

  ImageMap _imageMap = ImageMap();

  await _imageMap.load(<String>['assets/apple.png', 'assets/car.png']);

  Game myWidget = Game(imageMap: _imageMap);

  runApp(GestureDetector(
      onPanDown: (e) {
        const double sredinaEkrana = 100;

        if (e.globalPosition.dx >= sredinaEkrana) {
          myWidget.mws.igrac.udesno();
        } else {
          myWidget.mws.igrac.ulevo();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/one_lane_street.png',
              ),
              fit: BoxFit.cover),
        ),
        child: myWidget,
      )));
}
