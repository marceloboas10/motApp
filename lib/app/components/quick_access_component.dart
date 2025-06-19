import 'package:flutter/material.dart';
import 'package:motapp/app/pages/customers_pages.dart';
import 'package:motapp/app/pages/vehicles_page.dart';
import 'package:motapp/app/widgets/quick_access_card_widget.dart';

class QuickAccessComponent extends StatelessWidget {
  const QuickAccessComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuickAccessCardWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CustomersPages(),
              ),
            );
          },
          title: 'Clientes',
          icon: Icons.person_add_alt_1_rounded,
        ),
        QuickAccessCardWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => VehiclesPage(),
              ),
            );
          },
          title: 'Veículos',
          icon: Icons.two_wheeler_sharp,
        ),
        QuickAccessCardWidget(
          onTap: () {},
          title: 'Lembrete',
          icon: Icons.notifications_active_outlined,
        ),
        QuickAccessCardWidget(
          onTap: () {},
          title: 'Manutenção',
          icon: Icons.build_rounded,
        ),
      ],
    );
  }
}
