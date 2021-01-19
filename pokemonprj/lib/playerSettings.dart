import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerSettings with ChangeNotifier {
  String _name = 'Player';
  String get name => _name;

  List<DocumentSnapshot> _types;
  List<DocumentSnapshot> get types => _types;

  String _lobbyID = '';
  String get lobbyID => _lobbyID;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set lobbyID(String lobbyID) {
    _lobbyID = lobbyID;
    notifyListeners();
  }

  set types(List<DocumentSnapshot> types) {
    _types = types;
    notifyListeners();
  }
}

class PlayerSettingsLocalization {
  static PlayerSettingsLocalization of(BuildContext context) {
    return Localizations.of<PlayerSettingsLocalization>(
        context, PlayerSettingsLocalization);
  }

  const PlayerSettingsLocalization(this._name, this._lobbyID, this._types);

  final String _name;
  final String _lobbyID;
  final List<DocumentSnapshot> _types;

  String get name => _name;
  String get lobbyID => _lobbyID;
  List<DocumentSnapshot> get types => _types;
}

class PlayerSettingsDelegate
    extends LocalizationsDelegate<PlayerSettingsLocalization> {
  const PlayerSettingsDelegate(this.name, this.lobbyID, this.types);

  final String name;
  final String lobbyID;
  final List<DocumentSnapshot> types;

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<PlayerSettingsLocalization> load(Locale locale) {
    return SynchronousFuture(PlayerSettingsLocalization(name, lobbyID, types));
  }

  @override
  bool shouldReload(PlayerSettingsDelegate old) {
    return (old.name != name || old.lobbyID != lobbyID || old.types != types);
  }
}
