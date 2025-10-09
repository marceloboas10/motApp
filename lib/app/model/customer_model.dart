class CustomerModel {
  late String id;
  late String nome;
  late String rg;
  late String cpf;
  late String celular;
  late String celular2;
  late String validadeCnh;
  late String cep;
  late String endereco;
  late String numeroResidencia;
  late String? complemento;
  late String bairro;
  late String cidade;
  late String motoAlugada;
  late bool? pagamentoPendente;
  late String? profileImageUrl;

  CustomerModel(
    this.id,
    this.nome,
    this.rg,
    this.cpf,
    this.celular,
    this.celular2,
    this.validadeCnh,
    this.cep,
    this.endereco,
    this.numeroResidencia,
    this.complemento,
    this.bairro,
    this.cidade,
    this.motoAlugada,
    this.pagamentoPendente,
    this.profileImageUrl
  );

  CustomerModel.fromJson(Map<String, dynamic> map, this.id)
    : nome = map['Nome'],
      rg = map['RG'],
      cpf = map['CPF'],
      celular = map['Celular'],
      celular2 = map['Celular_2'],
      validadeCnh = map['Validade_CNH'],
      cep = map['CEP'],
      endereco = map['Endereço'],
      numeroResidencia = map['Numero_Residencia'],
      complemento = map['Complemento'],
      bairro = map['Bairro'],
      cidade = map['Cidade'],
      motoAlugada = map['Moto_Alugada'],
      pagamentoPendente = map['Pagamento_Pendente'], profileImageUrl = map['profileImageUrl'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'rg': rg,
      'cpf': cpf,
      'celular': celular,
      'celular_2': celular2,
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
