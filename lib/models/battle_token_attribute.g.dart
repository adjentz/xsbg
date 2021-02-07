// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_token_attribute.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleTokenAttributeAdapter extends TypeAdapter<BattleTokenAttribute> {
  @override
  final int typeId = 3;

  @override
  BattleTokenAttribute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BattleTokenAttribute(
      name: fields[0] as String,
      value: fields[2] as String,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BattleTokenAttribute obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleTokenAttributeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
