import 'package:flutter/material.dart';
import 'package:motapp/app/pages/customers/customers_page.dart';
import 'package:motapp/app/pages/products/products_page.dart';
import 'package:motapp/app/pages/reminders/reminders_page.dart';
import 'package:motapp/app/pages/vehicles/vehicles_page.dart';
import 'package:motapp/app/widgets/card_registration_widget.dart';

class RegistrationsPage extends StatelessWidget {
  const RegistrationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Cadastros')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CardRegistrationWidget(
              icon: Icons.group_rounded,
              title: 'Clientes',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CustomersPage(),
                ),
              ),
            ),
            CardRegistrationWidget(
              icon: Icons.motorcycle_rounded,
              title: 'Veículos',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => VehiclesPage(),
                ),
              ),
            ),
            CardRegistrationWidget(
              icon: Icons.storage_outlined,
              title: 'Produtos',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductsPage(),
                ),
              ),
            ),
            CardRegistrationWidget(
              icon: Icons.notifications_active_sharp,
              title: 'Lembretes',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RemindersPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
