import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../playerSettings.dart';
import '../pokemonType.dart';

class TypeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> pokemonTypes =
        PlayerSettingsLocalization.of(context).types;

    return Scaffold(
      appBar: AppBar(
        title: Text('Typepedia'),
      ),
      body: ListView.builder(
        itemCount: pokemonTypes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(pokemonTypes[index].data()["name"] + " type",
                      style: TextStyle(
                          color: Colors.yellow[300],
                          fontWeight: FontWeight.bold)),
                  trailing: Image(
                    image: pokemonTypes[index].data()["img"],
                  ),
                  isThreeLine: true,
                ),
                Divider(thickness: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
