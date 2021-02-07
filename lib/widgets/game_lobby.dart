import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xsbg/models/battle_grid.dart';

import 'package:xsbg/models/draw_settings.dart';
import 'package:xsbg/state/battle_grid_state.dart';
import 'package:xsbg/state/lobby_state.dart';
import 'package:xsbg/widgets/token_detail.dart';
import 'package:xsbg/models/battle_token.dart';
import 'package:xsbg/widgets/lobby_code.dart';
import 'package:xsbg/widgets/grid_tokens.dart';

import 'grid_drawings.dart';

class GameLobby extends StatefulWidget {
  GameLobby();

  @override
  State<StatefulWidget> createState() => _GameLobbyState();
}

class _GameLobbyState extends State<GameLobby> {
  bool drawing = false;
  bool eraserOn = false;

  TokenOptions selectedTokenOption = TokenOptions.Add;
  BattleToken selectedEntity;

  DrawSettings drawSettings;

  double scale = 0.25;

  final interactiveController = TransformationController();
  @override
  void initState() {
    super.initState();

    var matrix = Matrix4.identity();
    matrix = matrix.scaled(scale, scale);
    matrix.setTranslationRaw(50.0, 50.0, 50.0);
    interactiveController.value = matrix;

    final isHost = context.read<LobbyState>().hosting;
    drawSettings = DrawSettings.presets
        .firstWhere((element) => isHost || element.temporary);
  }

  Widget _drawingSettingsDropDown(bool isHosting) {
    final items = DrawSettings.presets
        .where((element) => isHosting || element.temporary)
        .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
        .toList();

    return Container(
      margin: EdgeInsets.only(left: 15),
      child: DropdownButton(
          items: items,
          value: drawSettings,
          onChanged: (selectedSetting) {
            setState(() {
              drawSettings = selectedSetting;
              eraserOn = false;
            });
          }),
    );
  }

