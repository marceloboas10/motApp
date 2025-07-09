import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  late String id;
  late String reminder;
  late String description;
  late String date;

  ReminderModel(this.id, this.reminder, this.description, this.date);

  ReminderModel.froJson(Map<String, dynamic> map, this.id)
    : reminder = map['Lembrete'],
      description = map['Descrição'],
      date = (map['Data'] as Timestamp).toDate().toIso8601String();

  Map<String, dynamic> toJson() {
    return {'reminder': reminder, 'description': description, 'date': date};
  }

  doc(String id) {}
}
