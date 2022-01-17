import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

void cadastrarClienteFuncionario(Map<String, dynamic> data, String url) async {
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
      print('Cadastro realizado com sucesso!');
      print(response.data);
    }
  } catch (e) {
    print(e);
  }
}
