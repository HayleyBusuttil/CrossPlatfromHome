enum TxType { expense, income }

class WalletTransaction {
  WalletTransaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  final String title;
  final double amount;
  final DateTime date;
  final TxType type;
  final String category;
}
