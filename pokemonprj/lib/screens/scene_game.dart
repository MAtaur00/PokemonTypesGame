import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokemonprj/playerSettings.dart';

class SceneGame extends StatefulWidget {
  @override
  _SceneGameState createState() => _SceneGameState();
}

class _SceneGameState extends State<SceneGame> {
  DocumentReference lobbyRef;
  DocumentSnapshot typeP1;
  DocumentSnapshot typeP2;
  String winner;

  bool closing;

  @override
  void initState() {
    closing = false;

    winner = "";

    super.initState();
  }

  @override
  void didChangeDependencies() {
    lobbyRef = FirebaseFirestore.instance
        .collection('lobbies')
        .doc(PlayerSettingsLocalization.of(context).lobbyID);
    lobbyRef.snapshots().listen((snap) {
      if (snap.data()["P1Rematch"] && snap.data()["P2Rematch"]) {
        closing = true;

        lobbyRef.update({
          "P1Rematch": false,
          "P2Rematch": false,
        });
        Navigator.of(context).pushReplacementNamed('/TLS', arguments: true);
      }
    });

    //Calculate game outcome
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: lobbyRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (closing) {
              return Center(child: CircularProgressIndicator());
            }
            typeP1 = PlayerSettingsLocalization.of(context).types[
                (snapshot.data["P1type"] != -1) ? snapshot.data["P1type"] : 0];
            typeP2 = PlayerSettingsLocalization.of(context).types[
                (snapshot.data["P2type"] != -1) ? snapshot.data["P2type"] : 0];
            calculateGameOutcome();
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: _PlayersPhotos(typeP1, typeP2),
                ),
                Expanded(
                  flex: 3,
                  child: _GameResults(winner),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Exit to Lobby'),
                        onPressed: () {
                          closing = true;

                          bool closeLobby = (snapshot.data['P1'] == 'Empty' ||
                              snapshot.data['P2'] == 'Empty');
                          lobbyRef.update({
                            (snapshot.data['P1'] ==
                                    PlayerSettingsLocalization.of(context).name)
                                ? 'P1'
                                : 'P2': 'Empty',
                            'Running': closeLobby,
                          });
                          Navigator.of(context).pop(closeLobby);
                        },
                      ),
                      RaisedButton(
                        child: Text('Rematch'),
                        onPressed: () {
                          lobbyRef.update({
                            (snapshot.data['P1'] ==
                                    PlayerSettingsLocalization.of(context).name)
                                ? 'P1Rematch'
                                : 'P2Rematch': true,
                          });
                          if (snapshot.data["P1Rematch"] ||
                              snapshot.data["P2Rematch"]) {
                            lobbyRef.update({
                              'P1type': -1,
                              'P2type': -1,
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void calculateGameOutcome() {
    bool p1resistsp2 = false;
    bool p2resistsp1 = false;
    bool p1weakTop2 = false;
    bool p2weakTop1 = false;

    List<String> p1weaknesses = List.from(typeP1.data()["weaknesses"]);
    List<String> p1resistances = List.from(typeP1.data()["resistances"]);

    List<String> p2weaknesses = List.from(typeP2.data()["weaknesses"]);
    List<String> p2resistances = List.from(typeP2.data()["resistances"]);

    if (p1weaknesses.contains(typeP2.data()['name'])) {
      p1weakTop2 = true;
    }

    if (p2weaknesses.contains(typeP1.data()['name'])) {
      p2weakTop1 = true;
    }

    if (p1resistances.contains(typeP2.data()['name'])) {
      p1resistsp2 = true;
    }

    if (p2resistances.contains(typeP1.data()['name'])) {
      p2resistsp1 = true;
    }

//player 1 wins

    if (p1resistsp2 && !p2resistsp1) {
      winner = typeP1.data()['name'];
    }

    if (p2weakTop1 && !p1weakTop2) {
      winner = typeP1.data()['name'];
    }

//player 2 wins

    if (p2resistsp1 && !p1resistsp2) {
      winner = typeP2.data()['name'];
    }

    if (p1weakTop2 && !p2weakTop1) {
      winner = typeP2.data()['name'];
    }

//draw

    if (typeP1.data()['name'] == typeP2.data()['name'] ||
        p2resistsp1 && p1resistsp2 ||
        p1weakTop2 && p2weakTop1) {
      winner = "draw";
    }
  }
}

class _GameResults extends StatelessWidget {
  final String winner;
  const _GameResults(
    this.winner,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            (winner != 'draw') ? "$winner type WINS" : "IT'S A DRAW",
            style: TextStyle(
                fontSize: 25,
                color: Colors.yellow,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _PlayersPhotos extends StatelessWidget {
  final DocumentSnapshot typeP1;
  final DocumentSnapshot typeP2;

  _PlayersPhotos(
    this.typeP1,
    this.typeP2,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Image.asset(
            typeP1.data()['img'],
            fit: BoxFit.fitHeight,
          ),
        ),
        Expanded(
          child: Image.asset(
            typeP2.data()['img'],
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}
