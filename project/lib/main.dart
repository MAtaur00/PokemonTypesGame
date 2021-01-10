import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'screens/typeListScreen.dart';
import 'screens/mainScreen.dart';
import 'playerSettings.dart';
import 'pokemonType.dart';
import 'screens/current_lobbies.dart';
import 'screens/lobby_pre_game.dart';
import 'screens/scene_game.dart';
import 'screens/instructions.dart';

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
        '/CL': (context) => CurrentLobbies(),
        '/IP': (context) => InstructionsPage(),
        '/LS': (context) => LobbyScreen(),
        '/SG': (context) => SceneGame(),
      },
    );
  }
}
