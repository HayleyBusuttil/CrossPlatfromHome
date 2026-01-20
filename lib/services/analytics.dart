import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  Analytics._();
  static final Analytics instance = Analytics._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logOpenAddScreen() async {
    await _analytics.logEvent(name: 'open_add_screen');
  }

  Future<void> logAddTransaction({
    required String type,
    required String category,
    required double amount,
  }) async {
    await _analytics.logEvent(
      name: 'add_transaction',
      parameters: {
        'type': type,
        'category': category,
        'amount': amount,
      },
    );
  }
}
