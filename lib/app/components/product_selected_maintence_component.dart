import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ProductSelectedMaintenceComponent extends StatefulWidget {
  const ProductSelectedMaintenceComponent({
    super.key,
    required this.list,
    required this.onRemoveProduct,
    required this.onUpdateQuantity,
  });
  final List<Map<String, dynamic>> list;
  final Function(int)? onRemoveProduct;
  final Function(int, int)? onUpdateQuantity;

  @override
  State<ProductSelectedMaintenceComponent> createState() =>
      _ProductSelectedMaintenceComponentState();
}

class _ProductSelectedMaintenceComponentState
    extends State<ProductSelectedMaintenceComponent> {
  // Método para incrementar quantidade
  void _incrementQuantity(int index) {
    final currentQuantity = widget.list[index]['quantidade'] ?? 1;
    final newQuantity = currentQuantity + 1;

    if (widget.onUpdateQuantity != null) {
      widget.onUpdateQuantity!(index, newQuantity);
    }
  }

  // Método para decrementar quantidade
  void _decrementQuantity(int index) {
    final currentQuantity = widget.list[index]['quantidade'] ?? 1;
    if (currentQuantity > 1) {
      final newQuantity = currentQuantity - 1;

      if (widget.onUpdateQuantity != null) {
        widget.onUpdateQuantity!(index, newQuantity);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Itens Adicionados ao Serviço',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: widget.list.isEmpty
              ? Text(
                  'Nenhum item adicionado ao serviço!',
                  style: TextStyle(color: LightColors.gray),
                )
              : ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    final product = widget.list[index];
                    final productName =
                        product['nome'] ??
                        product['Produto'] ??
                        product['name'] ??
                        'Produto ${index + 1}';

                    final amount = product['quantidade'] ?? product['qtd'] ?? 1;
                    int contador = 0;

                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        title: Text(
                          productName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: widget.onRemoveProduct != null
                            ? SizedBox(
                                width: 120,

                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: amount > 1
                                            ? () => _decrementQuantity(index)
                                            : null,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.grey,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Quantidade atual
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        '$contador',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    // Aumentar quantidade
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (contador <= amount) {
                                            setState(() {
                                              contador++;
                                            });
                                          }

                                          print(contador);
                                        },

                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.grey,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 8),

                                    // Remover produto
                                    Expanded(
                                      child: InkWell(
                                        onTap: widget.onRemoveProduct != null
                                            ? () =>
                                                  widget.onRemoveProduct!(index)
                                            : null,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: LightColors.buttonRed,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                        dense: true,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
