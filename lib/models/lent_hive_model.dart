import 'package:hive/hive.dart';

part 'lent_hive_model.g.dart';

@HiveType(typeId: 3)
class LentHiveModel extends HiveObject{
  @HiveField(13)
  late String name;

  @HiveField(14)
  late String reason;

  @HiveField(15)
  late double amount;

  @HiveField(16)
  late DateTime dateTime;

}
