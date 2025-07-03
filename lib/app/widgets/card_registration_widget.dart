import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class CardRegistrationWidget extends StatelessWidget {
  const CardRegistrationWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ListTile(
          leading: Icon(icon, color: LightColors.iconColorGreen, size: 30),
          title: Text(title, style: TextStyle(fontSize: 20)),
          trailing: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: LightColors.lightGray,
            ),
          ),
        ),
      ),
    );
  }
}
