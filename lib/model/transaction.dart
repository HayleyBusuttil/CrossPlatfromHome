import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
enum TxType {
  @HiveField(0)
  expense,
  @HiveField(1)
  income,
}

@HiveType(typeId: 1)
class WalletTransaction {
  WalletTransaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.receiptPath,
  });

  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final TxType type;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String? receiptPath;
}
