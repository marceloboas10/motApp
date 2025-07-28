import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/components/show_vehicle_component.dart';
import 'package:motapp/app/pages/vehicles/register_vehicle_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  late CollectionReference vehicle;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    vehicle = FirebaseFirestore.instance.collection('veiculos');
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: 'Veículos', page: RegisterVehiclePage()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoSearchTextField(
              placeholder: 'Buscar veículo',
              controller: _searchController,
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                    final filteredDocs = _searchText.isEmpty
                        ? dados.docs
                        : dados.docs.where((doc) {
                            final plate = (doc['Placa'] ?? '')
                                .toString()
                                .toLowerCase();
                            return plate.contains(_searchText);
                          }).toList();
                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) =>
                          ShowVehicleComponent(snapshot: filteredDocs[index]),
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
