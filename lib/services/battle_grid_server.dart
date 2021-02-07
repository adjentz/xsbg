import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:xsbg/models/battle_grid.dart';

import 'generated/xsbg.pbgrpc.dart';
import 'package:rxdart/rxdart.dart';
import '../state/message_extensions.dart';

class BattleGridServer extends BattleGridServiceBase {
  final _gridUpdates = BehaviorSubject<GridState>();

  BattleGrid grid;
  BattleGridServer(this.grid) {
    _gridUpdates.add(grid.toMessage());
  }

  @override
  Future<StrokeMessage> addStroke(ServiceCall call, StrokeMessage request) {
    grid.strokes.add(request.toDomain());
    _gridUpdates.add(grid.toMessage());

    return Future.value(request);
  }

  @override
  Future<TokenMessage> addToken(ServiceCall call, TokenMessage request) {
    grid.entities.add(request.toDomain());
    _gridUpdates.add(grid.toMessage());

    return Future.value(request);
  }

  @override
  Stream<GridState> gridUpdates(ServiceCall call, GridUpdateMessage request) {
    print('New Grid Listener');
    return _gridUpdates.stream;
  }

  @override
  Future<StrokeMessage> removeStroke(ServiceCall call, StrokeMessage request) {
    grid.strokes.removeWhere((element) => element.id == request.id);
    _gridUpdates.add(grid.toMessage());
    return Future.value(request);
  }

  @override
  Future<TokenMessage> removeToken(ServiceCall call, TokenMessage request) {
    grid.entities.removeWhere((element) => element.id == request.id);
    _gridUpdates.add(grid.toMessage());
    return Future.value(request);
  }

  @override
  Future<MultipleStrokesMessage> removeMultipleStrokes(
      ServiceCall call, MultipleStrokesMessage request) {
    grid.strokes.removeWhere(
      (element) => request.strokes.map((e) => e.id).contains(element.id),
    );

    _gridUpdates.add(grid.toMessage());
    return Future.value(request);
  }

  @override
  Future<MultipleTokensMessage> removeMultipleTokens(
      ServiceCall call, MultipleTokensMessage request) {
    grid.entities.removeWhere(
      (element) => request.tokens.map((e) => e.id).contains(element.id),
    );

    _gridUpdates.add(grid.toMessage());
    return Future.value(request);
  }

  @override
  Future<TokenMessage> updateToken(ServiceCall call, TokenMessage request) {
    grid.entities.removeWhere((element) => element.id == request.id);
    grid.entities.add(request.toDomain());

    _gridUpdates.add(grid.toMessage());
    return Future.value(request);
  }

  @override
  Future<GridState> switchGrid(ServiceCall call, GridState request) {
    grid = request.toDomain();
    final message = grid.toMessage();
    _gridUpdates.add(message);
    return Future.value(message);
  }

  @override
  Future<GridUpdateMessage> closeSession(
      ServiceCall call, GridUpdateMessage request) {
    _gridUpdates.close();

    return Future.value(request);
  }
}
