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

class GenerateTile extends StatefulWidget {
  @override
  _GenerateTile createState() => _GenerateTile();
}

class _GenerateTile extends State<GenerateTile> {
  double taille = 2.0;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*Container(
            child:*/
          Align(
            alignment: Alignment.center,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              crossAxisCount: 2, //taille.toInt(),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.amber[600],
                  child: const Text("He'd have you all unravel at the"),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Color.fromARGB(255, 196, 223, 178),
                  child: const Text("He'd have you all unravel at the"),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Color.fromARGB(255, 195, 69, 11),
                  child: const Text('Heed not the rabble'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[300],
                  child: const Text('Sound of screams but the'),
                ),
              ],
            ),
          ),
          //),
          Slider(
              value: taille,
              min: 2.0,
              max: 7.0,
              divisions: 7,
              label: taille.round().toString(),
              onChanged: (double t) {
                setState(() {
                  taille = t;
                });
              })
        ]);
  }
}
