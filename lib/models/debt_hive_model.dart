import 'package:hive/hive.dart';

part 'debt_hive_model.g.dart';

@HiveType(typeId: 1)
class DebtHiveModel extends HiveObject {
  @HiveField(3)
  late String name;

  @HiveField(4)
  late String reason;

  @HiveField(5)
  late double amount;

  @HiveField(6)
  late DateTime dateTime;
}
