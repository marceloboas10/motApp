import 'package:flutter/material.dart';
import 'package:motapp/app/model/product_model.dart';
import 'package:motapp/app/pages/products/register_product_page.dart';

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
      padding: const EdgeInsets.all(16),
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
                trailing: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterProductPage(),
                      settings: RouteSettings(arguments: widget.snapshot.id),
                    ),
                  ),
                  child: Icon(Icons.edit_outlined, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
