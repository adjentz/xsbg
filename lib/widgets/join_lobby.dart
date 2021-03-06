import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:xsbg/models/battle_grid.dart';
import 'package:xsbg/state/lobby_state.dart';
import 'package:xsbg/widgets/game_lobby.dart';
import 'package:uuid/uuid.dart';

class JoinLobby extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JoinLobbyState();
}

class _JoinLobbyState extends State<JoinLobby> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController _qrController;
  bool _scanning = false;

  void _createLobby(BuildContext context) async {
    final lobbyState = context.read<LobbyState>();
    final grid = BattleGrid(
      DateTime.now().toString(),
      width: 20,
      height: 20,
      id: Uuid().v4(),
      entities: [],
      strokes: [],
    );
    lobbyState.initializeLobby(grid);

    final lobby = GameLobby();
    final route = MaterialPageRoute(builder: (_) => lobby);
    Navigator.of(context).push(route);
  }

  @override
  void dispose() {
    super.dispose();
    _qrController?.dispose();
    _qrController = null;
  }

  Future<void> _scanQr() async {
    final cameraAccess = await Permission.camera.request();
    if (!cameraAccess.isGranted) {
      return;
    }

    if (_qrController != null) {
      await _qrController.flipCamera();
      return;
    }

    setState(() {
      _scanning = !_scanning;
    });
  }

  Widget _scanWidget() {
    if (!_scanning) {
      return Icon(Icons.qr_code, size: 64);
    }

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 150),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      _qrController = controller;
    });

    Uri uri = await controller.scannedDataStream
        .where((event) => Uri.tryParse(event.code) != null)
        .map((event) => Uri.parse(event.code))
        .take(1)
        .first;

    setState(() {
      _scanning = false;
      _qrController.dispose();
      _qrController = null;
    });

    context.read<LobbyState>().joinLobby(
          uri.host,
          uri.port,
          uri.queryParameters['hostId'],
        );
    final lobby = GameLobby();
    final route = MaterialPageRoute(builder: (_) => lobby);
    Navigator.of(context).push(route);
  }

  Widget _body() {
    final goIcon = FaIcon(FontAwesomeIcons.bolt);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Tap to scan a QR Code to join an existing Lobby\nThat\'s on  the same Wi-Fi as you.'),
        Center(
          child: Container(
            height: 256,
            width: 256,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              color: Colors.blue,
            ),
            child: InkWell(onTap: _scanQr, child: _scanWidget()),
          ),
        ),
        Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Text('Or select '),
            goIcon,
            Text(' to create one.'),
            Text(
              ' Only devices on the same Wi-Fi as you will be able to join.',
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final goIcon = FaIcon(FontAwesomeIcons.bolt);
    return Scaffold(
      appBar: AppBar(title: Text('Join Lobby')),
      body: Container(
        child: _body(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/parchment.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: goIcon,
        onPressed: () => _createLobby(context),
      ),
    );
  }
}
