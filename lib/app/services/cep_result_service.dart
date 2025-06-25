import 'dart:convert';

import 'package:http/http.dart' as http;

class CepResultService {
  String? logradouro;
  String? bairro;
  String? cidade;
  String? complemento;
  String? error;

  CepResultService({
    this.logradouro,
    this.bairro,
    this.cidade,
    this.complemento,
    this.error,
  });

  Future<CepResultService> buscarCep(String cep) async {
    try {
      final response = await http
          .get(Uri.parse('https://viacep.com.br/ws/$cep/json'))
          .timeout(const Duration(seconds: 2));

      final json = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return CepResultService(
          error: 'Serviço de CEP indisponível no momento',
        );
      } else if (json['erro'] == 'true') {
        return CepResultService(error: 'CEP não encontrado');
      } else {
        return CepResultService(
          logradouro: json['logradouro'],
          bairro: json['bairro'],
          cidade: json['localidade'],
          complemento: json['complemento'],
          error: json['erro'],
        );
      }
    } catch (e) {
      return CepResultService(error: 'Sem internet, digite manualmente');
    }
  }
}
