class VehicleModel {
  late String id;
  late String fabricante;
  late String modelo;
  late String ano;
  late String placa;
  late String renavam;

  VehicleModel(
    this.id,
    this.fabricante,
    this.modelo,
    this.ano,
    this.placa,
    this.renavam,
  );

  VehicleModel.fromJson(Map<String, dynamic> map, String id) {
    id = id;
    fabricante = map['Fabricante'];
    modelo = map['Modelo'];
    ano = map['Ano'];
    placa = map['Placa'];
    renavam = map['Renavam'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fabricante': fabricante,
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
      'renavam': renavam,
    };
  }

  doc(String id) {}
}
