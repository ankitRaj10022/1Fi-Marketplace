import 'dart:async';
import '../models/product.dart';
import '../models/emi_plan.dart';

class MockApiService {
  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<List<Product>> fetchProducts() async {
    await _delay();
    return [
      Product(
        id: '1',
        name: 'iPhone 15 Pro Max',
        description: 'Titanium design with A17 Pro chip and a more advanced 48MP Main camera.',
        imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?q=80&w=600&auto=format&fit=crop', // Unsplash placeholder
        basePrice: 159900.0,
        variants: [
          ProductVariant(id: 'v1', name: 'Storage', value: '256GB'),
          ProductVariant(id: 'v2', name: 'Storage', value: '512GB', additionalPrice: 20000.0),
          ProductVariant(id: 'v3', name: 'Color', value: 'Natural Titanium'),
          ProductVariant(id: 'v4', name: 'Color', value: 'Blue Titanium'),
        ],
      ),
      Product(
        id: '2',
        name: 'Sony PlayStation 5',
        description: 'Experience lightning-fast loading with an ultra-high speed SSD, deeper immersion with support for haptic feedback.',
        imageUrl: 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?q=80&w=600&auto=format&fit=crop',
        basePrice: 54990.0,
        variants: [
          ProductVariant(id: 'v1', name: 'Edition', value: 'Disc Edition'),
          ProductVariant(id: 'v2', name: 'Edition', value: 'Digital Edition', additionalPrice: -10000.0),
        ],
      ),
      Product(
        id: '3',
        name: 'MacBook Air M2',
        description: 'Supercharged by M2. Strikingly thin design. All-day battery life.',
        imageUrl: 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?q=80&w=600&auto=format&fit=crop',
        basePrice: 114900.0,
        variants: [
          ProductVariant(id: 'v1', name: 'RAM', value: '8GB'),
          ProductVariant(id: 'v2', name: 'RAM', value: '16GB', additionalPrice: 20000.0),
          ProductVariant(id: 'v3', name: 'Storage', value: '256GB SSD'),
          ProductVariant(id: 'v4', name: 'Storage', value: '512GB SSD', additionalPrice: 20000.0),
        ],
      ),
    ];
  }

  Future<List<EmiPlan>> fetchEmiPlans(double productPrice) async {
    await _delay();
    return [
      EmiPlan(
        id: 'emi_3',
        tenureMonths: 3,
        monthlyEmi: productPrice / 3,
      ),
      EmiPlan(
        id: 'emi_6',
        tenureMonths: 6,
        monthlyEmi: productPrice / 6,
      ),
      EmiPlan(
        id: 'emi_9',
        tenureMonths: 9,
        monthlyEmi: productPrice / 9,
      ),
      EmiPlan(
        id: 'emi_12',
        tenureMonths: 12,
        monthlyEmi: productPrice / 12,
      ),
    ];
  }
}
