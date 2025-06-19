class CustomerModel {
  late String id;
  late String nome;
  late String rg;
  late String cpf;
  late String telefone;
  late String validadeCnh;
  late String cep;
  late String endereco;
  late String numeroResidencial;
  late String complemento;
  late String bairro;
  late String cidade;
  late String? motoAlugada;
  late bool? pagamentoPendente;

  CustomerModel(
    this.id,
    this.nome,
    this.rg,
    this.cpf,
    this.telefone,
    this.validadeCnh,
    this.cep,
    this.endereco,
    this.numeroResidencial,
    this.complemento,
    this.bairro,
    this.cidade,
    this.motoAlugada,
    this.pagamentoPendente,
  );

  CustomerModel.fromJson(Map<String, dynamic> map, String id) {
    id = id;
    nome = map['Nome'];
    rg = map['RG'];
    cpf = map['CPF'];
    telefone = map['Telefone'];
    validadeCnh = map['Validade_CNH'];
    cep = map['CEP'];
    endereco = map['Endereco'];
    numeroResidencial = map['Numero_Residencial'];
    complemento = map['Complemento'];
    bairro = map['Bairro'];
    cidade = map['Cidade'];
    motoAlugada = map['Moto_Alugada'];
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
      'numero_residencial': numeroResidencial,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'moto_alugada': motoAlugada,
      'pagamento_pendente': pagamentoPendente,
    };
  }

  doc(String id) {}
}
