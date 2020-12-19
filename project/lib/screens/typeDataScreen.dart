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
          Expanded(flex: 7, child: _Header(widget.typeData)),
          Expanded(flex: 5, child: _Overview(widget.typeData)),
          Expanded(flex: 5, child: _TypeExamples(widget.typeData)),
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
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              currentType.data()["name"] + " type",
              style: TextStyle(
                fontSize: 25,
                color: Colors.yellow[300],
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Image.asset(
                currentType.data()["img"],
                fit: BoxFit.fitHeight,
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SectionTitle("Overview"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: weaknesses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(weaknesses[index] + " type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Divider(thickness: 2),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: resistances.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(resistances[index] + " type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Divider(thickness: 2),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
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
        Container(
          child: Icon(
            Icons.remove,
            color: Colors.orange,
            size: 27,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SectionTitle(
                "Strong " + currentType.data()["name"] + " type Pokémon"),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(currentType.data()["strongPokemon1img"]),
                Text(
                  currentType.data()["strongPokemon1"],
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(currentType.data()["strongPokemon2img"]),
                Text(
                  currentType.data()["strongPokemon2"],
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(currentType.data()["strongPokemon3img"]),
                Text(
                  currentType.data()["strongPokemon3"],
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
