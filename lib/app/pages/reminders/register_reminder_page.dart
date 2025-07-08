import 'package:flutter/material.dart';
import 'package:motapp/app/components/form_reminder_component.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class RegisterReminderPage extends StatefulWidget {
  const RegisterReminderPage({super.key});

  @override
  State<RegisterReminderPage> createState() => _RegisterReminderPageState();
}

class _RegisterReminderPageState extends State<RegisterReminderPage> {
  
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Criar Lembrete'),
        elevation: 0,
        backgroundColor: LightColors.scafoldBackgroud,
      ),
      body: FormReminderComponent(id: id),
    );
  }
}
