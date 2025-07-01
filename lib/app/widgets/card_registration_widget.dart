import 'package:flutter/material.dart';

class CardRegistrationWidget extends StatelessWidget {
  const CardRegistrationWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
      ),
    );
  }
}
