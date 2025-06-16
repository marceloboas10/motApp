import 'package:flutter/material.dart';
import 'package:motapp/app/pages/create_account_page.dart';
import 'package:motapp/app/pages/menu_home_page.dart';
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
    final List<Widget> pages = [MenuHomePage(), CreateAccountPage()];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: LightColors.iconColorGreen,
          selectedIconTheme: IconThemeData(color: LightColors.iconColorGreen),
          unselectedIconTheme: IconThemeData(color: LightColors.gray),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1_rounded),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.two_wheeler_sharp),
              label: 'Veículos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.two_wheeler_sharp),
              label: 'Lembretes',
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
