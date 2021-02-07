import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xsbg/models/battle_token.dart';

class TokenAvatar extends StatelessWidget {
  final BattleToken token;
  final bool selected;
  TokenAvatar({this.token, this.selected});

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(token.hexColor, radix: 16));
    final icon = FaIcon(
      IconDataSolid(token.icon),
      size: 30.0,
      color: Colors.black,
    );
    final circle = CircleAvatar(
      radius: 32,
      backgroundColor: selected ? Colors.black : Colors.white,
      child: CircleAvatar(
        radius: 30,
        child: Center(child: icon),
        backgroundColor: color,
      ),
    );

    if (!selected) {
      return circle;
    }

    return Material(
      child: circle,
      color: Colors.white,
      type: MaterialType.circle,
      elevation: 15.0,
    );
  }
}
