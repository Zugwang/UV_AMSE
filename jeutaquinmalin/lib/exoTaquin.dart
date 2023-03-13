import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Generation de Tile'),
        ),
        body: jeuTaquin());
  }
}

class Tile {
  String image;
  int firstPos;
  int taille;
  Alignment alignment;

  Tile(
      {required this.firstPos,
      required this.image,
      required this.taille,
      required this.alignment});
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  int tileWidgetPos = 0;
  bool isBlank = false;

  TileWidget({required this.tile, required int tileWPos, required bool blank}) {
    tileWidgetPos = tileWPos;
    isBlank = blank;
  }

  void setBlank() {
    isBlank = true;
  }

  @override
  Widget build(BuildContext context) {
    return this.renderCroppedTile();
  }

  Widget renderCroppedTile() {
    if (isBlank == false) {
      return FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Container(
            child: Align(
              alignment: this.tile.alignment,
              widthFactor: 1 / tile.taille,
              heightFactor: 1 / tile.taille,
              child: Image.asset('assets/images/' + this.tile.image),
            ),
          ),
        ),
      );
    } else {
      return Container(
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.all(70.0),
          ));
    }
  }
}

List<Widget> generateCroppedTileList(int taille) {
  List<Widget> l = [];
  int newID = 1;

  for (var y = 1; y < taille + 1; y++) {
    for (var x = 1; x < taille + 1; x++) {
      bool blank = false;
      if (x == 1 && y == 1) {
        blank = true;
      }
      double Align_x = (((x - 1) * (2)) / (taille - 1)) - 1;
      double Align_y = (((y - 1) * (2)) / (taille - 1)) - 1;
      Tile newTile = Tile(
        alignment: Alignment(Align_x, Align_y),
        taille: taille,
        image: 'poisson_bleu.jpg',
        firstPos: newID,
      );
      l.add(Padding(
          padding: EdgeInsets.all(0.4),
          child: TileWidget(
            tile: newTile,
            tileWPos: newID,
            blank: blank,
          )));
      newID++;
    }
  }
  return l;
}

class jeuTaquin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => jeuTaquinState();
}

class jeuTaquinState extends State<jeuTaquin> {
  double taille = 5.0;
  List<Widget> tiles = [];

  jeuTaquinState() {
    tiles = generateCroppedTileList(taille.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              widthFactor: 1,
              heightFactor: 1,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                shrinkWrap: true,
                crossAxisCount: taille.toInt(),
                children: tiles,
              )),
          Slider(
              value: taille,
              min: 2.0,
              max: 8.0,
              divisions: 6,
              label: taille.round().toString(),
              onChanged: (double t) {
                setState(() {
                  taille = t;
                  tiles = generateCroppedTileList(taille.toInt());
                });
              })
        ]);
  }

  bool areNextTo(int tile1, int tile2, int taille) {
    if (tile2 == tile1 + 1 && tile2 % taille != 0) {
      return true;
    } else if (tile2 == tile1 - 1 && tile1 % taille != 0) {
      return true;
    } else if (tile2 == tile1 + taille && tile2 > taille - 1) {
      return true;
    } else if (tile2 == tile1 - taille && tile1 > taille - 1) {
      return true;
    } else {
      return false;
    }
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }

  void shuffle(int nbre) {
    for (int i = 0; i < nbre; i++) {
      int direction = random.nextInt(4);
      int newIndex;
      switch (direction) {
        case 0:
          newIndex = tiles[emptySlotIndex].index - 1;
          break;
        case 1:
          newIndex = tiles[emptySlotIndex].index + 1;
          break;
        case 2:
          newIndex = tiles[emptySlotIndex].index - size;
          break;
        case 3:
          newIndex = tiles[emptySlotIndex].index + size;
          break;
        default:
          newIndex = 0;
          break;
      }
      print("going to index $newIndex");
      if (checkRules(newIndex)) {
        swapTiles(newIndex);
      }
    }
  }
}
