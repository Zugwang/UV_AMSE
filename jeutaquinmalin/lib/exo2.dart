import 'package:flutter/material.dart';

import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shark rotating'),
        ),
        body: Center(
          child: ImageRotating(),
        ));
  }
}

class ImageRotating extends StatefulWidget {
  @override
  _ImageRotating createState() => _ImageRotating();
}

class _ImageRotating extends State<ImageRotating> {
  double _scale = 1;
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..scale(_scale)
              ..rotateZ(_rotate),
            child: Image.asset(
              'assets/images/shark.png',
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          Slider(
            min: 0.0,
            max: 20.0,
            value: _scale,
            onChanged: (double scale) {
              setState(() {
                _scale = scale;
              });
            },
          ),
          Slider(
            min: 0.0,
            max: 20.0,
            value: _rotate,
            onChanged: (double rotate) {
              setState(() {
                _rotate = rotate;
              });
            },
          ),
        ]);
  }
}
