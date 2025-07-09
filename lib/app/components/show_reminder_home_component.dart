import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motapp/app/model/reminder_model.dart';

import 'package:motapp/app/theme/light/light_colors.dart';

class ShowReminderHomeComponent extends StatefulWidget {
  const ShowReminderHomeComponent({super.key, required this.snapshot});
  final dynamic snapshot;

  @override
  State<ShowReminderHomeComponent> createState() =>
      _ShowReminderHomeComponentState();
}

class _ShowReminderHomeComponentState extends State<ShowReminderHomeComponent> {
  @override
  Widget build(BuildContext context) {
    ReminderModel reminder = ReminderModel.froJson(
      widget.snapshot.data(),
      widget.snapshot.id,
    );

    DateTime? date;
    try {
      date = DateTime.parse(reminder.date);
    } catch (_) {
      date = null;
    }

    return Card(
      color: Colors.white,
      child: SizedBox(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(right: 70)),
            ListTile(
              leading: Icon(
                Icons.notifications_rounded,
                color: Colors.amber,
                size: 30,
              ),
              title: Text(
                reminder.reminder,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Vence em: ${DateFormat('dd/MM/yyyy').format(date!)}',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Excluir Lembrete",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        "Tem certeza que deseja excluir ${reminder.reminder}?",
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Não",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Lembrete ${reminder.reminder} excluído com sucesso!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                            FirebaseFirestore.instance
                                .collection('lembretes')
                                .doc(reminder.id)
                                .delete();
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Sim",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete_outline_outlined, size: 30),
                color: LightColors.buttonRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
