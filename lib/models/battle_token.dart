import 'package:xsbg/models/battle_token_attribute.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'battle_token.g.dart';

@HiveType(typeId: 2)
class BattleToken {
  @HiveField(1)
  String id;

  @HiveField(2)
  String name = '';

  @HiveField(3)
  int icon;

  @HiveField(4)
  String hexColor;

  @HiveField(5)
  int x = 0;

  @HiveField(6)
  int y = 0;

  @HiveField(7)
  List<BattleTokenAttribute> attributes = [];

  BattleToken() : id = Uuid().v4();

  String get initials => name.split(' ').map((e) => e[0]).join().toUpperCase();

  factory BattleToken.fromBattleToken(BattleToken original) {
    return BattleToken()
      ..id = original.id
      ..name = original.name
      ..icon = original.icon
      ..hexColor = original.hexColor
      ..x = original.x
      ..y = original.y
      ..attributes = original.attributes
          .map((a) => BattleTokenAttribute.fromGridTokenAttribute(a))
          .toList();
  }
}
