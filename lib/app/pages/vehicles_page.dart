import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/components/show_vehicle_component.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  late CollectionReference vehicle;

  @override
  void initState() {
    super.initState();
    vehicle = FirebaseFirestore.instance.collection('veiculos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos'),
        centerTitle: true,
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
        stream: vehicle.orderBy('Fabricante').snapshots(),
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
                    ShowVehicleComponent(snapshot: dados.docs[index]),
              );
          }
        },
      ),
    );
  }
}
