import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  Color color = const Color.fromARGB(255, 32, 206, 75);

  Tile(this.color);

  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  int tileID = 0;

  TileWidget({required this.tile, int tilePos = 0}) {
    tileID = tilePos;
  }

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        padding: EdgeInsets.all(70.0),
        child: Text(this.tileID.toString()));
  }
}

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Generation de Tile'),
        ),
        body: Center(
          child: PositionedTiles(),
        ));
  }
}

List<Widget> generateCroppedTileList(int taille) {
  List<Widget> l = [];
  int newID = 12;

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
