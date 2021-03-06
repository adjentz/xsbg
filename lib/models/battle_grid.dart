import 'package:hive/hive.dart';
import 'package:xsbg/models/battle_token.dart';
import 'package:xsbg/models/battle_stroke.dart';

part 'battle_grid.g.dart';

@HiveType(typeId: 1)
class BattleGrid {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int width;

  @HiveField(2)
  final int height;

  @HiveField(3)
  final List<BattleToken> entities;

  @HiveField(4)
  final List<BattleStroke> strokes;

  @HiveField(5)
  final String id;

  BattleGrid(
    this.name, {
    this.width,
    this.height,
    this.id,
    this.entities,
    this.strokes,
  });
}
