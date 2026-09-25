import 'coffee_item.dart';

class CartItem {
  final CoffeeItem item;
  final String size; // 'Small', 'Medium', 'Large'
  final String milk; // 'Whole', 'Oat', 'Almond', 'Skim'
  final int shots;
  int quantity;

  CartItem({
    required this.item,
    required this.size,
    required this.milk,
    required this.shots,
    this.quantity = 1,
  });

  double get totalPrice {
    double sizeMultiplier = size == 'Medium' ? 1.2 : (size == 'Large' ? 1.4 : 1.0);
    double shotExtra = (shots > 2) ? (shots - 2) * 0.75 : 0.0;
    double milkExtra = (milk == 'Oat' || milk == 'Almond') ? 0.60 : 0.0;
    return ((item.price * sizeMultiplier) + shotExtra + milkExtra) * quantity;
  }
}
