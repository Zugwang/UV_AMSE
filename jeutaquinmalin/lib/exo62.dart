import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  Color color = const Color.fromARGB(255, 32, 206, 75);
  String name = "";
  bool isEmpty = false;
  Tile(this.color);

  Tile.randomColor() {
    this.color = Color.fromARGB(
        128, random.nextInt(128), random.nextInt(128), random.nextInt(128));
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  int tileCurrentPos = 0;

  TileWidget({required this.tile, required int tilePos}) {
    tileCurrentPos = tilePos;
  }

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        padding: EdgeInsets.all(70.0),
        child: Text(tile.name));
  }
}

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Generation de Tile'),
        ),
        body: PositionedTiles());
  }
}

List<Widget> generateCroppedTileList(int taille) {
  List<Widget> l = [];
  int newID = 1;
  int caseVide = 0;

  for (var y = 1; y < taille + 1; y++) {
    for (var x = 1; x < taille + 1; x++) {
      l.add(Padding(
          padding: EdgeInsets.all(0.4),
          child: TileWidget(tile: Tile.randomColor(), tilePos: newID)));

      newID++;
    }
  }

  return l;
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

void shuffleTile(List<Widget> l, int taille, int vide) {
  int tirage = math.Random().nextInt(taille - 1);
  int cote = math.Random().nextInt(4);

  if (cote == 0) {
    tirage += 1;
  }
  if (cote == 1) {
    tirage -= 1;
  }
  if (cote == 2) {
    tirage += taille;
  }
  if (cote == 3) {
    tirage -= taille;
  }

  while (!areNextTo(tirage, vide, taille)) {
    cote = math.Random().nextInt(4);

    if (cote == 0) {
      tirage += 1;
    }
    if (cote == 1) {
      tirage -= 1;
    }
    if (cote == 2) {
      tirage += taille;
    }
    if (cote == 3) {
      tirage -= taille;
    }
  }
}

List<Widget> genRandCroppedTileList(int taille, int coup, List<Widget> l) {
  for (var y = 0; y < coup + 1; y++) {}
  return l;
}

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  double taille = 5.0;
  List<Widget> tiles = [];

  PositionedTilesState() {
    tiles = generateCroppedTileList(taille.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*Container(
            child:*/
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

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
