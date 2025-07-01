import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class FinancialSummaryComponent extends StatefulWidget {
  const FinancialSummaryComponent({super.key});

  @override
  State<FinancialSummaryComponent> createState() =>
      _FinancialSummaryComponentState();
}

class _FinancialSummaryComponentState extends State<FinancialSummaryComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Saldo do Mês'),
                Text(
                  'R\$ 1.200,50',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        'Receita',
                        style: TextStyle(
                          color: LightColors.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'R\$ 2.370,00',
                        style: TextStyle(
                          color: LightColors.iconColorGreen,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Card(
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        'Despesas',
                        style: TextStyle(
                          color: LightColors.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'R\$ 300',
                        style: TextStyle(
                          color: LightColors.buttonRed,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
