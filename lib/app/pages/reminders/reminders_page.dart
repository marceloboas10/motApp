import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lembretes'),
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RegisterReminderPage(),
                ),
              );
            },
            icon: Icon(
              Icons.add_circle,
              size: 40,
              color: LightColors.iconColorGreen,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: 'Buscar produto',
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: reminders.orderBy('Data').snapshots(),
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
