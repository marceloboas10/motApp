import 'package:flutter/material.dart';
import 'package:motapp/app/components/form_customer_component.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class RegisterCustomerPage extends StatefulWidget {
  const RegisterCustomerPage({super.key});

  @override
  State<RegisterCustomerPage> createState() => _RegisterCustomerPageState();
}

class _RegisterCustomerPageState extends State<RegisterCustomerPage> {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;
  

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Cliente'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: LightColors.scafoldBackgroud,
      ),
      body: FormCustomerComponent(id: id),
    );
  }
}
