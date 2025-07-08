import 'package:flutter/material.dart';
import 'package:motapp/app/model/reminder_model.dart';
import 'package:motapp/app/pages/reminders/register_reminder_page.dart';

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
                  reminder.description,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterReminderPage(),
                      settings: RouteSettings(arguments: reminder.id),
                    ),
                  ),
                  child: Icon(Icons.edit_outlined, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
