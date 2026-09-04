import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'pages/shop_page.dart';
import 'data/product_repository.dart';
import 'data/mock_product_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductRepository>(
          create: (_) => MockProductRepository(),
        ),
      ],
      child: MaterialApp(
        title: '1Fi App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const ShopPage(),
      ),
    );
  }
}

