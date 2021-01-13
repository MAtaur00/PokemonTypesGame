import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/screens/typeDataScreen.dart';

import '../playerSettings.dart';
import '../pokemonType.dart';

// class TypeListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference pokemonTypes =
//         FirebaseFirestore.instance.collection('types');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Typepedia'),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: pokemonTypes.get(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text("Something went wrong");
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             List<QueryDocumentSnapshot> singularType = snapshot.data.docs;
//             return ListView.builder(
//               itemCount: singularType.length,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> typeProperties =
//                     singularType[index].data();
//                 return Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Column(
//                     children: <Widget>[
//                       ListTile(
//                         title: Text(typeProperties["name"] + " type",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold)),
//                         trailing: Image.asset(
//                           typeProperties["img"],
//                         ),
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) => TypePage(singularType[index]),
//                             ),
//                           );
//                         },
//                       ),
//                       Divider(thickness: 2),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return Text("loading");
//         },
//       ),
//     );
//   }
// }

class TypeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CollectionReference pokemonTypes =
    //     FirebaseFirestore.instance.collection('types');

    final bool gameSelection = ModalRoute.of(context).settings.arguments;
    final List<DocumentSnapshot> pokemonTypes =
        PlayerSettingsLocalization.of(context).types;
    int player = -1;
    if (gameSelection) {
      bool allSelected = false;
      DocumentReference lobby = FirebaseFirestore.instance
          .collection('lobbies')
          .doc(PlayerSettingsLocalization.of(context).lobbyID);
      lobby.get().then((snap) {
        if (snap.data()['P1'] == PlayerSettingsLocalization.of(context).name)
          player = 1;
        else
          player = 2;
      });
      lobby.snapshots().listen((snap) {
        if (!allSelected &&
            snap.data()['P1Type'] != -1 &&
            snap.data()['P2Type'] != -1) {
          allSelected = true;
          Navigator.of(context).pushReplacementNamed('/SG');
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Typepedia'),
      ),
      body: ListView.builder(
        itemCount: pokemonTypes.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> typeProperties = pokemonTypes[index].data();
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(typeProperties["name"] + " type",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  trailing: Image.asset(
                    typeProperties["img"],
                  ),
                  onTap: () {
                    final pkType =
                        PokemonType.fromJson(pokemonTypes[index].data());
                    if (!gameSelection) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TypePage(pkType),
                        ),
                      );
                    } else
                      preGameDialogOptions(context, pkType, index, player);
                  },
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

Future preGameDialogOptions(
    BuildContext context, PokemonType pkType, int typeID, int player) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Select type?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "Info",
              style: TextStyle(color: Colors.yellow[400]),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TypePage(pkType),
                ),
              );
            },
          ),
          FlatButton(
            child: Text(
              "Select",
              style: TextStyle(color: Colors.green[400]),
            ),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('lobbies')
                  .doc(PlayerSettingsLocalization.of(context).lobbyID)
                  .update({
                (player == 1) ? 'P1Type' : 'P2Type': typeID,
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
