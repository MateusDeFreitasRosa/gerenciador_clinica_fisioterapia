import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

Future<dynamic> cadastrarClienteFuncionario(
    Map<String, dynamic> data, String url) async {
  var dio = Dio();

  String nome = 'ADM';
  String senha = 'senha12345';
  Map<String, dynamic> credenciais = {
    'credenciais': {'nome_de_usuario': nome, 'senha': senha}
  };

  data.addAll(credenciais);

  print('Dados requisição');
  print(data);

  try {
    final response = await dio.post(urlRequest['post'][url], data: data);

    print('StatusCode: ${response.statusCode}');
    if (response.statusCode! < 300) {
      return {
        'statusCode': response.statusCode,
        'data': 'Sucesso no cadastro!'
      };
    }
  } catch (e) {
    print(e);
    if (e is DioError) {
      return {'statusCode': e.response!.statusCode, 'data': e.response!.data};
    }
  }

  return {'statusCode': 500, 'data': 'Erro interno'};
}
