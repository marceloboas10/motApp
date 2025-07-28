import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/components/show_product_component.dart';
import 'package:motapp/app/pages/products/register_product_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late CollectionReference products;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    products = FirebaseFirestore.instance.collection('produtos');
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: 'Produtos', page: RegisterProductPage()),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: 'Buscar produto',
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: products.orderBy('Produto').snapshots(),
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
                            final nome = (doc['Produto'] ?? '')
                                .toString()
                                .toLowerCase();
                            return nome.contains(_searchText);
                          }).toList();
                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) =>
                          ShowProductComponent(snapshot: filteredDocs[index]),
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
