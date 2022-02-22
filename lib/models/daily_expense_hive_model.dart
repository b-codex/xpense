import 'package:hive/hive.dart';

part 'daily_expense_hive_model.g.dart';

@HiveType(typeId: 2)
class DailyExpenseHiveModel extends HiveObject {
  @HiveField(10)
  late String reason;

  @HiveField(11)
  late double amount;

  @HiveField(12)
  late DateTime dateTime;

  // DailyExpense({required this.reason, required this.amount});
}
