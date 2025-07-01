import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class StatusOperationalComponent extends StatelessWidget {
  const StatusOperationalComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    'Motos Alugadas',
                    style: TextStyle(
                      color: LightColors.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '1',
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
                    'Pagamentos Pendentes',
                    style: TextStyle(
                      color: LightColors.gray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '1',
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
    );
  }
}
