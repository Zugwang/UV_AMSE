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
  bool isBlank;
  int firstPos;
  int taille;
  Alignment alignment;

  Tile(
      {required this.firstPos,
      required this.image,
      required this.taille,
      required this.alignment,
      this.isBlank = false});
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  int tileWidgetPos = 0;

  TileWidget({required this.tile, required int tileWPos}) {
    tileWidgetPos = tileWPos;
  }

  @override
  Widget build(BuildContext context) {
    return this.renderCroppedTile();
  }

  Widget renderCroppedTile() {
    if (tile.isBlank == false) {
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
          color: Colors.white,
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
      double Align_x = (((x - 1) * (2)) / (taille - 1)) - 1;
      double Align_y = (((y - 1) * (2)) / (taille - 1)) - 1;
      Tile newTile = Tile(
        alignment: Alignment(Align_x, Align_y),
        taille: taille,
        image: 'poisson_bleu.jpg',
        firstPos: newID,
        isBlank: false,
      );
      l.add(Padding(
          padding: EdgeInsets.all(0.4),
          child: TileWidget(tile: newTile, tileWPos: newID)));
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
}
