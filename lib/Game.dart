import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fonis_hackathon/IgracFigura.dart';
import 'package:fonis_hackathon/PadajucaFigura.dart';
import 'package:spritewidget/spritewidget.dart';

class Game extends StatefulWidget {
  final ImageMap imageMap;
  final GameState mws;

  Game({Key? key, required this.imageMap})
      : mws = new GameState(imageMap),
        super(key: key);

  @override
  GameState createState() => mws;
}

class GameState extends State<Game> {
  late NodeWithSize rootNode;
  ImageMap imageMap;

  IgracFigura igrac;

  static int score = 0;

  static const List<double> lanes = [110, 160, 210];
  static const int startingPlayerLane = 2;
  static const double startingPlayerHeight = 200;

  static const double playerHeight = 40;
  static const double playerWidth = 65;

  static const double startingCollectibleHeight = 60;

  static const double collectibleHeight = 30;
  static const double collectibleWidth = 30;

  static const double baseCollectibleHeighGap = 60;
  static const double maxCollectibleHeightGapDeviation = 10;

  static const int numberOfCollectibles = 30;

  GameState(ImageMap this.imageMap)
      : igrac = IgracFigura(lanes[startingPlayerLane], startingPlayerHeight,
            Size(playerHeight, playerWidth), imageMap);

  @override
  void initState() {
    super.initState();
    Random random = Random();

    rootNode = NodeWithSize(const Size(320, 320));

    rootNode.addChild(igrac);

    List<PadajucaFigura> lista = [];

    for (int i = 0; i < numberOfCollectibles; i++) {
      int lane = random.nextInt(lanes.length);
      double y = startingCollectibleHeight -
          (i * baseCollectibleHeighGap +
              (2 * random.nextDouble() - 1) * maxCollectibleHeightGapDeviation);
      lista.add(new PadajucaFigura(lanes[lane], y,
          Size(collectibleWidth, collectibleHeight), imageMap, igrac));
      rootNode.addChild(lista[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(rootNode);
  }
}
