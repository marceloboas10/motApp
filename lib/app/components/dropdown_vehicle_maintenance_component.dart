import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class DropdownVehicleMaintenanceComponent extends StatefulWidget {
  DropdownVehicleMaintenanceComponent({
    super.key,
    required this.vehicleSelected,
    required this.onChanged,
  });
  String? vehicleSelected;
  final ValueChanged<String?> onChanged;

  @override
  State<DropdownVehicleMaintenanceComponent> createState() =>
      _DropdownVehicleMaintenceComponentState();
}

class _DropdownVehicleMaintenceComponentState
    extends State<DropdownVehicleMaintenanceComponent> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecione o veículo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        StreamBuilder<QuerySnapshot>(
          stream: userId != null
              ? FirebaseFirestore.instance
                    .collection('usuarios')
                    .doc(userId)
                    .collection('veiculos')
                    .orderBy('Placa')
                    .snapshots()
              : Stream.empty(),
          builder: (context, snapshotProduct) {
            if (!snapshotProduct.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            List<DropdownMenuItem> vehiclesItems = [];

            vehiclesItems.add(
              const DropdownMenuItem(value: null, child: Text('Nenhum')),
            );

            for (var doc in snapshotProduct.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              final plate = data['Placa'];
              vehiclesItems.add(
                DropdownMenuItem<String>(value: doc.id, child: Text(plate)),
              );
            }

            return DropdownButtonFormField<dynamic>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: LightColors.iconColorGreen),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffe2e8f0)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              dropdownColor: Colors.white,
              items: vehiclesItems,
              initialValue: widget.vehicleSelected,
              onChanged: (value) {
                setState(() {
                  widget.vehicleSelected = value;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
