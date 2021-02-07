import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xsbg/state/lobby_state.dart';

class LobbyCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final qrCode = context.select((LobbyState lobby) => lobby.qrCode);
    if (qrCode == null) {
      return Text('No QR Code');
    }

    final size = 20.0;
    return Column(children: [
      for (int x = 0; x < qrCode.moduleCount; x++)
        Row(
          children: [
            for (int y = 0; y < qrCode.moduleCount; y++)
              Container(
                width: size,
                height: size,
                color: qrCode.isDark(y, x) ? Colors.black : Colors.white,
              ),
          ],
        ),
    ]);
  }
}
