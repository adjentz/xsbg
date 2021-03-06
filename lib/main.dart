import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:xsbg/models/battle_stroke.dart';
import 'package:xsbg/models/battle_token.dart';
import 'package:xsbg/models/battle_token_attribute.dart';
import 'package:xsbg/state/battle_grid_state.dart';
import 'package:xsbg/state/lobby_state.dart';
import 'package:xsbg/widgets/join_lobby.dart';
import 'package:xsbg/state/user_state.dart';

import 'models/battle_grid.dart';

void initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BattleGridAdapter());
  Hive.registerAdapter(BattleTokenAdapter());
  Hive.registerAdapter(BattleTokenAttributeAdapter());
  Hive.registerAdapter(BattleStrokeAdapter());
  Hive.registerAdapter(PointAdapter());
}

void main() {
  initHive();
  runApp(MultiProvider(
    providers: [
      Provider<UserState>(create: (_) => UserState()),
      ChangeNotifierProvider<LobbyState>(create: (_) => LobbyState()),
      ChangeNotifierProxyProvider<LobbyState, BattleGridState>(
        create: (_) => BattleGridState(null),
        update: (_, lobby, currentGridState) =>
            currentGridState..lobbyUpdated(lobby),
      )
    ],
    child: SuperSimpleBattleGrid(),
  ));
}

class SuperSimpleBattleGrid extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Simple Battle Grid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Colors.orange
      ),
      home: JoinLobby(),
    );
  }
}
