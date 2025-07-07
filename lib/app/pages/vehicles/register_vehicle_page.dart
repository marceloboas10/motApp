import 'package:flutter/material.dart';
import 'package:motapp/app/components/form_vehicle_component.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class RegisterVehiclePage extends StatefulWidget {
  const RegisterVehiclePage({super.key});

  @override
  State<RegisterVehiclePage> createState() => _RegisterVehiclePageState();
}

class _RegisterVehiclePageState extends State<RegisterVehiclePage> {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Veiculos'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: LightColors.scafoldBackgroud,
      ),
      body: FormVehicleComponent(id: id),
    );
  }
}
