import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'screens/typeListScreen.dart';
import 'screens/mainScreen.dart';
import 'playerSettings.dart';
import 'pokemonType.dart';

//void main() => runApp(PokemonTypeApp());

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      routes: {
        '/': (context) => MainScreen(), //Main menu
        '/TLS': (context) => TypeListScreen(),
      },
    );
  }
}
