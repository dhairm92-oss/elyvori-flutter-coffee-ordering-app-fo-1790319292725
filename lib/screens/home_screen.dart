import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import '../widgets/coffee_card.dart';
import '../widgets/category_chips.dart';
import 'cart_screen.dart';
import '../theme/sunrise_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoffeeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Sunrise Coffee Co.',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: SunriseTheme.secondary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Brewed fresh to start your day ☀️',
                        style: TextStyle(
                          fontSize: 14,
                          color: SunriseTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CartScreen()),
                          );
                        },
                        icon: const Icon(Icons.shopping_bag_outlined, size: 28),
                        color: SunriseTheme.secondary,
                      ),
                      if (provider.cart.isNotEmpty)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: SunriseTheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${provider.cart.fold(0, (sum, item) => sum + item.quantity)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: (val) => provider.setSearchQuery(val),
                decoration: InputDecoration(
                  hintText: 'Search your favorite brew...',
                  hintStyle: const TextStyle(color: SunriseTheme.textMuted),
                  prefixIcon: const Icon(Icons.search, color: SunriseTheme.primary),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: SunriseTheme.primary, width: 1.5),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Categories
            const CategoryChips(),

            const SizedBox(height: 10),

            // Coffee Grid
            Expanded(
              child: provider.items.isEmpty
                  ? const Center(
                      child: Text(
                        'No coffees found matching your search.',
                        style: TextStyle(color: SunriseTheme.textMuted),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: provider.items.length,
                      itemBuilder: (context, index) {
                        return CoffeeCard(item: provider.items[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}