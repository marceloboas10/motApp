import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ProductSelectedMaintenanceComponent extends StatefulWidget {
  const ProductSelectedMaintenanceComponent({
    super.key,
    required this.list,
    required this.onRemoveProduct,
    required this.onUpdateQuantity,
  });
  final List<Map<String, dynamic>> list;
  final Function(int)? onRemoveProduct;
  final Function(int, int)? onUpdateQuantity;

  @override
  State<ProductSelectedMaintenanceComponent> createState() =>
      _ProductSelectedMaintenceComponentState();
}

class _ProductSelectedMaintenceComponentState
    extends State<ProductSelectedMaintenanceComponent> {
  int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  // Método para incrementar quantidade
  void _incrementQuantity(int index) {
    final currentQuantity = _parseToInt(widget.list[index]['quantidade']);
    final availableStock = _parseToInt(widget.list[index]['Quantidade']);

    if (currentQuantity < availableStock) {
      final newQuantity = currentQuantity + 1;
      if (widget.onUpdateQuantity != null) {
        widget.onUpdateQuantity!(index, newQuantity);
      }
    }
  }

  // Método para decrementar quantidade
  void _decrementQuantity(int index) {
    final currentQuantity = _parseToInt(widget.list[index]['quantidade']);

    if (currentQuantity > 0) {
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
        Container(
          decoration: BoxDecoration(),

          child: widget.list.isEmpty
              ? Text(
                  'Nenhum item adicionado ao serviço!',
                  style: TextStyle(color: LightColors.gray),
                )
              : Container(
                  decoration: BoxDecoration(),
                  height: 105,
                  child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: widget.list.length,
                    itemBuilder: (context, index) {
                      final product = widget.list[index];

                      final productName =
                          product['Produto'] ??
                          product['nome'] ??
                          'Produto ${index + 1}';

                      final quantidadeDisponivel = _parseToInt(
                        product['Quantidade'],
                      );

                      final quantidadeSelecionada = _parseToInt(
                        product['quantidade'],
                      );
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
                                          onTap: quantidadeSelecionada > 0
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
                                          '$quantidadeSelecionada',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      // Aumentar quantidade
                                      Expanded(
                                        child: InkWell(
                                          onTap:
                                              quantidadeSelecionada <
                                                  quantidadeDisponivel
                                              ? () => _incrementQuantity(index)
                                              : null,

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
                                              ? () => widget.onRemoveProduct!(
                                                  index,
                                                )
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
        ),
      ],
    );
  }
}
