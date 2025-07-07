import 'package:flutter/material.dart';
import 'package:motapp/app/pages/maintence_page.dart';
import 'package:motapp/app/pages/home/menu_home_page.dart';
import 'package:motapp/app/pages/registrations_page.dart';
import 'package:motapp/app/pages/vehicles/vehicles_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MenuHomePage(),
      RegistrationsPage(),
      VehiclesPage(),
      MaintencePage(),
    ];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: LightColors.iconColorGreen,
          unselectedItemColor: LightColors.gray,
          selectedIconTheme: IconThemeData(color: LightColors.iconColorGreen),
          unselectedIconTheme: IconThemeData(color: LightColors.gray),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration_outlined),
              label: 'Cadastros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.two_wheeler_sharp),
              label: 'Veículos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.two_wheeler_sharp),
              label: 'Manutenção',
            ),
          ],
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
        body: pages.elementAt(_currentPage),
      ),
    );
  }
}
