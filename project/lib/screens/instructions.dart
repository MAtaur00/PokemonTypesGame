import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instructions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Text(
                  "This is a two player game where each player has to choose "
                  "a Pokémon type and, according to its battle properties, "
                  "the winner will be one type or another one.\n\nBoth types "
                  "will be compared to each other and, if one has an edge "
                  "on the other, that type will be declared as the winner."
                  "\n\nIf no type has a real advantage, the battle will "
                  "result in a draw.",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
