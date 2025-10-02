import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerViewModel extends ChangeNotifier {
  final bool _isLoading = false;
  Map<String, int>? _statusOperacional;

  bool get isLoading => _isLoading;
  Map<String, int>? get statusOperacional => _statusOperacional;

  final userId = FirebaseAuth.instance.currentUser?.uid;

  // Stream para status operacional em tempo real
  Stream<Map<String, int>> getStatusOperacionalStream() {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('clientes')
        .snapshots()
        .asyncMap((clientesSnapshot) async {
          int totalClientes = clientesSnapshot.docs.length;
          int motosAlugadas = 0;
          int pagamentosPendentes = 0;

          // Conta motos alugadas
          for (var doc in clientesSnapshot.docs) {
            final data = doc.data();

            final motoAlugada = data['Moto_Alugada'];
            final pagamentoPendente = data['Pagamento_Pendente'];

            // Moto alugada = campo não nulo, não vazio e diferente de '0'
            if (motoAlugada != null &&
                motoAlugada != '0' &&
                motoAlugada.toString().trim().isNotEmpty) {
              motosAlugadas++;
            }

            if (pagamentoPendente == true) {
              pagamentosPendentes++;
            }
          }

          // Busca total de veículos
          final veiculosSnapshot = await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(userId)
              .collection('veiculos')
              .get();

          final totalMotos = veiculosSnapshot.docs.length;
          final motosDisponiveis = totalMotos - motosAlugadas;

          return {
            'totalClientes': totalClientes,
            'motosAlugadas': motosAlugadas,
            'motosDisponiveis': motosDisponiveis,
            'pagamentosPendentes': pagamentosPendentes,
          };
        });
  }
}
