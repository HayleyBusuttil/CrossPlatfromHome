import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'dart:io';

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
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(29, 0, 0, 0),
          child: Icon(
            _categoryIcon(tx.category),
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
        title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tx.category),
        trailing: Text(
          "$sign €${tx.amount.toStringAsFixed(2)}",
          style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

// Helper to get category icon to show in transaction item
  IconData _categoryIcon(String category) {
  switch (category) {
    case "Food":
      return Icons.fastfood;
    case "Transport":
      return Icons.directions_bus;
    case "Entertainment":
      return Icons.movie;
    case "Bills":
      return Icons.receipt_long;
    case "Salary":
      return Icons.account_balance_wallet;
    case "Freelance":
      return Icons.work;
    default:
      return Icons.category;
  }
}

}
