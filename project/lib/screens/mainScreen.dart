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

    FirebaseFirestore.instance.collection("types").get().then((query) {
      Provider.of<PlayerSettings>(context, listen: false).types = query.docs;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokémon Type Battle')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset("typeBattleTitle.png"),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                heightFactor: 2.3,
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 70.0,
                  buttonColor: Colors.teal,
                  child: RaisedButton(
                    child: Text(
                      'Play',
                      style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<PlayerSettings>(context, listen: false).name =
                          _textController.text;
                      Navigator.of(context).pushNamed('/CL');
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                heightFactor: 1.0,
                child: new ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 50.0,
                      buttonColor: Colors.teal,
                      child: RaisedButton(
                        child: Text(
                          'Type list',
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/TLS', arguments: false);
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 50.0,
                      buttonColor: Colors.teal,
                      child: RaisedButton(
                        child: Text(
                          'Instructions',
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/IP');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     widthFactor: 4.0,
              //     heightFactor: 5.5,
              //     child: RaisedButton(
              //       child: Text('Exit'),
              //       onPressed: () {
              //         exit(0);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
