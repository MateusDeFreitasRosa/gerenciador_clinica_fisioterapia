import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

getClienteAniversariante({page = 0, pageSize = 5, mes, dia, dia_fim}) async {
  var dio = Dio();

  String nome = 'ADM';
  String senha = 'senha12345';
  Map<String, dynamic> credenciais = {
    'credenciais': {'nome_de_usuario': nome, 'senha': senha}
  };

  dio.options.headers['nome_de_usuario'] = nome;
  dio.options.headers['senha'] = senha;

  // Traz dia hoje.
  String query = '?page=$page&pageSize=$pageSize';

  // Traz todos os aniversariantes do mês
  if (mes != null && dia == null && dia_fim == null) {
    query += '&mes=$mes';
  }
  // Traz os aniversariantes de um mes, dia específico;
  else if (mes != null && dia != null && dia_fim == null) {
    query += '&mes=$mes&dia=$dia';
  }
  // Traz os aniversariantes em um intervalo de dias de um mês específico.
  else if (mes != null && dia != null && dia_fim != null) {
    query += '&mes=$mes&dia=$dia&dia_fim=$dia_fim';
  }
  print('Url: $query');
  final response =
      await dio.get(urlRequest['get']['getClienteAniversariante'] + query);
  if (response.statusCode! < 300) {
    return response.data;
  }

  return [];
}
