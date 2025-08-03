import 'dart:ui';

class barDataMonthly {
  final String month;
  final int spent;
  final Color color;

  barDataMonthly({
    required this.month,
    required this.spent,
    required this.color,
  });
}

class barDataDaily {
  final String day;
  final int spent;
  final Color color;

  barDataDaily({
    required this.day,
    required this.spent,
    required this.color,
  });
}
