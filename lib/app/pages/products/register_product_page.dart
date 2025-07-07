import 'package:flutter/material.dart';
import 'package:motapp/app/components/form_product_component.dart';

class RegisterProductPage extends StatelessWidget {
  const RegisterProductPage({super.key});

  @override
  Widget build(BuildContext context) {
     var id = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Produtos')),
      body: FormProductComponent(id: id,),
    );
  }
}
