import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:xsbg/models/battle_grid.dart';
import 'package:xsbg/models/battle_stroke.dart';
import 'package:xsbg/models/battle_token.dart';
import 'package:xsbg/models/battle_token_attribute.dart';
import 'package:xsbg/services/generated/xsbg.pb.dart';

extension TokenAttributeMessageExtensions on BattleTokenAttribute {
  TokenAttributeMessage toMessage() {
    return TokenAttributeMessage(
      name: name,
      value: value,
    );
  }
}

extension TokenMessageExtensions on BattleToken {
  TokenMessage toMessage() {
    return TokenMessage(
      id: id,
      x: x,
      y: y,
      name: name,
      icon: icon,
      attributes: attributes.map((e) => e.toMessage()),
      hexColor: hexColor,
    );
  }
}

extension StrokeMessageExtensions on BattleStroke {
  StrokeMessage toMessage() {
    return StrokeMessage(
      id: id,
      color: color.toSigned(32),
      temporary: temporary,
      timestamp: Int64(timestamp.millisecondsSinceEpoch),
      width: width,
      points: points.map((e) => StrokePointMessage(x: e.x, y: e.y)),
    );
  }
}

extension GridMessageExtensions on GridState {
  BattleGrid toDomain() {
    final grid = BattleGrid(
      name,
      width: width,
      height: height,
      id: id,
    );
    grid.entities.addAll(tokens.map((e) => e.toDomain()));
    grid.strokes.addAll(strokes.map((e) => e.toDomain()));
    return grid;
  }
}

extension GridMessages on BattleGrid {
  GridState toMessage() {
    return GridState(
      name: name,
      height: height,
      width: width,
      id: id,
      tokens: this.entities.map((e) => e.toMessage()),
      strokes: strokes.map((e) => e.toMessage()),
    );
  }
}

extension TokenExtensions on TokenMessage {
  BattleToken toDomain() {
    return BattleToken()
      ..x = x
      ..y = y
      ..hexColor = hexColor
      ..icon = icon
      ..name = name
      ..id = id;
  }
}

extension TokenAttributeExtensions on TokenAttributeMessage {
  BattleTokenAttribute toDomain() {
    return BattleTokenAttribute(name: name, value: value);
  }
}

extension StrokeExtensions on StrokeMessage {
  BattleStroke toDomain() {
    return BattleStroke()
      ..id = id
      ..width = width
      ..color = color
      ..temporary = temporary
      ..timestamp = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt())
      ..points = points.map((e) => Point<double>(e.x, e.y)).toList();
  }
}
