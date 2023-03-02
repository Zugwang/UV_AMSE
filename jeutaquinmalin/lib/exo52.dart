import 'package:flutter/material.dart';
import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Generation de Tile'),
        ),
        body: Center(
          child: GenerateTile(),
        ));
  }
}

class _ImageTile {
  String tileName;
  Alignment alignment;

  _ImageTile({this.tileName = 'poisson_bleu.jpg', required this.alignment});

  Widget croppedImageTile(int taille) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 1 / taille,
            heightFactor: 1 / taille,
            child: Image.asset('assets/images/' + this.tileName),
          ),
        ),
      ),
    );
  }
}

List<Widget> generateCroppedTileList(int taille) {
  List<Widget> l = [];

  for (var y = 1; y < taille + 1; y++) {
    for (var x = 1; x < taille + 1; x++) {
      double Align_x = (((x - 1) * (2)) / (taille - 1)) - 1;
      double Align_y = (((y - 1) * (2)) / (taille - 1)) - 1;

      l.add(Padding(
          padding: EdgeInsets.all(0.4),
          child: _ImageTile(alignment: Alignment(Align_x, Align_y))
              .croppedImageTile(taille)));
    }
  }

  return l;
}

class GenerateTile extends StatefulWidget {
  @override
  _GenerateTile createState() => _GenerateTile();
}

class _GenerateTile extends State<GenerateTile> {
  double taille = 3.0;

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
                children: generateCroppedTileList(taille.toInt())),
          ),
          Slider(
              value: taille,
              min: 2.0,
              max: 8.0,
              divisions: 6,
              label: taille.round().toString(),
              onChanged: (double t) {
                setState(() {
                  taille = t;
                });
              })
        ]);
  }
}
