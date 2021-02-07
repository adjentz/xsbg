import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xsbg/state/battle_grid_state.dart';

import '../models/battle_grid.dart';
import '../models/battle_token.dart';
import 'package:xsbg/widgets/token_avatar.dart';
import 'game_lobby.dart' show TokenOptions;

typedef TokenSelectedCallback = void Function(BattleToken token);

class GridTokens extends StatefulWidget {
  final TokenOptions selectedTokenOption;

  final TokenSelectedCallback tokenSelected;

  GridTokens({this.selectedTokenOption, this.tokenSelected});

  @override
  State<StatefulWidget> createState() => _GridTokensState();
}

class _GridTokensState extends State<GridTokens> {
  Iterable<BattleToken> tokens;

  TokenOptions get selectedTokenOption => widget.selectedTokenOption;
  final random = math.Random.secure();

  String selectedEntityId;

  List<BattleToken> getEntitiesOnSquare(int x, int y) =>
      tokens.where((entity) => entity.x == x && entity.y == y).toList();

  Widget _tokenWidget(int index, BattleToken entity, int sharingSpaceCount) {
    final isSelected = entity.id == selectedEntityId;

    final horizontalLimit = 2;
    final size = (100 / math.min(sharingSpaceCount, horizontalLimit)) - 1;
    return SizedBox(
      width: size,
      height: size,
      child: Center(
          child: TokenAvatar(
        token: entity,
        selected: isSelected,
      )),
    );
  }

  Widget _squareEntities(int x, int y) {
    final onSquareTokens =
        tokens.where((element) => element.x == x && element.y == y);

    return Wrap(
      children: onSquareTokens
          .mapIndexedNotNull((index, token) =>
              _tokenWidget(index, token, onSquareTokens.length))
          .toList(),
    );
  }

  void _squareTapped(int x, int y) async {
    switch (selectedTokenOption) {
      case TokenOptions.Add:
        _addToken(x, y);
        break;
      case TokenOptions.Move:
        _moveToken(x, y);
        break;
      case TokenOptions.Select:
        _selectToken(x, y);
        break;
      case TokenOptions.Delete:
        _removeToken(x, y);
        break;
    }
  }

  void _addToken(int x, int y) {
    final gridState = context.read<BattleGridState>();

    final colors = {
      'Red': Colors.red.value.toRadixString(16),
      'Orange': Colors.orange.value.toRadixString(16),
      'Yellow': Colors.yellow.value.toRadixString(16),
      'Green': Colors.green.value.toRadixString(16),
      'Blue': Colors.blue.value.toRadixString(16),
      'Indigo': Colors.indigo.value.toRadixString(16),
      'Violet': Colors.purple.value.toRadixString(16),
      'Purple': Colors.purple.value.toRadixString(16)
    };

    final fruitNames = [
      'Mango',
      'Apple',
      'Banana',
      'Strawberry',
      'Clementine',
      'Peach',
      'Pear'
    ];

    String randomColor =
        colors.keys.elementAt(random.nextInt(colors.keys.length));
    String randomFruit =
        fruitNames.elementAt(random.nextInt(fruitNames.length));
    String name = '$randomColor $randomFruit';
    final nameIsTaken =
        (String name) => tokens.any((token) => token.name == name);

    while (nameIsTaken(name)) {
      randomColor = colors.keys.elementAt(random.nextInt(colors.keys.length));
      randomFruit = fruitNames.elementAt(random.nextInt(fruitNames.length));
      final randomInt = random.nextInt(99);
      name = '$randomColor $randomFruit$randomInt';
    }

    final newToken = BattleToken()
      ..x = x
      ..y = y
      ..hexColor = colors[randomColor]
      ..icon = FontAwesomeIcons.dragon.codePoint
      ..name = name;

    gridState.addToken(newToken);
  }

  void _removeToken(int x, int y) async {
    final entities = getEntitiesOnSquare(x, y);
    final gridState = context.read<BattleGridState>();

    if (entities.isEmpty) {
      return;
    }

    bool removeAll = false;
    BattleToken tokenToRemove;
    if (entities.length == 1) {
      tokenToRemove = entities.first;
    } else {
      tokenToRemove = await showModalBottomSheet(
          context: context,
          builder: (ctx) {
            final tiles = entities.map((e) => ListTile(
                  title: Text(e.name),
                  onTap: () => Navigator.of(ctx).pop(e),
                ));
            return ListView(
              children: [
                ListTile(
                  title: Text('Cancel'),
                  onTap: () => Navigator.of(ctx).pop(null),
                ),
                ...tiles,
                ListTile(
                  title: Text('All'),
                  onTap: () {
                    removeAll = true;
                    Navigator.of(ctx).pop(null);
                  },
                ),
              ],
            );
          });
    }
    if (tokenToRemove == null) {
      if (removeAll) {
        gridState.removeTokenRange(entities);
      }
      return;
    }

    gridState.removeToken(tokenToRemove);
  }

  void _selectToken(int x, int y) async {
    final entities = getEntitiesOnSquare(x, y);
    if (entities.isEmpty) {
      return;
    }

    BattleToken selectedToken;
    if (entities.length == 1) {
      selectedToken = entities.first;
    } else {
      selectedToken = await showModalBottomSheet(
          context: context,
          builder: (ctx) {
            final tiles = entities.map((e) => ListTile(
                  title: Text(e.name),
                  onTap: () => Navigator.of(ctx).pop(e),
                ));
            return ListView(
              children: [
                ListTile(
                  title: Text('Cancel'),
                  onTap: () => Navigator.of(ctx).pop(null),
                ),
                ...tiles,
              ],
            );
          });
    }
    if (selectedToken == null) {
      return;
    }

    setState(() {
      this.selectedEntityId = selectedToken.id;
    });
    widget.tokenSelected?.invoke(selectedToken);
  }

  void _moveToken(int x, int y) {
    if (selectedEntityId.isBlank) {
      return;
    }

    final gridState = context.read<BattleGridState>();
    final selectedToken = gridState.tokens
        .firstWhere((element) => element.id == selectedEntityId);

    final updatedToken = BattleToken.fromBattleToken(selectedToken)
      ..x = x
      ..y = y;

    context.read<BattleGridState>().updateToken(selectedToken, updatedToken);
  }

  Widget _battleSquare(int x, int y) {
    final size = 100.0;
    return Container(
        width: size,
        height: size,
        decoration:
            BoxDecoration(border: Border.all(width: 0.5), color: Colors.white),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: Colors.grey,
            onTap: () => _squareTapped(x, y),
            onLongPress: () => _selectToken(x, y),
            child: _squareEntities(x, y),
          ),
        ));
  }

  Widget _gridRow(BattleGrid grid, int row) {
    return Row(
      children: Iterable.generate(grid.width)
          .map((e) => _battleSquare(e, row))
          .toList(),
    );
  }

  Widget _grid(BattleGrid grid) {
    return Column(
      children:
          Iterable.generate(grid.height).map((e) => _gridRow(grid, e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gridState = context.watch<BattleGridState>();
    final grid = gridState.grid;
    if (grid == null) {
      return Text('Connecting...');
    }
    tokens = grid.entities;

    return _grid(grid);
  }
}