  Widget _buildGrid() {
    final tokenLayer = Row(children: [
      GridTokens(
        selectedTokenOption: selectedTokenOption,
        tokenSelected: (token) {
          setState(() {
            selectedTokenOption = TokenOptions.Move;
            selectedEntity = token;
          });
        },
      ),
      Container(
        child: LobbyCode(),
        margin: EdgeInsets.only(left: 30.0),
      ),
    ]);

    return InteractiveViewer(
      transformationController: interactiveController,
      panEnabled: !drawing,
      scaleEnabled: !drawing,
      minScale: 0.25,
      boundaryMargin: EdgeInsets.all(double.infinity),
      constrained: false,
      child: Stack(
        children: [
          tokenLayer,
          IgnorePointer(
            ignoring: !drawing,
            child: SizedBox(
              width: 100.0 * 20,
              height: 100.0 * 20,
              child: GridDrawings(
                drawSettings: drawSettings,
                erasing: eraserOn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setDrawing(bool drawing) {
    setState(() {
      this.drawing = drawing;
      if (!drawing) {
        eraserOn = false;
      }
    });
  }

  Widget _bottomToolHint() {
    Widget tip;
    if (!drawing) {
      switch (this.selectedTokenOption) {
        case TokenOptions.Add:
          tip = Wrap(
            children: [
              Icon(Icons.info),
              Text('Select a space to place a new token.'),
              Text(
                  'Press and hold on a space with an existing token to select it.'),
            ],
          );
          break;
        case TokenOptions.Delete:
          tip = Wrap(children: [
            Icon(Icons.info),
            Text('Select a space with an existing token to delete it.')
          ]);
          break;
        case TokenOptions.Move:
          tip = Wrap(
            children: [
              Text('Select a space to move this token there.'),
              Text('Or press and hold on a different token to select it.'),
            ],
          );
          break;
        default:
      }
    }

    if (drawing) {
      tip = Wrap(children: [
        Text('${drawSettings.name}: '),
        Text(drawSettings.description ?? '')
      ]);
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: tip,
    );
  }

  void _viewEntityDetails() async {
    final route = MaterialPageRoute<BattleToken>(
        builder: (_) => TokenDetail(selectedEntity));
    final updatedToken = await Navigator.of(context).push(route);
    if (updatedToken == null) {
      return;
    }

    final gridState = context.read<BattleGridState>();
    gridState.updateToken(selectedEntity, updatedToken);

    setState(() {
      selectedEntity = updatedToken;
    });
  }

  void setTokenOption(TokenOptions option) {
    setState(() {
      selectedTokenOption = option;
      if (option == TokenOptions.Select) {
        selectedEntity = null;
      }
    });
  }

  Color get defaultIconColor => Theme.of(context).colorScheme.onPrimary;
  Color get selectedIconColor => Theme.of(context).highlightColor;

  Widget _tokenToolbar() {
    final addActive = selectedTokenOption == TokenOptions.Add;
    final deleteActive = selectedTokenOption == TokenOptions.Delete;
    final moveActive = selectedTokenOption == TokenOptions.Move;

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add),
          color: addActive ? selectedIconColor : defaultIconColor,
          onPressed: () => setTokenOption(TokenOptions.Add),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: deleteActive ? selectedIconColor : defaultIconColor,
          onPressed: () => setTokenOption(TokenOptions.Delete),
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.shoePrints),
          color: moveActive ? selectedIconColor : defaultIconColor,
          onPressed: selectedEntity == null
              ? null
              : () => setTokenOption(TokenOptions.Move),
        ),
        IconButton(
          icon: Icon(Icons.details_outlined),
          color: defaultIconColor,
          onPressed: selectedEntity == null ? null : () => _viewEntityDetails(),
        ),
      ],
    );
  }

  Widget _drawToolbar() {
    final isHosting = context.select((LobbyState lobby) => lobby.hosting);

    return Row(
      children: [
        _drawingSettingsDropDown(isHosting),
        if (isHosting)
          IconButton(
            color: eraserOn ? selectedIconColor : null,
            icon: FaIcon(FontAwesomeIcons.eraser),
            onPressed: () {
              setState(() {
                eraserOn = !eraserOn;
              });
            },
          )
      ],
    );
  }

  void undo() {
    context.read<BattleGridState>().undo();
  }

  void redo() {
    context.read<BattleGridState>().redo();
  }

  Widget _activeToolbarOptions() {
    final undoable = context.select(
      (BattleGridState value) => [value.canUndo, value.canRedo],
    );
    final canUndo = undoable.first;
    final canRedo = undoable.last;

    Widget toolbar = drawing ? _drawToolbar() : _tokenToolbar();
    final fullTools = Row(
      children: [
        if (toolbar != null) toolbar,
        Spacer(),
        IconButton(icon: Icon(Icons.undo), onPressed: canUndo ? undo : null),
        IconButton(icon: Icon(Icons.redo), onPressed: canRedo ? redo : null),
      ],
    );
    return PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Column(children: [Divider(), fullTools]));
  }

  void setScale(double scale) {
    setState(() {
      final existingTranslation = interactiveController.value.getTranslation();
      var matrix = Matrix4.identity();
      matrix.setTranslation(existingTranslation);
      matrix = matrix.scaled(scale, scale);
      interactiveController.value = matrix;
    });
  }

  void _zoomIn() {
    double newScale = (scale + 0.25).clamp(0.25, 2);
    setScale(newScale);
  }

  void _zoomOut() {
    double newScale = (scale - 0.25).clamp(0.25, 2);
    setScale(newScale);
  }

  void _save() async {
    final gridState = context.read<BattleGridState>();
    final box = await Hive.openBox<BattleGrid>('grids');
    box.put(gridState.grid.id, gridState.grid);
    Navigator.of(context).pop(); // closes drawer
  }

  void _load() async {
    final box = await Hive.openBox<BattleGrid>('grids');

    final selectedGrid = await showModalBottomSheet<BattleGrid>(
        context: context,
        builder: (ctx) {
          return ListView.builder(itemBuilder: (_, index) {
            if (index > box.keys.length - 1) {
              return null;
            }

            final grid = box.getAt(index);
            if (grid == null) {
              return null;
            }

            return ListTile(
              leading: FaIcon(FontAwesomeIcons.chess),
              title: Text(grid.name),
              subtitle: Text('${grid.width}x${grid.height}'),
              onTap: () => Navigator.of(ctx).pop(grid),
            );
          });
        });

    Navigator.of(context).pop();
    if (selectedGrid == null) {
      return;
    }
    context.read<BattleGridState>().switchGrid(selectedGrid);
  }

  Widget _drawer() {
    final isHosting = context.select((LobbyState lobby) => lobby.hosting);
    return Drawer(
        child: ListView(children: [
      ListTile(
        leading: Icon(Icons.save),
        title: Text('Save Grid'),
        subtitle: isHosting ? null : Text('Save a copy locally'),
        onTap: _save,
      ),
      if (isHosting)
        ListTile(
          leading: Icon(Icons.open_in_new),
          title: Text('Load Grid'),
          onTap: _load,
        ),
      ListTile(
        leading: Icon(Icons.close),
        title: Text(isHosting ? 'Close Lobby' : 'Leave Session'),
        onTap: () {
          context.read<LobbyState>().endSession();
          Navigator.of(context).pop(); // close drawer
          Navigator.of(context).pop(); // close lobby
        },
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    final title = drawing ? 'Draw' : 'Tokens';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: _activeToolbarOptions(),
        actions: [
          IconButton(
              icon: Icon(Icons.zoom_out),
              onPressed: _zoomOut,
              color: defaultIconColor),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _zoomIn,
            color: defaultIconColor,
          ),
          IconButton(
            color: !drawing ? selectedIconColor : defaultIconColor,
            icon: FaIcon(FontAwesomeIcons.chessBishop),
            onPressed: () => _setDrawing(false),
          ),
          IconButton(
            color: drawing ? selectedIconColor : defaultIconColor,
            icon: FaIcon(FontAwesomeIcons.paintBrush),
            onPressed: () => _setDrawing(true),
          ),
        ],
      ),
      drawer: _drawer(),
      body: WillPopScope(
        child: Container(
          child: _buildGrid(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/parchment.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        onWillPop: () {
          context.read<LobbyState>().endSession();
          return Future.value(true);
        },
      ),
      backgroundColor: Colors.green,
      bottomSheet: _bottomToolHint(),
    );
  }
}

enum TokenOptions { Add, Move, Select, Delete }
