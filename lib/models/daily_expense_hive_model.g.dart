// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_expense_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyExpenseHiveModelAdapter extends TypeAdapter<DailyExpenseHiveModel> {
  @override
  final int typeId = 2;

  @override
  DailyExpenseHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyExpenseHiveModel()
      ..reason = fields[10] as String
      ..amount = fields[11] as double
      ..dateTime = fields[12] as DateTime;
  }

  @override
  void write(BinaryWriter writer, DailyExpenseHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(10)
      ..write(obj.reason)
      ..writeByte(11)
      ..write(obj.amount)
      ..writeByte(12)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyExpenseHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
