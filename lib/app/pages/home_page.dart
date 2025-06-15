import 'package:flutter/material.dart';
import 'package:motapp/app/components/reminder_home_component.dart';
import 'package:motapp/app/widgets/reminder_widget.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/home_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBarWidget(
          title: 'Olá, Usuário',
          subtitle: 'Este é o seu painel de controle',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text('Lembretes Próximos'),
              ),
              ReminderHomeComponent(),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Text('Acesso Rápido'),
                
              ),Row(children: [],)
            ],
          ),
        ),
      ),
    );
  }
}
