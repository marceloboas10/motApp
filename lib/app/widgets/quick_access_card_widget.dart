import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class QuickAccessCardWidget extends StatelessWidget {
  const QuickAccessCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      enableFeedback: false,
      splashColor: LightColors.iconColorGreen,
      radius: 30,
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Container(
          height: 120,
          width: 100,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, color: LightColors.iconColorGreen, size: 35),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
