import 'package:flutter/material.dart';
import 'package:motapp/app/components/financial_summary_component.dart';
import 'package:motapp/app/components/reminder_home_component.dart';
import 'package:motapp/app/components/status_operational_component.dart';
import 'package:motapp/app/widgets/home_app_bar_widget.dart';

class MenuHomePage extends StatelessWidget {
  const MenuHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBarWidget(
          title: 'Olá, Usuário',
          subtitle: 'Este é o seu painel de controle',
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    'Resumo Financeiro',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FinancialSummaryComponent(),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(
                    'Status Operacional',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StatusOperationalComponent(),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(
                    'Próximos Lembretes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ReminderHomeComponent(),
                // Padding(
                //   padding: const EdgeInsets.only(top: 24, bottom: 16),
                //   child: Text('Acesso Rápido'),
                // ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: QuickAccessComponent(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
