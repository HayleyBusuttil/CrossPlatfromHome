import 'package:flutter/material.dart';
import '../model/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  TxType _type = TxType.expense;
  String _category = "Food";

  final _expenseCategories = [
    "Food",
    "Transport",
    "Entertainment",
    "Bills",
    "Other"
  ];

  final _incomeCategories = [
    "Salary",
    "Freelance",
    "Other"
  ];

  void _submit() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) {
      return;
    }

    final tx = WalletTransaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      type: _type,
      category: _category,
    );

    Navigator.pop(context, tx);
  }

  @override
Widget build(BuildContext context) {
  final categories =
      _type == TxType.expense ? _expenseCategories : _incomeCategories;

  final isExpense = _type == TxType.expense;
  final primaryGradient = isExpense ? LinearGradient(colors: [Colors.red.shade400, const Color.fromARGB(255, 129, 57, 57)]) : LinearGradient(colors: [Colors.green.shade400, const Color.fromARGB(255, 47, 100, 48)]);
  final primaryColor = isExpense ? Colors.red.shade400 : Colors.green.shade400;

  return Scaffold(
    appBar: AppBar(
      title: const Text("Add Transaction"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle Expense / Income
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                _typeButton(
                  label: "Expense",
                  selected: isExpense,
                  gradient: primaryGradient,
                  onTap: () {
                    setState(() {
                      _type = TxType.expense;
                      _category = _expenseCategories[0];
                    });
                  },
                ),
                _typeButton(
                  label: "Income",
                  selected: !isExpense,
                  gradient: primaryGradient,
                  onTap: () {
                    setState(() {
                      _type = TxType.income;
                      _category = _incomeCategories[0];
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Amount input
          const Text("Amount", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: "€ ",
              hintText: "0.00",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Category selection
          const Text("Category", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (ctx, i) {
              final cat = categories[i];
              final selected = cat == _category;

              return GestureDetector(
                onTap: () => setState(() => _category = cat),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? primaryColor : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _categoryIcon(cat),
                        color: selected ? primaryColor : Colors.grey,
                      ),
                      const SizedBox(height: 6),
                      Text(cat, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Description input
          const Text("Description", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "Add a note ...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Receipt Button
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Add Receipt Image"),
          ),

          const SizedBox(height: 24),

          // Submit button
          Container(
            decoration: BoxDecoration(
              gradient: primaryGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              isExpense ? "Add Expense" : "Add Income",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          ),
        ],
      ),
    ),
  );
}
// Helper widget for type selection buttons
Widget _typeButton({
  required String label,
  required bool selected,
  required Gradient gradient,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: selected ? gradient : null,
          color: selected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}
// Helper to get category icon
IconData _categoryIcon(String category) {
  switch (category) {
    case "Food":
      return Icons.fastfood;
    case "Transport":
      return Icons.directions_car;
    case "Entertainment":
      return Icons.movie;
    case "Bills":
      return Icons.receipt_long;
    case "Salary":
      return Icons.work;
    case "Freelance":
      return Icons.laptop_mac;
    default:
      return Icons.category;
  }
}
}