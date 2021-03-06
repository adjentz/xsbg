import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:grpc/grpc_connection_interface.dart';
import '../services/grpc_channel_provider.dart'
    if (dart.library.io) '../services/grpc_channel_provider_io.dart'
    if (dart.library.html) '../services/grpc_channel_provider_web.dart';

import 'package:xsbg/models/battle_grid.dart';
import 'package:xsbg/models/battle_stroke.dart';
import 'package:xsbg/models/battle_token.dart';
import 'package:xsbg/services/generated/xsbg.pbgrpc.dart';
import 'package:xsbg/state/lobby_state.dart';
import 'message_extensions.dart';

class BattleGridState with ChangeNotifier {
  LobbyState lobby;
  BattleGridServiceClient _client;
  ClientChannelBase _channel;

  BattleGridState(LobbyState lobby) {
    lobbyUpdated(lobby);
  }

  void lobbyUpdated(LobbyState lobby) async {
    this.lobby = lobby;
    if (lobby == null) {
      return;
    }

    if (lobby.shutdown) {
      try {
        if (lobby.hosting) {
          await _client?.closeSession(GridUpdateMessage());
        }
        await _channel?.shutdown();
        lobby.closeServer();
        _client = null;
      } catch (err) {
        print(err);
      }
      return;
    }

    if (!lobby.readyToConnect) {
      return;
    }

    _channel = createChannel(lobby.ipAddress, lobby.port);
    _client = BattleGridServiceClient(_channel);
    _clearActions();
    listenForUpdates();
  }

  void listenForUpdates() async {
    await for (var updatedGrid in _client.gridUpdates(GridUpdateMessage())) {
      grid = updatedGrid.toDomain();
      notifyListeners();
    }

    lobby.endSession();
  }

  BattleGrid grid;

  UnmodifiableListView<BattleStroke> get strokes =>
      UnmodifiableListView<BattleStroke>(grid?.strokes ?? []);

  UnmodifiableListView<BattleToken> get tokens =>
      UnmodifiableListView<BattleToken>(grid?.entities ?? []);

  bool get canUndo => _actions.isNotEmpty;

  bool get canRedo => _redoActions.isNotEmpty;

  List<UndoableAction> _actions = [];
  List<UndoableAction> _redoActions = [];

  void addToken(BattleToken token, {bool recordAction: true}) {
    _client?.addToken(token.toMessage());

    if (!recordAction) {
      return;
    }
    final action = UndoableAction<BattleToken>()
      ..action = UndoAction.add
      ..value = token;
    _commitAction(action);
  }

  void removeToken(BattleToken token, {bool recordAction: true}) {
    _client?.removeToken(token.toMessage());
    if (!recordAction) {
      return;
    }

    final action = UndoableAction<BattleToken>()
      ..action = UndoAction.remove
      ..value = token;

    _commitAction(action);
  }

  void removeTokenRange(Iterable<BattleToken> tokens) {
    _client?.removeMultipleTokens(
      MultipleTokensMessage(
        tokens: tokens.map((e) => e.toMessage()),
      ),
    );
  }

  void updateToken(BattleToken original, BattleToken updated,
      {bool recordAction: true}) {
    _client?.updateToken(updated.toMessage());

    if (!recordAction) {
      return;
    }

    final action = UndoableAction<BattleToken>()
      ..action = UndoAction.update
      ..previousValue = original
      ..value = updated;

    _commitAction(action);
  }

  void addStroke(BattleStroke stroke, {bool recordAction: true}) {
    _client?.addStroke(stroke.toMessage());
    if (!recordAction || stroke.temporary) {
      return;
    }
    final action = UndoableAction<BattleStroke>()
      ..action = UndoAction.add
      ..value = stroke;

    _commitAction(action);
  }

  void removeStroke(BattleStroke stroke, {bool recordAction}) {
    _client?.removeStroke(stroke.toMessage());

    if (!recordAction) {
      return;
    }
    final action = UndoableAction<BattleStroke>()
      ..action = UndoAction.remove
      ..value = stroke;

    _commitAction(action);
  }

