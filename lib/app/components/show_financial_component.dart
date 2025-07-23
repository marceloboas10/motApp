import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motapp/app/model/financial_model.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowFinancialComponent extends StatelessWidget {
  final dynamic snapshot;

  const ShowFinancialComponent({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final financial = FinancialModel.fromJson(snapshot.data(), snapshot.id);

    DateTime? date;
    try {
      date = DateTime.parse(financial.date);
    } catch (_) {
      date = null;
    }

    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: financial.isEntrada()
              ? LightColors.iconColorGreen
              : LightColors.buttonRed,
          child: Icon(
            financial.isEntrada() ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.white,
          ),
        ),
        title: Text(
          financial.description,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(date!),
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Text(
          'R\$ ${financial.value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: financial.isEntrada()
                ? LightColors.iconColorGreen
                : LightColors.buttonRed,
          ),
        ),
      ),
    );
  }
}
