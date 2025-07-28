import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/pages/maitntence/register_maintence_page.dart';

class MaintencePage extends StatefulWidget {
  const MaintencePage({super.key});

  @override
  State<MaintencePage> createState() => _MaintencePageState();
}

class _MaintencePageState extends State<MaintencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: 'Manutenção',
        page: RegisterMaintencePage(),
      ),
    );
  }
}
