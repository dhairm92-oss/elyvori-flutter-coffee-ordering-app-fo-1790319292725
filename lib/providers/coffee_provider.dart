import 'package:flutter/foundation.dart';
import '../models/coffee_item.dart';
import '../models/cart_item.dart';

class CoffeeProvider with ChangeNotifier {
  final List<CoffeeItem> _items = [
    const CoffeeItem(
      id: 'c1',
      name: 'Sunrise Signature Latte',
      description: 'Espresso with velvety microfoam and a hint of vanilla caramel.',
      price: 4.50,
      category: 'Hot Coffee',
      imageUrl: 'https://images.unsplash.com/photo-1561882468-9110eef0e3f5?w=500&auto=format&fit=crop&q=60',
    ),
    const CoffeeItem(
      id: 'c2',
      name: 'Golden Hour Cold Brew',
      description: 'Steeped for 18 hours, smooth, bold, and naturally sweet.',
      price: 4.00,
      category: 'Cold Brew',
      imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500&auto=format&fit=crop&q=60',
    ),
    const CoffeeItem(
      id: 'c3',
      name: 'Morning Espresso',
      description: 'Rich, robust double shot with a thick golden crema.',
      price: 3.00,
      category: 'Espresso',
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500&auto=format&fit=crop&q=60',
    ),
    const CoffeeItem(
      id: 'c4',
      name: 'Dawn Cappuccino',
      description: 'Equal parts espresso, steamed milk, and airy deep foam.',
      price: 4.25,
      category: 'Hot Coffee',
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=500&auto=format&fit=crop&q=60',
    ),
    const CoffeeItem(
      id: 'c5',
      name: 'Vanilla Iced Macchiato',
      description: 'Layered cold milk, espresso, and rich vanilla drizzle.',
      price: 4.80,
      category: 'Iced',
      imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500&auto=format&fit=crop&q=60',
    ),
    const CoffeeItem(
      id: 'c6',
      name: 'Spiced Chai Latte',
      description: 'Black tea infused with cardamom, cinnamon, and steamed milk.',
      price: 4.50,
      category: 'Teas',
      imageUrl: 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?w=500&auto=format&fit=crop&q=60',
    ),
  ];

  final List<CartItem> _cart = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<CoffeeItem> get items {
    List<CoffeeItem> filtered = _items;
    if (_selectedCategory != 'All') {
      filtered = filtered.where((item) => item.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item.description.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    return filtered;
  }

  List<String> get categories => ['All', 'Hot Coffee', 'Cold Brew', 'Espresso', 'Iced', 'Teas'];
  String get selectedCategory => _selectedCategory;

  List<CartItem> get cart => _cart;

  double get subtotal {
    return _cart.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get tax => subtotal * 0.08;

  double get total => subtotal + tax;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addToCart(CartItem cartItem) {
    // Check if exact same item configuration exists
    final index = _cart.indexWhere((element) => 
      element.item.id == cartItem.item.id &&
      element.size == cartItem.size &&
      element.milk == cartItem.milk &&
      element.shots == cartItem.shots
    );

    if (index >= 0) {
      _cart[index].quantity += cartItem.quantity;
    } else {
      _cart.add(cartItem);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int delta) {
    _cart[index].quantity += delta;
    if (_cart[index].quantity <= 0) {
      _cart.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
