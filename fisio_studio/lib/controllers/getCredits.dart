import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

getCredits({pacienteCPF, tipo}) async {
  var dio = Dio();

  String nome = 'ADM';
  String senha = 'senha12345';

  dio.options.headers['nome_de_usuario'] = nome;
  dio.options.headers['senha'] = senha;

  DateTime date = DateTime.now();
  List<String> query = [
    'pacienteCPF=$pacienteCPF',
    'hoje=${date.year}-${date.month}-${date.day}'
  ];

  if (tipo != null) {
    query.add('tipo=' + tipo);
  }

  try {
    final response = await dio
        .get(urlRequest['get']['getCreditosValidos'] + '?${query.join('&')}');

    if (response.statusCode! < 300) {
      print('Response: ${response.data}');
      return response.data;
    }
    return [];
  } catch (e) {
    //print('getCredits error: ${e}');
    if (e is DioError) {
      print('Is dioError');
      return e.response!.data;
    }
  }
}
