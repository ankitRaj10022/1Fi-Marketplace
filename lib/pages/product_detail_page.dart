import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/emi_plan.dart';
import '../services/mock_api_service.dart';
import '../theme/app_theme.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final MockApiService _apiService = MockApiService();
  
  // Track selected variant ID per category (e.g., 'Storage': 'v1', 'Color': 'v3')
  final Map<String, String> _selectedVariants = {};
  
  double get _currentPrice {
    double price = widget.product.basePrice;
    for (var variant in widget.product.variants) {
      if (_selectedVariants[variant.name] == variant.id) {
        price += variant.additionalPrice;
      }
    }
    return price;
  }

  @override
  void initState() {
    super.initState();
    // Auto-select first variant in each category
    final categories = widget.product.variants.map((e) => e.name).toSet();
    for (var category in categories) {
      final firstVariant = widget.product.variants.firstWhere((v) => v.name == category);
      _selectedVariants[category] = firstVariant.id;
    }
  }

  void _showEmiBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return EmiSelectionSheet(
          productPrice: _currentPrice,
          apiService: _apiService,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.product.variants.map((e) => e.name).toSet();

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '₹${_currentPrice.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primaryPurple,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  
                  // Variants Selector
                  for (var category in categories) ...[
                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: widget.product.variants
                          .where((v) => v.name == category)
                          .map((variant) {
                        final isSelected = _selectedVariants[category] == variant.id;
                        return ChoiceChip(
                          label: Text(variant.value),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedVariants[category] = variant.id;
                              });
                            }
                          },
                          selectedColor: AppTheme.primaryPurple.withOpacity(0.1),
                          labelStyle: TextStyle(
                            color: isSelected ? AppTheme.primaryPurple : AppTheme.darkNavy,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected ? AppTheme.primaryPurple : Colors.grey.shade300,
                            ),
                          ),
                          backgroundColor: AppTheme.white,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => _showEmiBottomSheet(context),
            child: const Text('View EMI Plans'),
          ),
        ),
      ),
    );
  }
}

class EmiSelectionSheet extends StatefulWidget {
  final double productPrice;
  final MockApiService apiService;

  const EmiSelectionSheet({
    super.key,
    required this.productPrice,
    required this.apiService,
  });

  @override
  State<EmiSelectionSheet> createState() => _EmiSelectionSheetState();
}

class _EmiSelectionSheetState extends State<EmiSelectionSheet> {
  late Future<List<EmiPlan>> _emiPlansFuture;
  EmiPlan? _selectedPlan;

  @override
  void initState() {
    super.initState();
    _emiPlansFuture = widget.apiService.fetchEmiPlans(widget.productPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.lightGreyBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select EMI Plan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<EmiPlan>>(
              future: _emiPlansFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppTheme.primaryPurple));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No EMI plans available.'));
                }

                final plans = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final plan = plans[index];
                    final isSelected = _selectedPlan?.id == plan.id;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPlan = plan;
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isSelected ? AppTheme.primaryPurple : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Radio<EmiPlan>(
                                value: plan,
                                groupValue: _selectedPlan,
                                activeColor: AppTheme.primaryPurple,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPlan = value;
                                  });
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${plan.tenureMonths} Months',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${plan.monthlyEmi.toStringAsFixed(0)} / mo',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: AppTheme.primaryPurple,
                                          ),
                                    ),
                                    if (plan.interestRate == 0)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          'NO-COST EMI',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.bold,
                                              ),
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
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppTheme.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                )
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedPlan == null
                      ? null
                      : () {
                          // Proceed with plan CTA
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selected ${_selectedPlan!.tenureMonths} Months Plan'),
                              backgroundColor: AppTheme.primaryPurple,
                            ),
                          );
                          Navigator.pop(context); // Close sheet
                        },
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[600],
                  ),
                  child: Text('Proceed with Plan'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
