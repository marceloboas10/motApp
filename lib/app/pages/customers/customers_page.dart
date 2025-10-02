import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/components/show_customer_compoment.dart';
import 'package:motapp/app/pages/customers/register_customer_page.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  late CollectionReference customers;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      customers = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userId)
          .collection('clientes');
    } else {}

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showOptionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.image, color: Colors.grey[500]),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.camera_alt, color: Colors.grey[500]),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();

                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.delete, color: Colors.grey[500]),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: 'Clientes', page: RegisterCustomerPage()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: 'Buscar cliente',
              backgroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: customers.orderBy('Nome').snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text('Erro na conexão com o banco de dados'),
                    );
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (!snapshot.hasData) {
                      return Center(child: Text('Não tem dados'));
                    }
                    final dados = snapshot.requireData;

                    final filteredDocs = _searchText.isEmpty
                        ? dados.docs
                        : dados.docs.where((doc) {
                            final nome = (doc['Nome'] ?? '')
                                .toString()
                                .toLowerCase();
                            return nome.contains(_searchText);
                          }).toList();
                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) => ShowCustomerCompoment(
                        snapshot: filteredDocs[index],
                        function: _showOptionBottomSheet,
                        fileImage: imageFile,
                      ),
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
