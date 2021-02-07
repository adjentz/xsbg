///
//  Generated code. Do not modify.
//  source: xsbg.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'xsbg.pb.dart' as $0;
export 'xsbg.pb.dart';

class BattleGridServiceClient extends $grpc.Client {
  static final _$addStroke =
      $grpc.ClientMethod<$0.StrokeMessage, $0.StrokeMessage>(
          '/xsbg.BattleGridService/AddStroke',
          ($0.StrokeMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StrokeMessage.fromBuffer(value));
  static final _$removeStroke =
      $grpc.ClientMethod<$0.StrokeMessage, $0.StrokeMessage>(
          '/xsbg.BattleGridService/RemoveStroke',
          ($0.StrokeMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StrokeMessage.fromBuffer(value));
  static final _$removeMultipleStrokes =
      $grpc.ClientMethod<$0.MultipleStrokesMessage, $0.MultipleStrokesMessage>(
          '/xsbg.BattleGridService/RemoveMultipleStrokes',
          ($0.MultipleStrokesMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MultipleStrokesMessage.fromBuffer(value));
  static final _$addToken =
      $grpc.ClientMethod<$0.TokenMessage, $0.TokenMessage>(
          '/xsbg.BattleGridService/AddToken',
          ($0.TokenMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.TokenMessage.fromBuffer(value));
  static final _$removeToken =
      $grpc.ClientMethod<$0.TokenMessage, $0.TokenMessage>(
          '/xsbg.BattleGridService/RemoveToken',
          ($0.TokenMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.TokenMessage.fromBuffer(value));
  static final _$updateToken =
      $grpc.ClientMethod<$0.TokenMessage, $0.TokenMessage>(
          '/xsbg.BattleGridService/UpdateToken',
          ($0.TokenMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.TokenMessage.fromBuffer(value));
  static final _$removeMultipleTokens =
      $grpc.ClientMethod<$0.MultipleTokensMessage, $0.MultipleTokensMessage>(
          '/xsbg.BattleGridService/RemoveMultipleTokens',
          ($0.MultipleTokensMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MultipleTokensMessage.fromBuffer(value));
  static final _$gridUpdates =
      $grpc.ClientMethod<$0.GridUpdateMessage, $0.GridState>(
          '/xsbg.BattleGridService/GridUpdates',
          ($0.GridUpdateMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.GridState.fromBuffer(value));
  static final _$switchGrid = $grpc.ClientMethod<$0.GridState, $0.GridState>(
      '/xsbg.BattleGridService/SwitchGrid',
      ($0.GridState value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GridState.fromBuffer(value));
  static final _$closeSession =
      $grpc.ClientMethod<$0.GridUpdateMessage, $0.GridUpdateMessage>(
          '/xsbg.BattleGridService/CloseSession',
          ($0.GridUpdateMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GridUpdateMessage.fromBuffer(value));

  BattleGridServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.StrokeMessage> addStroke($0.StrokeMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$addStroke, request, options: options);
  }

  $grpc.ResponseFuture<$0.StrokeMessage> removeStroke($0.StrokeMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeStroke, request, options: options);
  }

  $grpc.ResponseFuture<$0.MultipleStrokesMessage> removeMultipleStrokes(
      $0.MultipleStrokesMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeMultipleStrokes, request, options: options);
  }

  $grpc.ResponseFuture<$0.TokenMessage> addToken($0.TokenMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$addToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.TokenMessage> removeToken($0.TokenMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.TokenMessage> updateToken($0.TokenMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$updateToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.MultipleTokensMessage> removeMultipleTokens(
      $0.MultipleTokensMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeMultipleTokens, request, options: options);
  }

  $grpc.ResponseStream<$0.GridState> gridUpdates($0.GridUpdateMessage request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$gridUpdates, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.GridState> switchGrid($0.GridState request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$switchGrid, request, options: options);
  }

  $grpc.ResponseFuture<$0.GridUpdateMessage> closeSession(
      $0.GridUpdateMessage request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$closeSession, request, options: options);
  }
}

abstract class BattleGridServiceBase extends $grpc.Service {
  $core.String get $name => 'xsbg.BattleGridService';

  BattleGridServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StrokeMessage, $0.StrokeMessage>(
        'AddStroke',
        addStroke_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StrokeMessage.fromBuffer(value),
        ($0.StrokeMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StrokeMessage, $0.StrokeMessage>(
        'RemoveStroke',
        removeStroke_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StrokeMessage.fromBuffer(value),
        ($0.StrokeMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MultipleStrokesMessage,
            $0.MultipleStrokesMessage>(
        'RemoveMultipleStrokes',
        removeMultipleStrokes_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MultipleStrokesMessage.fromBuffer(value),
        ($0.MultipleStrokesMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TokenMessage, $0.TokenMessage>(
        'AddToken',
        addToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TokenMessage.fromBuffer(value),
        ($0.TokenMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TokenMessage, $0.TokenMessage>(
        'RemoveToken',
        removeToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TokenMessage.fromBuffer(value),
        ($0.TokenMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TokenMessage, $0.TokenMessage>(
        'UpdateToken',
        updateToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TokenMessage.fromBuffer(value),
        ($0.TokenMessage value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.MultipleTokensMessage, $0.MultipleTokensMessage>(
            'RemoveMultipleTokens',
            removeMultipleTokens_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.MultipleTokensMessage.fromBuffer(value),
            ($0.MultipleTokensMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GridUpdateMessage, $0.GridState>(
        'GridUpdates',
        gridUpdates_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GridUpdateMessage.fromBuffer(value),
        ($0.GridState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GridState, $0.GridState>(
        'SwitchGrid',
        switchGrid_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GridState.fromBuffer(value),
        ($0.GridState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GridUpdateMessage, $0.GridUpdateMessage>(
        'CloseSession',
        closeSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GridUpdateMessage.fromBuffer(value),
        ($0.GridUpdateMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.StrokeMessage> addStroke_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StrokeMessage> request) async {
    return addStroke(call, await request);
  }

  $async.Future<$0.StrokeMessage> removeStroke_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StrokeMessage> request) async {
    return removeStroke(call, await request);
  }

  $async.Future<$0.MultipleStrokesMessage> removeMultipleStrokes_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MultipleStrokesMessage> request) async {
    return removeMultipleStrokes(call, await request);
  }

  $async.Future<$0.TokenMessage> addToken_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TokenMessage> request) async {
    return addToken(call, await request);
  }

  $async.Future<$0.TokenMessage> removeToken_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TokenMessage> request) async {
    return removeToken(call, await request);
  }

  $async.Future<$0.TokenMessage> updateToken_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TokenMessage> request) async {
    return updateToken(call, await request);
  }

  $async.Future<$0.MultipleTokensMessage> removeMultipleTokens_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MultipleTokensMessage> request) async {
    return removeMultipleTokens(call, await request);
  }

  $async.Stream<$0.GridState> gridUpdates_Pre($grpc.ServiceCall call,
      $async.Future<$0.GridUpdateMessage> request) async* {
    yield* gridUpdates(call, await request);
  }

  $async.Future<$0.GridState> switchGrid_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GridState> request) async {
    return switchGrid(call, await request);
  }

  $async.Future<$0.GridUpdateMessage> closeSession_Pre($grpc.ServiceCall call,
      $async.Future<$0.GridUpdateMessage> request) async {
    return closeSession(call, await request);
  }

  $async.Future<$0.StrokeMessage> addStroke(
      $grpc.ServiceCall call, $0.StrokeMessage request);
  $async.Future<$0.StrokeMessage> removeStroke(
      $grpc.ServiceCall call, $0.StrokeMessage request);
  $async.Future<$0.MultipleStrokesMessage> removeMultipleStrokes(
      $grpc.ServiceCall call, $0.MultipleStrokesMessage request);
  $async.Future<$0.TokenMessage> addToken(
      $grpc.ServiceCall call, $0.TokenMessage request);
  $async.Future<$0.TokenMessage> removeToken(
      $grpc.ServiceCall call, $0.TokenMessage request);
  $async.Future<$0.TokenMessage> updateToken(
      $grpc.ServiceCall call, $0.TokenMessage request);
  $async.Future<$0.MultipleTokensMessage> removeMultipleTokens(
      $grpc.ServiceCall call, $0.MultipleTokensMessage request);
  $async.Stream<$0.GridState> gridUpdates(
      $grpc.ServiceCall call, $0.GridUpdateMessage request);
  $async.Future<$0.GridState> switchGrid(
      $grpc.ServiceCall call, $0.GridState request);
  $async.Future<$0.GridUpdateMessage> closeSession(
      $grpc.ServiceCall call, $0.GridUpdateMessage request);
}
