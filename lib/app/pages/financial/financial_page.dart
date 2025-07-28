import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/pages/financial/register_financial_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motapp/app/viewmodels/financial_view_model.dart';
import 'package:motapp/app/components/show_financial_component.dart';
import 'package:motapp/app/widgets/card_financial_widget.dart';
import 'package:motapp/app/widgets/custom_tab_selector_widget.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class FinancialPage extends StatelessWidget {
  const FinancialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FinancialViewModel(),
      child: Scaffold(
        appBar:AppBarComponent(title: 'Financeiro', page:  RegisterFinancialPage()),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Consumer<FinancialViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  // Cards com totais usando StreamBuilder
                  StreamBuilder<Map<String, double>>(
                    stream: viewModel.getTotaisStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          color: LightColors.iconColorGreen,
                        );
                      }

                      final totais = snapshot.data!;
                      return Row(
                        children: [
                          Expanded(
                            child: CardFinancialWidget(
                              title: 'Receita do Mês',
                              price:
                                  'R\$ ${totais['entradas']!.toStringAsFixed(2)}',
                              colorPrice: LightColors.iconColorGreen,
                            ),
                          ),
                          Expanded(
                            child: CardFinancialWidget(
                              title: 'Despesas do Mês',
                              price:
                                  'R\$ ${totais['saidas']!.toStringAsFixed(2)}',
                              colorPrice: LightColors.buttonRed,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  // Filtros
                  CustomTabSelectorWidget(
                    onFilterChanged: (filtro) {
                      viewModel.setFiltro(filtro);
                    },
                  ),

                  SizedBox(height: 16),

                  // Lista de transações
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: viewModel.getTransacoesFiltradas(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Nenhuma transação encontrada',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final dados = snapshot.data!;

                        // Ordenação no cliente para evitar erro de índice
                        final docsOrdenados = dados.docs.toList()
                          ..sort((a, b) {
                            final dataA = (a['Data'] as Timestamp).toDate();
                            final dataB = (b['Data'] as Timestamp).toDate();
                            return dataB.compareTo(dataA);
                          });

                        return ListView.builder(
                          itemCount: docsOrdenados.length,
                          itemBuilder: (context, index) =>
                              ShowFinancialComponent(
                                snapshot: docsOrdenados[index],
                              ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
