class ProductVariant {
  final String id;
  final String name;
  final String value;
  final double additionalPrice;

  ProductVariant({
    required this.id,
    required this.name,
    required this.value,
    this.additionalPrice = 0.0,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double basePrice;
  final List<ProductVariant> variants;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.basePrice,
    this.variants = const [],
  });
}
