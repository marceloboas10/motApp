import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Adicione este import
import 'package:motapp/app/components/financial_summary_component.dart';
import 'package:motapp/app/components/show_reminder_home_component.dart';
import 'package:motapp/app/components/status_operational_component.dart';
import 'package:motapp/app/widgets/home_app_bar_widget.dart';
import 'package:motapp/app/viewmodels/financial_view_model.dart'; // Adicione este import

class MenuHomePage extends StatelessWidget {
  const MenuHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userName = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .firestore
        .app;
    return ChangeNotifierProvider(
      create: (_) => FinancialViewModel(),
      child: SafeArea(
        child: Scaffold(
          appBar: HomeAppBarWidget(
            title: 'Olá, $userName',
            subtitle: 'Este é o seu painel de controle',
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Resumo Financeiro',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Mostra dados do mês corrente no dashboard
                  FinancialSummaryComponent(showMonthOnly: true),

                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Status Operacional',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  StatusOperationalComponent(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Próximos Lembretes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: userId != null
                        ? FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(userId)
                              .collection('lembretes')
                              .orderBy('Data')
                              .snapshots()
                        : Stream.empty(),
                    builder: (context, snapshot) {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final fiveDayLater = today.add(Duration(days: 6));
                      final docs = snapshot.data?.docs.where((doc) {
                        final ts = doc['Data'] as Timestamp;
                        final vencimento = ts.toDate();
                        final vencimentoDate = DateTime(
                          vencimento.year,
                          vencimento.month,
                          vencimento.day,
                        );
                        return vencimentoDate.isAtSameMomentAs(today) ||
                            vencimentoDate.isAfter(today) ||
                            vencimentoDate.isBefore(fiveDayLater);
                      }).toList();
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.docs.isEmpty || docs!.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 40),
                          child: Text('Nenhum lembrete cadastrado!'),
                        );
                      }
                      return Column(
                        children: docs
                            .map(
                              (doc) => ShowReminderHomeComponent(snapshot: doc),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
