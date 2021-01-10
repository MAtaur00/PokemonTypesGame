import 'dart:convert';
import 'dart:io';

class PokemonType {
  String typeName;
  String icon;

  List<String> weaknesses;

  List<String> resistances;

  String strongP1, strongP2, strongP3;
  String strongP1img, strongP2img, strongP3img;

  PokemonType(
    this.typeName,
    this.icon,
    this.weaknesses,
    this.resistances,
    this.strongP1,
    this.strongP2,
    this.strongP3,
    this.strongP1img,
    this.strongP2img,
    this.strongP3img,
  );

  PokemonType.fromJson(Map<String, dynamic> json)
      : typeName = json['name'],
        icon = json['img'],
        weaknesses = List.from(json["weaknesses"]),
        resistances = List.from(json["resistances"]),
        strongP1 = json['strongPokemon1'],
        strongP2 = json['strongPokemon2'],
        strongP3 = json['strongPokemon3'],
        strongP1img = json['strongPokemon1img'],
        strongP2img = json['strongPokemon2img'],
        strongP3img = json['strongPokemon3img'];
}
