import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

ClientChannelBase createChannel(String host, int port) {
  return ClientChannel(
    host,
    port: port,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );
}
