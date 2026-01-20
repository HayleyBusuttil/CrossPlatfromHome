import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/transaction.dart';
import 'screens/home_screen.dart';

import 'services/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TxTypeAdapter());
  Hive.registerAdapter(WalletTransactionAdapter());

  await Hive.openBox<WalletTransaction>('transactions');

  await Notifications.instance.init();

  runApp(const WiseWalletApp());
}

class WiseWalletApp extends StatelessWidget {
  const WiseWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
