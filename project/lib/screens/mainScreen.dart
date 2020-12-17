import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../PlayerSettings.dart';
import 'typeListScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    _textController.text = 'Player';
    //We will get the stand info only once, as we know stand info will never change
    FirebaseFirestore.instance.collection("types").get().then((query) {
      Provider.of<PlayerSettings>(context, listen: false).types = query.docs;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Pokémon Type Calculator')),
        body: Center(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(labelText: 'Enter your name'),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  widthFactor: 4.0,
                  heightFactor: 5.5,
                  child: RaisedButton(
                    child: Text('List'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/TLS');
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
