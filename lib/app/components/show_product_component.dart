import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/model/product_model.dart';
import 'package:motapp/app/pages/products/register_product_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowProductComponent extends StatefulWidget {
  const ShowProductComponent({super.key, required this.snapshot});
  final dynamic snapshot;

  @override
  State<ShowProductComponent> createState() => _ShowProductComponentState();
}

class _ShowProductComponentState extends State<ShowProductComponent> {
  @override
  Widget build(BuildContext context) {
    ProductModel product = ProductModel.froJson(
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
                title: Text(
                  product.product,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  ' Quantidade: ${product.amount}',
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
                              RegisterProductPage(),
                          settings: RouteSettings(
                            arguments: widget.snapshot.id,
                          ),
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
                              "Tem certeza que deseja excluir ${product.product}?",
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
                                  final userId =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  if (userId != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Produto ${product.product} excluído com sucesso!',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  FirebaseFirestore.instance
                                      .collection('produtos')
                                      .doc(product.id)
                                      .delete();
                                  }
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
            ],
          ),
        ),
      ),
    );
  }
}
