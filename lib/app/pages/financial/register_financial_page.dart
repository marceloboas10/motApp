import 'package:flutter/material.dart';

class RegisterFinancialPage extends StatefulWidget {
  const RegisterFinancialPage({super.key});

  @override
  State<RegisterFinancialPage> createState() => _RegisterFinancialPageState();
}

class _RegisterFinancialPageState extends State<RegisterFinancialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Transação')),
      body: Container(),
    );
  }
}
