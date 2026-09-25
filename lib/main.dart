import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/coffee_provider.dart';
import 'screens/home_screen.dart';
import 'theme/sunrise_theme.dart';

void main() {
  runApp(const SunriseCoffeeApp());
}

class SunriseCoffeeApp extends StatelessWidget {
  const SunriseCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoffeeProvider(),
      child: MaterialApp(
        title: 'Sunrise Coffee Co.',
        debugShowCheckedModeBanner: false,
        theme: SunriseTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
