import 'package:flutter/material.dart';

// import 'util.dart';
import 'exo1.dart' as exo1;
import 'exo2.dart' as exo2;
import 'exo4.dart' as exo4;
import 'exo5.dart' as exo5;
import 'exo52.dart' as exo52;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MenuPage());
  }
}

class Exo {
  final String title;
  final String subtitle;
  final WidgetBuilder buildFunc;

  const Exo(
      {required this.title, required this.subtitle, required this.buildFunc});
}

List exos = [
  Exo(
      title: 'Exercice 1',
      subtitle: 'Simple image de poisson',
      buildFunc: (context) => exo1.DisplayImageWidget()),
  Exo(
      title: 'Exercice 2',
      subtitle: 'Rotate&Scale image',
      buildFunc: (context) => exo2.DisplayImageWidget()),
  Exo(
      title: 'Exercice 4',
      subtitle: 'Un bout de tuile',
      buildFunc: (context) => exo4.DisplayTileWidget()),
  Exo(
      title: 'Exercice 5',
      subtitle: 'Generate tiles',
      buildFunc: (context) => exo5.DisplayImageWidget()),
  Exo(
      title: 'Exercice 5.2',
      subtitle: 'Generate tiles',
      buildFunc: (context) => exo52.DisplayImageWidget()),
];

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TP2'),
        ),
        body: ListView.builder(
            itemCount: exos.length,
            itemBuilder: (context, index) {
              var exo = exos[index];
              return Card(
                  child: ListTile(
                      title: Text(exo.title),
                      subtitle: Text(exo.subtitle),
                      trailing: Icon(Icons.play_arrow_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: exo.buildFunc),
                        );
                      }));
            }));
  }
}
