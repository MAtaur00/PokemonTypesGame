import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokemonprj/playerSettings.dart';
import 'package:provider/provider.dart';

class CurrentLobbies extends StatefulWidget {
  @override
  _CurrentLobbiesState createState() => _CurrentLobbiesState();
}

class _CurrentLobbiesState extends State<CurrentLobbies> {
  TextEditingController _newGameName;

  CollectionReference lobbies;
  ScrollController _sCotroller;
  List<DocumentSnapshot> documents;
  int totalGames;
  @override
  void initState() {
    //For the new game creation
    _newGameName = TextEditingController();
    _newGameName.text = 'Game';

    //For the wating lobby
    lobbies = FirebaseFirestore.instance.collection("lobbies");
    _sCotroller = ScrollController();
    documents = null;
    totalGames = 0;
    lobbies.snapshots().listen((querysnap) {
      setState(() {
        documents = querysnap.docs;
        totalGames = documents.length;
      });
    });
    super.initState();
  }

  Future<DocumentReference> createLobby() async {
    DocumentReference lobby =
        await FirebaseFirestore.instance.collection("lobbies").add({
      'Name': _newGameName.text,
      'P1': PlayerSettingsLocalization.of(context).name,
      'P1Type': -1,
      'P1Rematch': false,
      'P2': 'Empty',
      'P2Type': -1,
      'P2Rematch': false,
      'Full': false,
      'Running': false,
    });
    return lobby;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select or create a game | Total Games $totalGames'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[600],
        child: Icon(Icons.add_circle_outline),
        tooltip: "Create game",
        onPressed: () {
          createGameShowDialog(context);
        },
      ),
      body: ListView.separated(
        controller: _sCotroller,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: totalGames,
        itemBuilder: (context, i) {
          return InkWell(
            child: ListTile(
                title: Text('Game ${i + 1}: ${documents[i].data()["Name"]}')),
            onTap: () {
              if (!documents[i].data()['Full']) {
                DocumentReference lobby = FirebaseFirestore.instance
                    .collection("lobbies")
                    .doc(documents[i].id);
                lobby.update({
                  'P2': PlayerSettingsLocalization.of(context).name,
                  'Full': true,
                });
                Provider.of<PlayerSettings>(context, listen: false).lobbyID =
                    lobby.id;
                Navigator.of(context).pushNamed('/LS').then((close) {
                  if (close) lobby.delete();
                });
              }
            },
          );
        },
      ),
    );
  }

  Future createGameShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Game"),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _newGameName,
              decoration: InputDecoration(labelText: 'Game name'),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Create"),
              onPressed: () async {
                DocumentReference lobby = await createLobby();
                Provider.of<PlayerSettings>(context, listen: false).lobbyID =
                    lobby.id;
                Navigator.of(context).pushReplacementNamed('/LS').then((close) {
                  if (close) {
                    lobby.delete();
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
