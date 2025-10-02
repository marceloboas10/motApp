import 'package:flutter/material.dart';
import 'package:motapp/app/components/form_maintence_component.dart';

class RegisterMaintencePage extends StatefulWidget {
  const RegisterMaintencePage({super.key});

  @override
  State<RegisterMaintencePage> createState() => _RegisterMaintencePageState();
}

class _RegisterMaintencePageState extends State<RegisterMaintencePage> {
  @override
  Widget build(BuildContext context) {
     final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(title: const Text('Finalizar Registro')),
      body: FormMaintenceComponent(vehicleId: arguments?['vehicleId'],
        productsUsed: arguments?['products'],),
    );
  }
}
