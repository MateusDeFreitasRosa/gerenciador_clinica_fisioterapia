import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSharedPreference(key, value) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  if (value is int) {
    sharedPreferences.setInt(key, value);
  } else if (value is double) {
    sharedPreferences.setDouble(key, value);
  } else if (value is bool) {
    sharedPreferences.setBool(key, value);
  } else if (value is List<String>) {
    sharedPreferences.setStringList(key, value);
  } else if (value is String) {
    sharedPreferences.setString(key, value);
  } else {
    throw ('Não é possível salvar esse tipo de dado no SharedPreference');
  }
}

dynamic loadSharedPreference(key) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  return sharedPreferences.get(key);
}

Future<bool> containsKeySharedPreferene(key) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  return sharedPreferences.containsKey(key);
}

Future<void> removeSharedPreference(key) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.remove(key);
}
