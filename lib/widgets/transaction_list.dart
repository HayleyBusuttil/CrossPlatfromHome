import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions});

  final List<WalletTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, i) => TransactionItem(tx: transactions[i]),
    );
  }
}
