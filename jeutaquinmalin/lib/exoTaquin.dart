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
  Tile tile;
  int tileWidgetPos = 0;
  bool isBlank = false;

  TileWidget({required this.tile, required int tileWPos, required bool blank}) {
    tileWidgetPos = tileWPos;
    isBlank = blank;
  }

  void setBlank(bool val) {
    isBlank = val;
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

List<TileWidget> generateCroppedTileList(int taille) {
  List<TileWidget> l = [];
  int newID = 0;

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
      l.add(TileWidget(
        tile: newTile,
        tileWPos: newID,
        blank: blank,
      ));
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
  int blankTile = 1;
  List<TileWidget> tiles = [];

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
                  tiles = shuffle(3, tiles);
                });
              })
        ]);
  }

  bool areNextTo(int tile1, int tile2, int taille) {
    if (tile1 < 1 && tile1 > taille * taille - 1) {
      return false;
    }
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

  List<TileWidget> swapTiles(int newTile, List<TileWidget> tiles) {
    setState(() {
      print(blankTile);
      TileWidget temp = tiles[newTile];
      int tempPos = tiles[newTile].tileWidgetPos;
      blankTile = newTile;
      print(blankTile);
      print(tempPos);
      print(temp);

      tiles[newTile] = tiles[blankTile];
      tiles[newTile].tileWidgetPos = tiles[blankTile].tileWidgetPos;
      tiles[blankTile].tileWidgetPos = tempPos;
    });
    return tiles;
  }

  List<TileWidget> shuffle(int nbre, List<TileWidget> tiles) {
    for (int i = 0; i < nbre; i++) {
      int direction = random.nextInt(4);
      int newTile;
      switch (direction) {
        case 0:
          newTile = tiles[blankTile].tileWidgetPos - 1;
          break;
        case 1:
          newTile = tiles[blankTile].tileWidgetPos + 1;
          break;
        case 2:
          newTile = tiles[blankTile].tileWidgetPos - taille.toInt();
          break;
        case 3:
          newTile = tiles[blankTile].tileWidgetPos + taille.toInt();
          break;
        default:
          newTile = 0;
          break;
      }

      if (areNextTo(newTile, blankTile, taille.toInt())) {
        tiles = swapTiles(newTile, tiles);
      }
    }
    return tiles;
  }
}
