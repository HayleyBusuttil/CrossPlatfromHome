import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const WiseWalletApp());
}

class WiseWalletApp extends StatelessWidget {
  const WiseWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wise Wallet',
      home: const HomeScreen(),
    );
  }
}
