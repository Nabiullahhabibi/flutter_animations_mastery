import 'package:flutter/material.dart';

// ============================================================
// APP
// ============================================================

class SharedElementDemoApp extends StatelessWidget {
  const SharedElementDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared Element Transition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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
  final double price;
  final IconData icon;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

// ============================================================
// SAMPLE PRODUCTS
// ============================================================

const products = [
  Product(
    id: 1,
    name: 'Flutter Course',
    description:
        'Learn Flutter from fundamentals to advanced application development.',
    price: 49.99,
    icon: Icons.flutter_dash,
  ),
  Product(
    id: 2,
    name: 'Animation Course',
    description:
        'Master implicit, explicit, route, Hero, and advanced animations.',
    price: 59.99,
    icon: Icons.animation,
  ),
  Product(
    id: 3,
    name: 'Dart Course',
    description:
        'Learn Dart programming, asynchronous programming, and advanced concepts.',
    price: 39.99,
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
      appBar: AppBar(title: const Text('Shared Element Transition')),
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
                    return ProductDetailsScreen(product: product);
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

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ==================================================
              // SHARED IMAGE ELEMENT
              // ==================================================
              Hero(
                tag: 'product-image-${product.id}',

                // ------------------------------------------------
                // Custom widget used during the Hero flight.
                // ------------------------------------------------
                flightShuttleBuilder:
                    (
                      flightContext,
                      animation,
                      flightDirection,
                      fromHeroContext,
                      toHeroContext,
                    ) {
                      return Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                          child: Icon(product.icon, size: 80),
                        ),
                      );
                    },

                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Icon(product.icon, size: 48),
                ),
              ),

              const SizedBox(width: 16),

              // ==================================================
              // TEXT
              // ==================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'product-name-${product.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Hero(
                      tag: 'product-price-${product.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(Icons.arrow_forward_ios, size: 18),
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

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==================================================
            // SHARED IMAGE
            // ==================================================
            Hero(
              tag: 'product-image-${product.id}',
              child: Container(
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Icon(product.icon, size: 150),
              ),
            ),

            const SizedBox(height: 32),

            // ==================================================
            // SHARED TITLE
            // ==================================================
            Hero(
              tag: 'product-name-${product.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // SHARED PRICE
            // ==================================================
            Hero(
              tag: 'product-price-${product.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              product.description,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),

            const SizedBox(height: 32),

            const Text(
              'This screen demonstrates multiple shared elements. '
              'The image, title, and price each have their own '
              'Hero tag and transition between the two routes.',
              style: TextStyle(fontSize: 16, height: 1.5),
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
