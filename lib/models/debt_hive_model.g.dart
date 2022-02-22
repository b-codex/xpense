// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtHiveModelAdapter extends TypeAdapter<DebtHiveModel> {
  @override
  final int typeId = 1;

  @override
  DebtHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtHiveModel()
      ..name = fields[3] as String
      ..reason = fields[4] as String
      ..amount = fields[5] as double
      ..dateTime = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, DebtHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.reason)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
