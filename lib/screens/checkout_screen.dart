import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import '../theme/sunrise_theme.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _fulfillmentType = 'Pickup';
  String _paymentMethod = 'Credit Card';
  final _nameController = TextEditingController(text: 'Alex Johnson');
  final _phoneController = TextEditingController(text: '(555) 234-5678');

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoffeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fulfillment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: ['Pickup', 'Delivery'].map((method) {
                final isSelected = _fulfillmentType == method;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: OutlinedButton(
                      onPressed: () => setState(() => _fulfillmentType = method),
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
                        method,
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
              'Contact Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Column(
              children: ['Credit Card', 'Apple Pay', 'Cash on Pickup'].map((payment) {
                return RadioListTile<String>(
                  title: Text(payment),
                  value: payment,
                  groupValue: _paymentMethod,
                  activeColor: SunriseTheme.primary,
                  onChanged: (val) => setState(() => _paymentMethod = val!),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            const Text(
              'Order Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      const Text('Total Items', style: TextStyle(color: SunriseTheme.textMuted)),
                      Text('${provider.cart.fold(0, (sum, item) => sum + item.quantity)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      const Text('Total Amount', style: TextStyle(color: SunriseTheme.textMuted)),
                      Text('\$${provider.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: SunriseTheme.primary)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  provider.clearCart();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                    (route) => false,
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
                  'Place Order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
