import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../playerSettings.dart';
import '../pokemonType.dart';

class TypeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference pokemonTypes =
        FirebaseFirestore.instance.collection('types');
    return Scaffold(
      appBar: AppBar(
        title: Text('Typepedia'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: pokemonTypes.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<QueryDocumentSnapshot> singularType = snapshot.data.docs;
            return ListView.builder(
              itemCount: singularType.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> typeProperties =
                    singularType[index].data();
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(typeProperties["name"] + " type",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        trailing: Image.asset(
                          typeProperties["img"],
                        ),
                      ),
                      Divider(thickness: 2),
                    ],
                  ),
                );
              },
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}

// class TypeListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<DocumentSnapshot> pokemonTypes =
//         PlayerSettingsLocalization.of(context).types;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Typepedia'),
//       ),
//       body: ListView.builder(
//         itemCount: pokemonTypes.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text(pokemonTypes[index].data()["name"] + " type",
//                       style: TextStyle(
//                           color: Colors.yellow[300],
//                           fontWeight: FontWeight.bold)),
//                   trailing: Image(
//                     image: pokemonTypes[index].data()["img"],
//                   ),
//                   isThreeLine: true,
//                 ),
//                 Divider(thickness: 2),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
