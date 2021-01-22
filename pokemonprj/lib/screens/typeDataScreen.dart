import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pokemonType.dart';

class TypePage extends StatefulWidget {
  final PokemonType pkmType;
  TypePage(this.pkmType);

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
          Container(child: _Header(widget.pkmType)),
          Expanded(child: _Overview(widget.pkmType)),
          Expanded(child: _TypeExamples(widget.pkmType)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final PokemonType pkmType;

  _Header(this.pkmType);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              pkmType.typeName + " type",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Image.asset(
                pkmType.icon,
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
  final PokemonType pkmType;

  _Overview(this.pkmType);

  @override
  Widget build(BuildContext context) {
    List<String> weaknesses = List.from(pkmType.weaknesses);
    List<String> resistances = List.from(pkmType.resistances);
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SectionTitle("Weaknesses"),
                        Flexible(
                          child: SizedBox(
                            height: 200,
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: weaknesses.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[400],
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                weaknesses[index] + " type",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SectionTitle("Resistances"),
                        Flexible(
                          child: SizedBox(
                            height: 200,
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: resistances.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[400],
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                resistances[index] + " type",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
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
  final PokemonType pkmType;
  _TypeExamples(this.pkmType);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SectionTitle("Strong " + pkmType.typeName + " type Pokémon"),
              Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          pkmType.strongP1img,
                          fit: BoxFit.fitHeight,
                        ),
                        Text(
                          pkmType.strongP1,
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
                          pkmType.strongP2img,
                          fit: BoxFit.fitHeight,
                        ),
                        Text(
                          pkmType.strongP2,
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
                          pkmType.strongP3img,
                          fit: BoxFit.fitHeight,
                        ),
                        Text(
                          pkmType.strongP3,
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
