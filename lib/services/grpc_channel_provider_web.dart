import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart' as webGrpc;

ClientChannelBase createChannel(String host, int port) {
  final channel = webGrpc.GrpcWebClientChannel.xhr(
    Uri.parse('http://$host:$port'),
  );
  return channel;
}
