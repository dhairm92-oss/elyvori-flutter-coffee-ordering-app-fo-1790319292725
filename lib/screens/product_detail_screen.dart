import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_item.dart';
import '../models/cart_item.dart';
import '../providers/coffee_provider.dart';
import '../theme/sunrise_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final CoffeeItem item;

  const ProductDetailScreen({super.key, required this.item});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'Medium';
  String _selectedMilk = 'Whole';
  int _shots = 2;
  int _quantity = 1;

  double get _calculatedPrice {
    double sizeMultiplier = _selectedSize == 'Medium' ? 1.2 : (_selectedSize == 'Large' ? 1.4 : 1.0);
    double shotExtra = (_shots > 2) ? (_shots - 2) * 0.75 : 0.0;
    double milkExtra = (_selectedMilk == 'Oat' || _selectedMilk == 'Almond') ? 0.60 : 0.0;
    return ((widget.item.price * sizeMultiplier) + shotExtra + milkExtra) * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image header with back button
                  Stack(
                    children: [
                      Image.network(
                        widget.item.imageUrl,
                        height: 320,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: SunriseTheme.textMain),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: SunriseTheme.secondary,
                                ),
                              ),
                            ),
                            Text(
                              '\$${widget.item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: SunriseTheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: SunriseTheme.textMuted,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),
                        const Text(
                          'Select Size',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: ['Small', 'Medium', 'Large'].map((size) {
                            final isSelected = _selectedSize == size;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: OutlinedButton(
                                  onPressed: () => setState(() => _selectedSize = size),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: isSelected ? SunriseTheme.primary : Colors.white,
                                    side: BorderSide(
                                      color: isSelected ? SunriseTheme.primary : Colors.grey.shade300,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : SunriseTheme.textMain,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 24),
                        const Text(
                          'Milk Choice',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: ['Whole', 'Oat', 'Almond', 'Skim'].map((milk) {
                            final isSelected = _selectedMilk == milk;
                            return ChoiceChip(
                              label: Text(milk),
                              selected: isSelected,
                              onSelected: (_) => setState(() => _selectedMilk = milk),
                              selectedColor: SunriseTheme.primary,
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : SunriseTheme.textMain,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: isSelected ? SunriseTheme.primary : Colors.grey.shade300,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 24),
                        const Text(
                          'Espresso Shots',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_shots > 1) setState(() => _shots--);
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                              color: SunriseTheme.primary,
                            ),
                            Text(
                              '$_shots Shots',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_shots < 5) setState(() => _shots++);
                              },
                              icon: const Icon(Icons.add_circle_outline),
                              color: SunriseTheme.primary,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Text(
                          'Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_quantity > 1) setState(() => _quantity--);
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                              color: SunriseTheme.primary,
                            ),
                            Text(
                              '$_quantity',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () => setState(() => _quantity++),
                              icon: const Icon(Icons.add_circle_outline),
                              color: SunriseTheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Price', style: TextStyle(color: SunriseTheme.textMuted, fontSize: 12)),
                    Text(
                      '\$${_calculatedPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: SunriseTheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CoffeeProvider>(context, listen: false).addToCart(
                        CartItem(
                          item: widget.item,
                          size: _selectedSize,
                          milk: _selectedMilk,
                          shots: _shots,
                          quantity: _quantity,
                        ),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to your Sunrise bag! ☕'),
                          backgroundColor: SunriseTheme.primary,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SunriseTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Add to Bag',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}