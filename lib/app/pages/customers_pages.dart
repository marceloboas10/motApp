import 'package:flutter/material.dart';
import 'package:motapp/app/components/show_customers_compoment.dart';

class CustomersPages extends StatefulWidget {
  const CustomersPages({super.key});

  @override
  State<CustomersPages> createState() => _CustomersPagesState();
}

class _CustomersPagesState extends State<CustomersPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: ShowCustomersCompoment(),
    );
  }
}
