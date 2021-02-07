// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleTokenAdapter extends TypeAdapter<BattleToken> {
  @override
  final int typeId = 2;

  @override
  BattleToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BattleToken()
      ..id = fields[1] as String
      ..name = fields[2] as String
      ..icon = fields[3] as int
      ..hexColor = fields[4] as String
      ..x = fields[5] as int
      ..y = fields[6] as int
      ..attributes = (fields[7] as List)?.cast<BattleTokenAttribute>();
  }

  @override
  void write(BinaryWriter writer, BattleToken obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.hexColor)
      ..writeByte(5)
      ..write(obj.x)
      ..writeByte(6)
      ..write(obj.y)
      ..writeByte(7)
      ..write(obj.attributes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
