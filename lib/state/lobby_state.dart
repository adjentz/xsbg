import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:xsbg/models/battle_grid.dart';
import 'package:xsbg/services/battle_grid_server.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:uuid/uuid.dart';
import 'package:qr/qr.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart' as wifi;

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

  void initializeLobby(BattleGrid grid) async {
    _gridService = BattleGridServer(grid);

    _grpcServer = grpc.Server([_gridService]);
    port = 1337;
    ipAddress = await wifi.WifiInfo().getWifiIP();
    uuid = Uuid().v4();

    _grpcServer.serve(port: port);

    hosting = true;
    shutdown = false;
    _makeQr();

    notifyListeners();
  }

  void _makeQr() async {
    final data = 'grpc://$ipAddress:$port?hostId=$uuid';
    this.qrCode = new QrCode(4, QrErrorCorrectLevel.L);
    qrCode.addData(data);
    qrCode.make();
  }

  void joinLobby(String ipAddress, int port, String uuid) {
    hosting = false;
    this.ipAddress = ipAddress;
    this.port = port;
    this.uuid = uuid;
    shutdown = false;

    _makeQr();

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    endSession();
  }

  void endSession() {
    ipAddress = null;
    port = 0;
    uuid = null;
    qrCode = null;
    shutdown = true;

    notifyListeners();
  }

  void closeServer() {
    _grpcServer?.shutdown();
    hosting = false;
  }
}
