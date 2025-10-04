import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

// Faça este componente ser um StatelessWidget, pois ele não precisa gerenciar estado.
class DropdownVehicleMaintenanceComponent extends StatelessWidget {
  final String? vehicleSelected;
  final ValueChanged<String?> onChanged;

  const DropdownVehicleMaintenanceComponent({
    super.key,
    required this.vehicleSelected,
    required this.onChanged,
  });

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

            List<DropdownMenuItem<String>> vehiclesItems = [];

            vehiclesItems.add(
              const DropdownMenuItem(value: '0', child: Text('Nenhum')),
            );

            for (var doc in snapshotProduct.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              final plate = data['Placa'];
              vehiclesItems.add(
                DropdownMenuItem<String>(value: doc.id, child: Text(plate)),
              );
            }

            return DropdownButtonFormField<String>(
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
              // O valor exibido agora é controlado pela tela pai (MaintenancePage)
              initialValue: vehicleSelected,
              items: vehiclesItems,
              // Ao mudar a seleção, a função `onChanged` é chamada para notificar a tela pai
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }
}
