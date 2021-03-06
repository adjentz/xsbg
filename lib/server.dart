import 'package:xsbg/services/battle_grid_server.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'models/battle_grid.dart';

void main() async {
  final grid = BattleGrid(
    'quick',
    width: 20,
    height: 20,
    entities: [],
    strokes: [],
  );
  final _gridService = BattleGridServer(grid);

  final _grpcServer = grpc.Server([_gridService]);
  final port = 1337;
  final ipAddress = 'localhost';

  print('serving...');
  print('port: $port');
  await _grpcServer.serve(port: port);
  print('now serving');
}
