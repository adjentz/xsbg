// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_grid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleGridAdapter extends TypeAdapter<BattleGrid> {
  @override
  final int typeId = 1;

  @override
  BattleGrid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BattleGrid(
      fields[0] as String,
      width: fields[1] as int,
      height: fields[2] as int,
      id: fields[5] as String,
      entities: (fields[3] as List)?.cast<BattleToken>(),
      strokes: (fields[4] as List)?.cast<BattleStroke>(),
    );
  }

  @override
  void write(BinaryWriter writer, BattleGrid obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.entities)
      ..writeByte(4)
      ..write(obj.strokes)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleGridAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
