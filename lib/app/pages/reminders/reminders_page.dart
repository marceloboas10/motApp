import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/components/show_reminder_component.dart';
import 'package:motapp/app/pages/reminders/register_reminder_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late CollectionReference reminders;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    reminders = FirebaseFirestore.instance.collection('lembretes');
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: 'Lembretes', page: RegisterReminderPage()),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: 'Buscar lembrete',
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: reminders.orderBy('Data', descending: true).snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text('Erro na conexão com o banco de dados'),
                    );
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    final dados = snapshot.requireData;

                    final filteredDocs = _searchText.isEmpty
                        ? dados.docs
                        : dados.docs.where((doc) {
                            final nome = (doc['Lembrete'] ?? '')
                                .toString()
                                .toLowerCase();
                            return nome.contains(_searchText);
                          }).toList();
                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) =>
                          ShowReminderComponent(snapshot: filteredDocs[index]),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
