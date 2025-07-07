import 'package:flutter/material.dart';
import 'package:motapp/app/pages/home/home_page.dart';
import 'package:motapp/app/theme/app_theme.dart';

class Motapp extends StatelessWidget {
  const Motapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: HomePage(),
    );
  }
}
