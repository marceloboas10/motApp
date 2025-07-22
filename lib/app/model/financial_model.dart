import 'package:cloud_firestore/cloud_firestore.dart';

class FinancialModel {
  late String id;
  late String type;
  late double value;
  late String description;
  late String date;

  FinancialModel(this.id, this.type, this.value, this.description, this.date);

  FinancialModel.fromJson(Map<String, dynamic> map, String id)
    : type = map['Tipo'],
      value = double.tryParse(map['Valor'].toString()) ?? 0,
      description = map['Descrição'],
      date = (map['Data'] as Timestamp).toDate().toIso8601String();

  Map<String, dynamic> toJson() {
    return {
      'Tipo': type,
      'Valor': value,
      'Descrição': description,
      'Data': date,
    };
  }

  bool isEntrada() => type == 'entrada';
  bool isSaida() => type == 'saida';

  // Para facilitar a exibição
  String get tipoFormatado => type == 'entrada' ? 'Entrada' : 'Saída';

  doc(String id) {}
}