  void removeStrokeRange(Iterable<BattleStroke> strokes,
      {bool recordAction: true}) {
    final actionAlreadyQueued = _actions.isNotEmpty &&
        _actions.last.action == UndoAction.remove &&
        (_actions.last.value as Iterable<BattleStroke>)
            .every((element) => strokes.map((e) => e.id).contains(element.id));

    if (strokes.isEmpty || actionAlreadyQueued) {
      return;
    }
    _client?.removeMultipleStrokes(
      MultipleStrokesMessage(
        strokes: strokes.map((e) => e.toMessage()),
      ),
    );

    if (!recordAction) {
      return;
    }

    final action = UndoableAction<Iterable<BattleStroke>>()
      ..action = UndoAction.remove
      ..value = strokes;

    _commitAction(action);
  }

  void switchGrid(BattleGrid grid) {
    _client?.switchGrid(grid.toMessage());
  }

  void undo() {
    if (_actions.isEmpty) {
      return;
    }

    final lastAction = _actions.last;
    switch (lastAction.action) {
      case UndoAction.remove:
        // Add back the value
        if (lastAction.value is BattleToken) {
          addToken(lastAction.value, recordAction: false);
        } else if (lastAction.value is BattleStroke) {
          addStroke(lastAction.value, recordAction: false);
        } else if (lastAction.value is Iterable<BattleStroke>) {
          (lastAction.value as Iterable<BattleStroke>)
              .forEach((element) => addStroke(element, recordAction: false));
        }
        break;
      case UndoAction.add:
        // Remove the token we didn't mean to add
        if (lastAction.value is BattleToken) {
          removeToken(lastAction.value, recordAction: false);
        } else if (lastAction.value is BattleStroke) {
          removeStroke(lastAction.value, recordAction: false);
        } else if (lastAction.value is Iterable<BattleStroke>) {
          (lastAction.value as Iterable<BattleStroke>)
              .forEach((element) => removeStroke(element, recordAction: false));
        }
        break;
      case UndoAction.update:
        if (lastAction.value is BattleToken) {
          updateToken(null, lastAction.previousValue, recordAction: false);
        }
        break;
      default:
        return;
    }

    _actions.remove(lastAction);
    _redoActions.insert(0, lastAction);
  }

  void _commitAction(UndoableAction action) {
    _actions.add(action);
    _redoActions.clear();
  }

  void _clearActions() {
    _actions.clear();
    _redoActions.clear();
  }

  void redo() {
    if (_redoActions.isEmpty) {
      return;
    }

    final actionToRedo = _redoActions.first;
    switch (actionToRedo.action) {
      case UndoAction.remove:
        if (actionToRedo.value is BattleToken) {
          removeToken(actionToRedo.value, recordAction: false);
        } else if (actionToRedo.value is BattleStroke) {
          removeStroke(actionToRedo.value, recordAction: false);
        }
        if (actionToRedo.value is Iterable<BattleStroke>) {
          (actionToRedo.value as Iterable<BattleStroke>)
              .forEach((stroke) => removeStroke(stroke, recordAction: false));
        }
        break;
      case UndoAction.add:
        // Remove the token we didn't mean to add
        if (actionToRedo.value is BattleToken) {
          addToken(actionToRedo.value, recordAction: false);
        } else if (actionToRedo.value is BattleStroke) {
          addStroke(actionToRedo.value, recordAction: false);
        }
        if (actionToRedo.value is Iterable<BattleStroke>) {
          (actionToRedo.value as Iterable<BattleStroke>)
              .forEach((stroke) => addStroke(stroke, recordAction: false));
        }
        break;
      case UndoAction.update:
        if (actionToRedo.value is BattleToken) {
          updateToken(null, actionToRedo.value, recordAction: false);
        }
        break;
      default:
        return;
    }

    _actions.add(actionToRedo);
    _redoActions.remove(actionToRedo);
  }
}

class UndoableAction<T> {
  UndoAction action;
  T previousValue;
  T value;
}

enum UndoAction { add, remove, update }
