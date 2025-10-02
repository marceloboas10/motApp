import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  CollectionReference? get _transacoesCollection {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;
    return FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('transacoes');
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
    final collection = _transacoesCollection;
    if (collection == null) {
      return Stream.value({'entradas': 0, 'saidas': 0, 'saldo': 0});
    }

    return collection.snapshots().map((snapshot) {
      double totalEntradas = 0;
      double totalSaidas = 0;

      for (var doc in snapshot.docs) {
        final tipo = doc['Tipo'];
        final valor = (doc['Valor'] as num).toDouble();

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

  Stream<Map<String, double>> getTotaisMesCorrenteStream() {
    final collection = _transacoesCollection;
    if (collection == null)
      return Stream.value({'entradas': 0, 'saidas': 0, 'saldo': 0});

    final agora = DateTime.now();
    final inicioMes = DateTime(agora.year, agora.month, 1);
    final fimMes = DateTime(
      agora.year,
      agora.month + 1,
      0,
    ); // Corrigido para pegar o último dia do mês

    return collection
        .where('Data', isGreaterThanOrEqualTo: Timestamp.fromDate(inicioMes))
        .where(
          'Data',
          isLessThanOrEqualTo: Timestamp.fromDate(fimMes),
        ) // Corrigido para ser inclusivo
        .snapshots()
        .map((snapshot) {
          double totalEntradas = 0;
          double totalSaidas = 0;

          for (var doc in snapshot.docs) {
            final tipo = doc['Tipo'];
            final valor = (doc['Valor'] as num).toDouble();

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
