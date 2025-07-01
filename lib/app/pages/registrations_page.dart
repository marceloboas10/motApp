import 'package:flutter/material.dart';
import 'package:motapp/app/widgets/card_registration_widget.dart';

class RegistrationsPage extends StatelessWidget {
  const RegistrationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Cadastros')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CardRegistrationWidget(
              icon: Icons.group_rounded,
              title: 'Clientes',
            ),
          ],
        ),
      ),
    );
  }
}
