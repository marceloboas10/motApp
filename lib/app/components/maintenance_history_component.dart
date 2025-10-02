import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class MaintenanceHistoryComponent extends StatefulWidget {
  const MaintenanceHistoryComponent({super.key, this.vehicleId});

  final String? vehicleId;

  @override
  State<MaintenanceHistoryComponent> createState() =>
      _MaintenanceHistoryComponentState();
}

class _MaintenanceHistoryComponentState
    extends State<MaintenanceHistoryComponent> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null || widget.vehicleId == null || widget.vehicleId == '0') {
      return Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(
          'Selecione um veículo para ver o histórico.',
          style: TextStyle(color: LightColors.gray, fontSize: 16),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Histórico de Manutenção',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(userId)
              .collection('manutencoes')
              .where('vehicleId', isEqualTo: widget.vehicleId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text(
                'Nenhum serviço registrado para este veículo.',
                style: TextStyle(color: LightColors.gray),
              );
            }

            final services = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                final data = service.data() as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    title: Text(data['servico'] ?? 'Serviço sem nome'),
                    subtitle: Text('Data: ${data['data'] ?? 'N/A'}'),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
