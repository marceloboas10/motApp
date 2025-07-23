import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motapp/app/viewmodels/financial_view_model.dart';
import 'package:motapp/app/widgets/card_financial_widget.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class FinancialSummaryComponent extends StatelessWidget {
  final bool showMonthOnly; // Para mostrar apenas dados do mês corrente

  const FinancialSummaryComponent({super.key, this.showMonthOnly = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinancialViewModel>(
      builder: (context, viewModel, child) {
        return StreamBuilder<Map<String, double>>(
          stream: showMonthOnly
              ? viewModel.getTotaisMesCorrenteStream()
              : viewModel.getTotaisStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return _buildLoadingCards();
            }

            final totais = snapshot.data!;
            return _buildDataCards(totais);
          },
        );
      },
    );
  }

  Widget _buildLoadingCards() {
    return CircularProgressIndicator(color: LightColors.iconColorGreen);
  }

  Widget _buildDataCards(Map<String, double> totais) {
    final saldo = totais['saldo']!;
    final corSaldo = saldo >= 0 ? Colors.black : LightColors.buttonRed;
    final titleSuffix = showMonthOnly ? 'do Mês' : 'Total';

    return Column(
      children: [
        CardFinancialWidget(
          title: 'Saldo $titleSuffix',
          price: 'R\$ ${saldo.toStringAsFixed(2)}',
          colorPrice: corSaldo,
        ),
        SizedBox(height: 5),

        Row(
          children: [
            Expanded(
              child: CardFinancialWidget(
                title: 'Receita $titleSuffix',
                price: 'R\$ ${totais['entradas']!.toStringAsFixed(2)}',
                colorPrice: LightColors.iconColorGreen,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CardFinancialWidget(
                title: 'Despesas $titleSuffix',
                price: 'R\$ ${totais['saidas']!.toStringAsFixed(2)}',
                colorPrice: LightColors.buttonRed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
