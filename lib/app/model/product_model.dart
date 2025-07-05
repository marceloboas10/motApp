class ProductModel {
  late String id;
  late String product;
  late int amount;

  ProductModel(this.id, this.product, this.amount);

  ProductModel.froJson(Map<String, dynamic> map, this.id)
    : product = map['Produto'],
      amount = map['Quantidade'];

  Map<String, dynamic> toJson() {
    return {'product': product, 'amount': amount};
  }

  doc(String id) {}
}
