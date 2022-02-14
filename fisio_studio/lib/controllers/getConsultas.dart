import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

getConsultas(
    {dynamic ano, dynamic mes, dynamic dia, required String url}) async {
  var dio = Dio();

  String nome = 'ADM';
  String senha = 'senha12345';

  dio.options.headers['nome_de_usuario'] = nome;
  dio.options.headers['senha'] = senha;

  List<String> query = [];
  if (ano != null) {
    query.add('ano=' + ano.toString());
  }
  if (mes != null) {
    query.add('mes=' + mes.toString());
  }
  if (dia != null) {
    query.add('dia=' + dia.toString());
  }

  try {
    final response =
        await dio.get(urlRequest['get'][url] + '?${query.join('&')}');

    if (response.statusCode! < 300) {
      print(response.data);
      return response.data;
    }
    return [];
  } catch (e) {
    print('getConsultas error: ${e}');
  }
}
