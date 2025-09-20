import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motapp/app/model/customer_model.dart';
import 'package:motapp/app/pages/customers/register_customer_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowCustomerCompoment extends StatefulWidget {
  const ShowCustomerCompoment({
    super.key,
    required this.snapshot,
    required this.function,
    required this.fileImage,
  });
  final dynamic snapshot;
  final VoidCallback function;
  final File? fileImage;

  @override
  State<ShowCustomerCompoment> createState() => _ShowCustomerCompomentState();
}

class _ShowCustomerCompomentState extends State<ShowCustomerCompoment> {
  @override
  Widget build(BuildContext context) {
    CustomerModel customer = CustomerModel.fromJson(
      widget.snapshot.data(),
      widget.snapshot.id,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: widget.fileImage == null
                          ? NetworkImage(
                              'https://i.pinimg.com/474x/a8/da/22/a8da222be70a71e7858bf752065d5cc3.jpg',
                            )
                          : FileImage(widget.fileImage!),
                    ),
                    Positioned(
                      top: 27,
                      left: 27,
                      child: IconButton(
                        onPressed: widget.function,
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  customer.nome,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  customer.celular,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RegisterCustomerPage(),
                          settings: RouteSettings(arguments: customer.id),
                        ),
                      ),
                      child: Icon(Icons.edit_outlined, size: 30),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Excluir Lembrete",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              "Tem certeza que deseja excluir ${customer.nome}?",
                              style: TextStyle(fontSize: 18),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Não",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Cliente ${customer.nome} excluído com sucesso!',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                  FirebaseFirestore.instance
                                      .collection('clientes')
                                      .doc(customer.id)
                                      .delete();
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Sim",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(
                        Icons.delete_outlined,
                        size: 30,
                        color: LightColors.buttonRed,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Visibility(
                      visible: customer.motoAlugada.length > 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xFFccfbf1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(customer.motoAlugada.toString()),
                      ),
                    ),
                    Visibility(
                      visible: customer.pagamentoPendente!,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: LightColors.buttonRed,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('Pagamento Pendente'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
