import 'dart:convert';

class ProductModel {
  // final String id;
  final String name;
  final double price;
  final String product;
  final String status;
  ProductModel({
    // required this.id,
    required this.name,
    required this.price,
    required this.product,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'price': price,
      'product': product,
      'status': status,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      // id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      product: map['product'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}