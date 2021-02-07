// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_stroke.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BattleStrokeAdapter extends TypeAdapter<BattleStroke> {
  @override
  final int typeId = 4;

  @override
  BattleStroke read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BattleStroke()
      ..id = fields[0] as String
      ..color = fields[1] as int
      ..width = fields[2] as int
      ..timestamp = fields[3] as DateTime
      ..temporary = fields[4] as bool
      ..points = (fields[5] as List)?.cast<Point<double>>();
  }

  @override
  void write(BinaryWriter writer, BattleStroke obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.temporary)
      ..writeByte(5)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BattleStrokeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
