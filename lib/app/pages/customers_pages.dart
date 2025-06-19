import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/components/show_customers_compoment.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class CustomersPages extends StatefulWidget {
  const CustomersPages({super.key});

  @override
  State<CustomersPages> createState() => _CustomersPagesState();
}

class _CustomersPagesState extends State<CustomersPages> {
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
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButton(
            onPressed: () {},
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
              return ListView.builder(itemCount: dados.size,
                itemBuilder: (context, index) => ShowCustomersCompoment(snapshot: dados.docs[index],),
              );
          }
        },
      ),
    );
  }
}
