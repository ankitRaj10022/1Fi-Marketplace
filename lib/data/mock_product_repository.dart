import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';
import 'product_repository.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final jsonString = await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> data = json.decode(jsonString);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<Product> fetchProductById(String id) async {
    final products = await fetchProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      throw Exception('Product not found');
    }
  }
}
