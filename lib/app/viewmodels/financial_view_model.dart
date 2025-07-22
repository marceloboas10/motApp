import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FinancialViewModel extends ChangeNotifier {
  String _filtroAtivo = 'todos';
  Map<String, double>? _totais;
  bool _isLoading = false;

  String get filtroAtivo => _filtroAtivo;
  Map<String, double>? get totais => _totais;
  bool get isLoading => _isLoading;

  void setFiltro(String filtro) {
    _filtroAtivo = filtro;
    notifyListeners();
  }

  // Stream que retorna as transações filtradas
  Stream<QuerySnapshot> getTransacoesFiltradas() {
    final collection = FirebaseFirestore.instance.collection('transacoes');

    switch (_filtroAtivo) {
      case 'entradas':
        return collection
            .where('Tipo', isEqualTo: 'entrada')
            // .orderBy('Data', descending: true) // Remova para evitar erro de índice
            .snapshots();
      case 'saidas':
        return collection
            .where('Tipo', isEqualTo: 'saida')
            // .orderBy('Data', descending: true) // Remova para evitar erro de índice
            .snapshots();
      default:
        return collection.orderBy('Data', descending: true).snapshots();
    }
  }

  // Calcula o saldo total
  Future<void> calcularSaldo() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('transacoes')
          .get();

      double totalEntradas = 0;
      double totalSaidas = 0;

      for (var doc in snapshot.docs) {
        final tipo = doc['Tipo'];
        final valor = doc['Valor'].toDouble();

        if (tipo == 'entrada') {
          totalEntradas += valor;
        } else if (tipo == 'saida') {
          totalSaidas += valor;
        }
      }

      _totais = {
        'entradas': totalEntradas,
        'saidas': totalSaidas,
        'saldo': totalEntradas - totalSaidas,
      };
    } catch (e) {
      _totais = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Para atualização em tempo real dos totais
  Stream<Map<String, double>> getTotaisStream() {
    return FirebaseFirestore.instance.collection('transacoes').snapshots().map((
      snapshot,
    ) {
      double totalEntradas = 0;
      double totalSaidas = 0;

      for (var doc in snapshot.docs) {
        final tipo = doc['Tipo'];
        final valor = doc['Valor'].toDouble();

        if (tipo == 'entrada') {
          totalEntradas += valor;
        } else if (tipo == 'saida') {
          totalSaidas += valor;
        }
      }

      return {
        'entradas': totalEntradas,
        'saidas': totalSaidas,
        'saldo': totalEntradas - totalSaidas,
      };
    });
  }
}
