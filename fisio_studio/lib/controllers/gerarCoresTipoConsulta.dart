import 'dart:math';
import 'package:flutter/cupertino.dart';

String gerarCores() {
  dynamic rnd = Random();
  dynamic r = rnd.nextInt(13) * 16;
  dynamic g = rnd.nextInt(13) * 16;
  dynamic b = rnd.nextInt(13) * 16;
  return [255, r, g, b].join(',');
}

Color buildColor(String coloresRGB) {
  dynamic splited = coloresRGB.split(',');
  splited = splited.map((e) => int.parse(e)).toList();

  Color color = Color.fromARGB(splited[0], splited[1], splited[2], splited[3]);
  return color;
}
