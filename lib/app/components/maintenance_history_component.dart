import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class MaintenanceHistoryComponent extends StatefulWidget {
  const MaintenanceHistoryComponent({super.key});

  @override
  State<MaintenanceHistoryComponent> createState() =>
      _MaintenanceHistoryComponentState();
}

class _MaintenanceHistoryComponentState
    extends State<MaintenanceHistoryComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Histórico de Manutenção',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),

        Container(
          decoration: BoxDecoration(),

          child: Text(
            'Nenhum serviço registrado para este veículo.',
            style: TextStyle(color: LightColors.gray),
          ),
        ),
      ],
    );
  }
}
