import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'screens/typeListScreen.dart';
import 'screens/mainScreen.dart';
import 'playerSettings.dart';
import 'screens/current_lobbies.dart';
import 'screens/lobby_pre_game.dart';
import 'screens/scene_game.dart';
import 'screens/instructions.dart';

void main() => runApp(PokemonTypeApp());

class PokemonTypeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlayerSettings(),
        )
      ],
      child: Consumer<PlayerSettings>(
        builder: (context, pSettings, _) {
          return MaterialApp(
            supportedLocales: const [Locale('en')],
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              PlayerSettingsDelegate(
                  pSettings.name, pSettings.lobbyID, pSettings.types),
            ],
            theme: ThemeData(
              canvasColor: Colors.lightGreenAccent[100],
            ),
            routes: {
              '/': (context) => MainScreen(),
              '/TLS': (context) => TypeListScreen(),
              '/CL': (context) => CurrentLobbies(),
              '/IP': (context) => InstructionsPage(),
              '/LS': (context) => LobbyScreen(),
              '/SG': (context) => SceneGame(),
            },
          );
        },
      ),
    );
  }
}
