import 'package:flutter/material.dart';
import 'package:motapp/app/components/form_financial_component.dart';

class RegisterFinancialPage extends StatefulWidget {
  const RegisterFinancialPage({super.key});

  @override
  State<RegisterFinancialPage> createState() => _RegisterFinancialPageState();
}

class _RegisterFinancialPageState extends State<RegisterFinancialPage> {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Transação')),
      body: FormFinancialComponent(id: id),
    );
  }
}
