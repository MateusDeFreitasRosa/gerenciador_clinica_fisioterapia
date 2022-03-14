import 'package:dio/dio.dart';
import 'package:fisio_studio/components.dart';

Future<dynamic> addCredits(
    {pacienteCPF, tipo, quantidade, valorUnidade}) async {
  var dio = Dio();

  String nome = 'ADM';
  String senha = 'senha12345';

  dio.options.headers['nome_de_usuario'] = nome;
  dio.options.headers['senha'] = senha;

  DateTime date = DateTime.now().add(const Duration(days: 365));
  Map<String, dynamic> data = {
    'pacienteCPF': pacienteCPF,
    'validade': '${date.year}-${date.month}-${date.day}',
    'tipo': tipo,
    'quantidade': quantidade,
    'valor_unidade': valorUnidade
  };

  try {
    final response =
        await dio.post(urlRequest['post']['postAddCreditos'], data: data);

    if (response.statusCode! < 300) {
      print(response.data);
      return response.data;
    }
    return [];
  } catch (e) {
    if (e is DioError) {
      print('Resposta: ${e.response!.data}');
    }
    print('getCredits error: ${e}');
  }
}
