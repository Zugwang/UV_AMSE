import 'package:flutter/material.dart';

import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _value = 20;
    return Scaffold(
        appBar: AppBar(
          title: Text('Display image'),
        ),
        // body: Center(child: Image.network("https://picsum.photos/1024")));
        body: Center(
          child: Image.asset(
            'assets/images/shark.png',
            width: 350,
            height: 350,
            fit: BoxFit.cover,
          ),
        ));
  }
}
