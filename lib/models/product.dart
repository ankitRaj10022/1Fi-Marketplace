import 'emi_plan.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double basePrice;
  final List<String> variants;
  final List<EmiPlan> emiPlans;

  Product({
    required this.id,
    required this.name,
    this.description = '',
    required this.imageUrl,
    required this.basePrice,
    this.variants = const [],
    this.emiPlans = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      variants: json['variants'] != null ? List<String>.from(json['variants']) : [],
      emiPlans: json['emiPlans'] != null 
          ? (json['emiPlans'] as List).map((e) => EmiPlan.fromJson(e)).toList() 
          : [],
    );
  }
}
