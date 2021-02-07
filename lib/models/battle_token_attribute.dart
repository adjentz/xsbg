import 'package:hive/hive.dart';

part 'battle_token_attribute.g.dart';

@HiveType(typeId: 3)
class BattleTokenAttribute {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  String value;

  BattleTokenAttribute({this.name, this.value, this.timestamp});

  factory BattleTokenAttribute.fromGridTokenAttribute(
      BattleTokenAttribute original) {
    return BattleTokenAttribute(
        name: original.name,
        value: original.value,
        timestamp: original.timestamp);
  }
}
