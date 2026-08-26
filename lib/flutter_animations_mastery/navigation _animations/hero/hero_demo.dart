import 'package:flutter/material.dart';


class HeroDemoApp extends StatelessWidget {
  const HeroDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hero Animation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}

// ============================================================
// PRODUCT MODEL
// ============================================================

class Product {
  final int id;
  final String name;
  final String description;
  final IconData icon;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

// ============================================================
// SAMPLE DATA
// ============================================================

const products = [
  Product(
    id: 1,
    name: 'Flutter',
    description: 'Build beautiful cross-platform applications.',
    icon: Icons.flutter_dash,
  ),
  Product(
    id: 2,
    name: 'Animation',
    description: 'Create smooth and interactive animations.',
    icon: Icons.animation,
  ),
  Product(
    id: 3,
    name: 'Dart',
    description: 'A modern language optimized for app development.',
    icon: Icons.code,
  ),
];

// ============================================================
// PRODUCT LIST SCREEN
// ============================================================

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return ProductDetailsScreen(
                      product: product,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// PRODUCT CARD
// ============================================================

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ------------------------------------------------
              // SOURCE HERO
              // ------------------------------------------------

              Hero(
                tag: 'product-${product.id}',
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                  ),
                  child: Icon(
                    product.icon,
                    size: 42,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PRODUCT DETAILS SCREEN
// ============================================================

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ------------------------------------------------
            // DESTINATION HERO
            //
            // Notice that the tag is exactly the same:
            //
            // 'product-${product.id}'
            // ------------------------------------------------

            Hero(
              tag: 'product-${product.id}',
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                ),
                child: Icon(
                  product.icon,
                  size: 140,
                ),
              ),
            ),

            const SizedBox(height: 32),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              product.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'The element above is a Hero widget. '
              'The Hero on this screen has the same tag as '
              'the Hero on the previous screen.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}