import 'package:flutter/material.dart';
import '../model/transaction.dart';
import '../widgets/transaction_list.dart';
import 'add_transaction.dart';
import 'package:hive/hive.dart';

import '../services/notifications.dart';
import '../services/analytics.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Hive box for transactions 
  late Box<WalletTransaction> _txBox;
  List<WalletTransaction> _txs = [];


  double get incomeTotal => _txs
      .where((t) => t.type == TxType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get expenseTotal => _txs
      .where((t) => t.type == TxType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get balance => incomeTotal - expenseTotal;

  void _openAddScreen() async {
    await Analytics.instance.logOpenAddScreen();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const AddTransactionScreen()),
    );

    if (result == null) return;

    await Analytics.instance.logAddTransaction(
      type: result.type == TxType.expense ? "expense" : "income",
      category: result.category,
      amount: result.amount,
    );

    if (result.type == TxType.expense && result.amount >= 50) {
      await Notifications.instance.showHighExpense(result.amount);
    }

    await _txBox.add(result);
    setState(() {
      _txs = _txBox.values.toList().reversed.toList();
    });

  }


  @override
  void initState() {
    super.initState();
    _txBox = Hive.box<WalletTransaction>('transactions');
    _txs = _txBox.values.toList().reversed.toList();
  }


  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No transactions yet. Tap + to add one!"),
    );

    if (_txs.isNotEmpty) {
      content = TransactionList(transactions: _txs);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wise Wallet"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color.fromARGB(255, 58, 85, 133), Color.fromARGB(255, 100, 140, 158)]),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text("HB"),
                foregroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 58, 85, 133), Color.fromARGB(255, 100, 140, 158)],
          ),
        ),
        child: FloatingActionButton(
          onPressed: _openAddScreen,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add),
          foregroundColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Balance card (kept inline so we don't make tons of widgets)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromARGB(255, 58, 85, 133), const Color.fromARGB(255, 100, 140, 158)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Current Balance",
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 6),
                  Text(
                    "€${balance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _miniBox(
                          title: "Income",
                          value: "€${incomeTotal.toStringAsFixed(2)}",
                          icon: Icons.trending_up,
                          iconColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _miniBox(
                          title: "Expenses",
                          value: "€${expenseTotal.toStringAsFixed(2)}",
                          icon: Icons.trending_down,
                          iconColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.circle, size: 10, color: Colors.green),
                      SizedBox(width: 8),
                      Text("You’re well within budget",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Recent Transactions",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _miniBox({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(value, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
