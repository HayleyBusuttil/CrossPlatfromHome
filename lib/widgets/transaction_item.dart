import 'package:flutter/material.dart';
import '../model/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.tx});

  final WalletTransaction tx;

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.type == TxType.income;
    final sign = isIncome ? "+" : "-";
    final amountColor = isIncome ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tx.category),
        trailing: Text(
          "$sign €${tx.amount.toStringAsFixed(2)}",
          style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
