import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xsbg/models/battle_grid.dart';
import 'package:xsbg/state/lobby_state.dart';
import 'package:xsbg/widgets/game_lobby.dart';
import 'package:uuid/uuid.dart';

class JoinLobby extends StatelessWidget {
  void _createLobby(BuildContext context) {
    final lobbyState = context.read<LobbyState>();
    final grid = BattleGrid(
      DateTime.now().toString(),
      width: 20,
      height: 20,
      id: Uuid().v4(),
    );
    lobbyState.initializeLobby(grid);

    final lobby = GameLobby();
    final route = MaterialPageRoute(builder: (_) => lobby);
    Navigator.of(context).push(route);
  }

  void _scanQr(BuildContext context) async {
    // final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //   '0xfffdd',
    //   'Cancel',
    //   false,
    //   ScanMode.QR,
    // );
    // print (barcodeScanRes);

    final ipAddress = '192.168.50.188';
    final port = 1337;
    final uuid = 'todo';

    final lobbyState = context.read<LobbyState>();
    lobbyState.joinLobby(ipAddress, port, uuid);

    final lobby = GameLobby();
    final route = MaterialPageRoute(builder: (_) => lobby);
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final goIcon = FaIcon(FontAwesomeIcons.bolt);
    return Scaffold(
      appBar: AppBar(title: Text('Join Lobby')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Scan the QR Code to join a Lobby'),
          Center(
            child: Container(
              height: 256,
              width: 256,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                color: Colors.blue,
              ),
              child: InkWell(
                child: Icon(Icons.qr_code, size: 64.0),
                onTap: () => _scanQr(context),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Or select '), goIcon, Text(' to create one.')],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: goIcon,
        onPressed: () => _createLobby(context),
      ),
    );
  }
}
