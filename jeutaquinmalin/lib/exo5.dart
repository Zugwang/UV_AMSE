import 'package:flutter/material.dart';
import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tile non unfortunate'),
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
  int taille = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[GridView(gridDelegate: gridDelegate)]);
  }
}
