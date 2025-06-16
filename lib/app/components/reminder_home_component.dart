import 'package:flutter/material.dart';
import 'package:motapp/app/widgets/reminder_widget.dart';

class ReminderHomeComponent extends StatelessWidget {
  const ReminderHomeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 4),
        itemCount: 14,
        itemBuilder: (context, index) => ReminderWidget(),
      ),
    );
  }
}
