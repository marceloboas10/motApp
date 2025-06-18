class CustomersModel {
  late String id;
  late String nome;
  late String rg;
  late String cpf;
  late String telefone;
  late String validadeCnh;
  late String cep;
  late String endereco;
  late String numeroResidencia;
  late String complemento;
  late String bairro;
  late String cidade;
  late String? motoAlugada;
  late bool? pagamentoPendente;

  CustomersModel(
    this.id,
    this.nome,
    this.rg,
    this.cpf,
    this.telefone,
    this.validadeCnh,
    this.cep,
    this.endereco,
    this.numeroResidencia,
    this.complemento,
    this.bairro,
    this.cidade,
    this.motoAlugada,
    this.pagamentoPendente,
  );

  CustomersModel.fromJson(Map<String, dynamic> map, String id) {
    id = id;
    nome = map['Nome'];
    rg = map['RG'];
    cpf = map['CPF'];
    telefone = map['Telefone'];
    validadeCnh = map['Validade_CNH'];
    cep = map['CEP'];
    endereco = map['Endereco'];
    numeroResidencia = map['Numero_Residencia'];
    complemento = map['Complemento'];
    bairro = map['Bairro'];
    cidade = map['Cidade'];
    motoAlugada = map['Moto_alugada'];
    pagamentoPendente = map['Pagamento_Pendente'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'rg': rg,
      'cpf': cpf,
      'telefone': telefone,
      'validade_cnh': validadeCnh,
      'cep': cep,
      'endereco': endereco,
      'numero_residencia': numeroResidencia,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'moto_alugada': motoAlugada,
      'pagamento_pendente': pagamentoPendente,
    };
  }

  doc(String id) {}
}
