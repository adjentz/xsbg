import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:xsbg/models/battle_grid.dart';
import 'package:xsbg/services/battle_grid_server.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:uuid/uuid.dart';
import 'package:qr/qr.dart';

class LobbyState with ChangeNotifier {
  bool hosting = false;
  bool shutdown = false;
  String ipAddress;
  int port;
  String uuid;

  BattleGridServer _gridService;
  QrCode qrCode;
  grpc.Server _grpcServer;

  bool get readyToConnect =>
      !shutdown && (ipAddress?.isNotEmpty ?? false) && port > 0;

  void initializeLobby(BattleGrid grid) {
    _gridService = BattleGridServer(grid);

    _grpcServer = grpc.Server([_gridService]);
    port = 1337;
    ipAddress = 'localhost';
    uuid = Uuid().v4();

    _grpcServer.serve(port: port);

    hosting = true;
    shutdown = false;
    // _makeQr();

    notifyListeners();
  }

  void _makeQr() async {
    final data = '$ipAddress:$port;$uuid';
    final result = await compute(this._computeQr, data);
    this.qrCode = result;
  }

  QrCode _computeQr(String data) {
    final qrCode = new QrCode(4, QrErrorCorrectLevel.L);
    qrCode.addData(data);
    qrCode.make();

    return qrCode;
  }

  void joinLobby(String ipAddress, int port, String uuid) {
    hosting = false;
    this.ipAddress = ipAddress;
    this.port = port;
    this.uuid = uuid;
    shutdown = false;

    // _makeQr();

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    endSession();
  }

  void endSession() {
    hosting = false;
    ipAddress = null;
    port = 0;
    uuid = null;
    qrCode = null;
    shutdown = true;

    notifyListeners();
  }

  void closeServer() {
    _grpcServer?.shutdown();
  }
}
