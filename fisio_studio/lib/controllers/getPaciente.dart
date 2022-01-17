import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

getPaciente({page = 0, pageSize = 10, id}) async {
  var dio = Dio();

  String nome = 'ADM';
  String senha = 'senha12345';
  Map<String, dynamic> credenciais = {
    'credenciais': {'nome_de_usuario': nome, 'senha': senha}
  };

  dio.options.headers['nome_de_usuario'] = nome;
  dio.options.headers['senha'] = senha;

  if (id == null) {
    // Traz tudo.
    String query = '?page=${page}&pageSize=${pageSize}';
    final response = await dio.get(urlRequest['get']['getCliente'] + query);

    if (response.statusCode! < 300) {
      return response.data;
    }
  } else {
    //TODO: Busca singular.
    return [];
  }

  return [];
}
