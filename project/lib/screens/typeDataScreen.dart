import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pokemonType.dart';

class TypePage extends StatefulWidget {
  final QueryDocumentSnapshot typeData;
  TypePage(this.typeData);

  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Type')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(child: _Header(widget.typeData)),
          Expanded(child: _Overview(widget.typeData)),
          Expanded(child: _TypeExamples(widget.typeData)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final QueryDocumentSnapshot currentType;

  _Header(this.currentType);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              currentType.data()["name"] + " type",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Image.asset(
                currentType.data()["img"],
                height: 50,
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final QueryDocumentSnapshot currentType;

  _Overview(this.currentType);

  @override
  Widget build(BuildContext context) {
    List<String> weaknesses = List.from(currentType.data()["weaknesses"]);
    List<String> resistances = List.from(currentType.data()["resistances"]);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SectionTitle("Battle properties"),
              Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   itemCount: weaknesses.length,
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(6.0),
                  //         child: Container(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: <Widget>[
                  //               ListTile(
                  //                 title: Text(weaknesses[index] + " type",
                  //                     style: TextStyle(
                  //                         color: Colors.black,
                  //                         fontSize: 12,
                  //                         fontWeight: FontWeight.bold)),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   itemCount: resistances.length,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.all(6.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: <Widget>[
                  //           ListTile(
                  //             title: Text(resistances[index] + " type",
                  //                 style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 12,
                  //                     fontWeight: FontWeight.bold)),
                  //           ),
                  //           Divider(thickness: 2),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TypeExamples extends StatelessWidget {
  final QueryDocumentSnapshot currentType;
  _TypeExamples(this.currentType);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SectionTitle(
                  "Strong " + currentType.data()["name"] + " type Pokémon"),
              Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          currentType.data()["strongPokemon1img"],
                          height: 150,
                          width: 150,
                        ),
                        Text(
                          currentType.data()["strongPokemon1"],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          currentType.data()["strongPokemon2img"],
                          height: 150,
                          width: 150,
                        ),
                        Text(
                          currentType.data()["strongPokemon2"],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          currentType.data()["strongPokemon3img"],
                          height: 150,
                          width: 150,
                        ),
                        Text(
                          currentType.data()["strongPokemon3"],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
