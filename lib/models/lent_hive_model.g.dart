// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lent_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LentHiveModelAdapter extends TypeAdapter<LentHiveModel> {
  @override
  final int typeId = 3;

  @override
  LentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LentHiveModel()
      ..name = fields[13] as String
      ..reason = fields[14] as String
      ..amount = fields[15] as double
      ..dateTime = fields[16] as DateTime;
  }

  @override
  void write(BinaryWriter writer, LentHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(13)
      ..write(obj.name)
      ..writeByte(14)
      ..write(obj.reason)
      ..writeByte(15)
      ..write(obj.amount)
      ..writeByte(16)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
