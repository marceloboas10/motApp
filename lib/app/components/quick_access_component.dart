import 'package:flutter/material.dart';
import 'package:motapp/app/widgets/quick_access_card_widget.dart';

class QuickAccessComponent extends StatelessWidget {
  const QuickAccessComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuickAccessCardWidget(
          title: 'Clientes',
          icon: Icons.person_add_alt_1_rounded,
        ),
        QuickAccessCardWidget(title: 'Veículos', icon: Icons.two_wheeler_sharp),
        QuickAccessCardWidget(
          title: 'Lembrete',
          icon: Icons.notifications_active_outlined,
        ),
        QuickAccessCardWidget(title: 'Manutenção', icon: Icons.build_rounded),
      ],
    );
  }
}
