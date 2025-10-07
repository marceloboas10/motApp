import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ProductUsedMaintenanceComponent extends StatefulWidget {
  const ProductUsedMaintenanceComponent({
    super.key,
    required this.searchController,
    required this.onProductsChanged,
  });
  final TextEditingController searchController;
  final Function(List<Map<String, dynamic>>) onProductsChanged;

  @override
  State<ProductUsedMaintenanceComponent> createState() =>
      _ProductUsedMaintenceComponentState();
}

class _ProductUsedMaintenceComponentState
    extends State<ProductUsedMaintenanceComponent> {
  String searchText = '';
  List<Map<String, dynamic>> productSelected = [];

  void addProduct(String id, String nome, int estoque) {
    bool alreadyAdded = productSelected.any((p) => p['id'] == id);

    if (alreadyAdded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Produto já adicionado'),
        ),
      );
      return;
    }

    setState(() {
      productSelected.add({
        'id': id,
        'Produto': nome,
        'Quantidade': estoque,
        'quantidade': 0,
      });
    });

    widget.onProductsChanged(productSelected);
  }

  void removeProduct(int index) {
    setState(() {
      productSelected.removeAt(index);
    });
    widget.onProductsChanged(productSelected);
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Produtos utilizados',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          'Busque e adicione os produtos usados no serviço.',
          style: TextStyle(fontSize: 12, color: LightColors.gray),
        ),
        SizedBox(height: 8),
        CupertinoSearchTextField(
          controller: widget.searchController,
          placeholder: 'Buscar produto',
          backgroundColor: Colors.white,
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(),
          height: 160,
          child: StreamBuilder<QuerySnapshot>(
            stream: userId != null
                ? FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(userId)
                      .collection('produtos')
                      .snapshots()
                : Stream.empty(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              var products = snapshot.data!.docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final productName = (data['Produto'] ?? '')
                    .toString()
                    .toLowerCase();
                return searchText.isEmpty ||
                    productName.contains(searchText.toLowerCase());
              }).toList();

              if (products.isEmpty) {
                return Center(child: Text('Nenhum produto encontrado'));
              }

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final doc = products[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final productName = (data['Produto']);
                  final productAmount = (data['Quantidade'] as num).toInt();

                  return Card(
                    child: ListTile(
                      title: Text(
                        productName,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('Estoque: $productAmount'),
                      trailing: ElevatedButton(
                        onPressed: () =>
                            addProduct(doc.id, productName, productAmount),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightColors.iconColorGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                        ),
                        child: Text(
                          'Adicionar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
