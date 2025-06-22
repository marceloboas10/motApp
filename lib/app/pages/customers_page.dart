import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/components/show_customer_compoment.dart';
import 'package:motapp/app/pages/register_customer_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  late CollectionReference customers;

  @override
  void initState() {
    super.initState();
    customers = FirebaseFirestore.instance.collection('clientes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RegisterCustomerPage(),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: customers.orderBy('Nome').snapshots(),
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
              return ListView.builder(
                itemCount: dados.size,
                itemBuilder: (context, index) =>
                    ShowCustomerCompoment(snapshot: dados.docs[index]),
              );
          }
        },
      ),
    );
  }
}
