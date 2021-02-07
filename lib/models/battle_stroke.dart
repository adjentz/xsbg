import 'dart:math';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'battle_stroke.g.dart';

@HiveType(typeId: 4)
class BattleStroke {
  @HiveField(0)
  String id;

  @HiveField(1)
  int color = 0xddd;

  @HiveField(2)
  int width = 6;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  bool temporary = false;

  @HiveField(5)
  List<Point<double>> points = [];

  BattleStroke() : id = Uuid().v4();
}

extension Helpers on Point<double> {
  Point<double> midPoint(Point other) {
    final midX = (this.x + other.x) / 2;
    final midY = (this.y + other.y) / 2;

    return Point(midX, midY);
  }
}

class PointAdapter extends TypeAdapter<Point<double>> {
  @override
  final typeId = 7;

  @override
  Point<double> read(BinaryReader reader) {
    return Point<double>(reader.readDouble(), reader.readDouble());
  }

  @override
  void write(BinaryWriter writer, Point<double> obj) {
    writer.writeDouble(obj.x);
    writer.writeDouble(obj.y);
  }
}
