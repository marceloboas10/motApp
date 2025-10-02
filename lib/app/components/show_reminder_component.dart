import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motapp/app/model/reminder_model.dart';
import 'package:motapp/app/pages/reminders/register_reminder_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowReminderComponent extends StatefulWidget {
  const ShowReminderComponent({super.key, required this.snapshot});
  final dynamic snapshot;

  @override
  State<ShowReminderComponent> createState() => _ShowReminderComponentState();
}

class _ShowReminderComponentState extends State<ShowReminderComponent> {
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  reminder.reminder,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Vencimento: ${DateFormat('dd/MM/yyyy').format(date!)}',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RegisterReminderPage(),
                          settings: RouteSettings(arguments: reminder.id),
                        ),
                      ),
                      child: Icon(Icons.edit_outlined, size: 30),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
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
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: LightColors.buttonRed,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final userId =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  if (userId != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            LightColors.iconColorGreen,
                                        content: Text(
                                          'Lembrete ${reminder.reminder} excluído com sucesso!',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                    FirebaseFirestore.instance
                                        .collection('usuarios')
                                        .doc(userId)
                                        .collection('lembretes')
                                        .doc(reminder.id)
                                        .delete();
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Sim",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: LightColors.iconColorGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(
                        Icons.delete_outlined,
                        size: 30,
                        color: LightColors.buttonRed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
