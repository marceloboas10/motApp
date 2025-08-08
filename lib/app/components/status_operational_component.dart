import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motapp/app/viewmodels/customer_view_model.dart';
import 'package:motapp/app/widgets/card_status_widget.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class StatusOperationalComponent extends StatelessWidget {
  const StatusOperationalComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomerViewModel(),
      child: Consumer<CustomerViewModel>(
        builder: (context, viewModel, child) {
          return StreamBuilder<Map<String, int>>(
            stream: viewModel.getStatusOperacionalStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _buildLoadingCards();
              }

              final status = snapshot.data!;
              return _buildStatusCards(status);
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingCards() {
    return Center(
      child: CircularProgressIndicator(color: LightColors.iconColorGreen),
    );
  }

  Widget _buildStatusCards(Map<String, int> status) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CardStatusWidget(
                title: 'Total Clientes',
                count: '${status['totalClientes']}',
                icon: Icons.people_alt_rounded,
                colorIcon: Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CardStatusWidget(
                title: 'Motos Alugadas',
                count: '${status['motosAlugadas']}',
                icon: Icons.motorcycle_outlined,
                colorIcon: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: CardStatusWidget(
                title: 'Motos Disponíveis',
                count: '${status['motosDisponiveis']}',
                icon: Icons.motorcycle_outlined,
                colorIcon: LightColors.iconColorGreen,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: CardStatusWidget(
                title: 'Pagamentos Pendentes',
                count: '${status['pagamentosPendentes']}',
                icon: Icons.warning,
                colorIcon: LightColors.buttonRed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
