/* import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ReminderWidget extends StatefulWidget {
  const ReminderWidget({super.key});

  @override
  State<ReminderWidget> createState() => _ReminderHomeState();
}

bool? isSelected = false;

class _ReminderHomeState extends State<ReminderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.notifications_rounded,
          color: Colors.amber,
          size: 30,
        ),
        title: Text('Troca de óleo'),
        subtitle: Text(
          'Vence em 5 dias',
          style: TextStyle(color: LightColors.buttonRed),
        ),
        trailing: Checkbox(
          value: isSelected,
          activeColor: LightColors.iconColorGreen,
          onChanged: (value) {
            setState(() {
              isSelected = value;
            });
          },
        ),
      ),
    );
  }
}
 */
