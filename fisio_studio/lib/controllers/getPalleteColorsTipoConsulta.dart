import 'dart:convert';

import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/controllers/gerarCoresTipoConsulta.dart';
import 'package:fisio_studio/controllers/sharedPreference.dart';

Future<Map<String, String>> getPalleteColorsTipoConsulta(
    {String? tipoConsulta}) async {
  dynamic strListColors =
      await loadSharedPreference(palleteColorTypeAppointment) ?? '{}';

  Map<String, dynamic> queryParameters = jsonDecode(strListColors);
  Map<String, String> listConverted = queryParameters
      .map((key, value) => MapEntry(key, value?.toString() ?? ""));

  if (tipoConsulta != null) {
    if (!listConverted.containsKey(tipoConsulta)) {
      Map<String, String> palleteColor = {tipoConsulta: gerarCores()};

      palleteColor.addAll(listConverted);

      await saveSharedPreference(
          palleteColorTypeAppointment, jsonEncode(palleteColor));

      return palleteColor;
    }
    return listConverted;
  }
  return listConverted;
}
