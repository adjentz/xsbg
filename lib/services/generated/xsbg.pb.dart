///
//  Generated code. Do not modify.
//  source: xsbg.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class TokenMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hexColor', protoName: 'hexColor')
    ..pc<TokenAttributeMessage>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attributes', $pb.PbFieldType.PM, subBuilder: TokenAttributeMessage.create)
    ..hasRequiredFields = false
  ;

  TokenMessage._() : super();
  factory TokenMessage({
    $core.String id,
    $core.int x,
    $core.int y,
    $core.String name,
    $core.int icon,
    $core.String hexColor,
    $core.Iterable<TokenAttributeMessage> attributes,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (name != null) {
      _result.name = name;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (hexColor != null) {
      _result.hexColor = hexColor;
    }
    if (attributes != null) {
      _result.attributes.addAll(attributes);
    }
    return _result;
  }
  factory TokenMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenMessage clone() => TokenMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenMessage copyWith(void Function(TokenMessage) updates) => super.copyWith((message) => updates(message as TokenMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenMessage create() => TokenMessage._();
  TokenMessage createEmptyInstance() => create();
  static $pb.PbList<TokenMessage> createRepeated() => $pb.PbList<TokenMessage>();
  @$core.pragma('dart2js:noInline')
  static TokenMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenMessage>(create);
  static TokenMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get x => $_getIZ(1);
  @$pb.TagNumber(2)
  set x($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get y => $_getIZ(2);
  @$pb.TagNumber(3)
  set y($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get icon => $_getIZ(4);
  @$pb.TagNumber(5)
  set icon($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearIcon() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get hexColor => $_getSZ(5);
  @$pb.TagNumber(6)
  set hexColor($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHexColor() => $_has(5);
  @$pb.TagNumber(6)
  void clearHexColor() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<TokenAttributeMessage> get attributes => $_getList(6);
}

class TokenAttributeMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TokenAttributeMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  TokenAttributeMessage._() : super();
  factory TokenAttributeMessage({
    $core.String name,
    $core.String value,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory TokenAttributeMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TokenAttributeMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TokenAttributeMessage clone() => TokenAttributeMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TokenAttributeMessage copyWith(void Function(TokenAttributeMessage) updates) => super.copyWith((message) => updates(message as TokenAttributeMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TokenAttributeMessage create() => TokenAttributeMessage._();
  TokenAttributeMessage createEmptyInstance() => create();
  static $pb.PbList<TokenAttributeMessage> createRepeated() => $pb.PbList<TokenAttributeMessage>();
  @$core.pragma('dart2js:noInline')
  static TokenAttributeMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TokenAttributeMessage>(create);
  static TokenAttributeMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class StrokeMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StrokeMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'temporary')
    ..pc<StrokePointMessage>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'points', $pb.PbFieldType.PM, subBuilder: StrokePointMessage.create)
    ..hasRequiredFields = false
  ;

  StrokeMessage._() : super();
  factory StrokeMessage({
    $core.String id,
    $core.int color,
    $core.int width,
    $fixnum.Int64 timestamp,
    $core.bool temporary,
    $core.Iterable<StrokePointMessage> points,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (color != null) {
      _result.color = color;
    }
    if (width != null) {
      _result.width = width;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (temporary != null) {
      _result.temporary = temporary;
    }
    if (points != null) {
      _result.points.addAll(points);
    }
    return _result;
  }
  factory StrokeMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StrokeMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StrokeMessage clone() => StrokeMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StrokeMessage copyWith(void Function(StrokeMessage) updates) => super.copyWith((message) => updates(message as StrokeMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StrokeMessage create() => StrokeMessage._();
  StrokeMessage createEmptyInstance() => create();
  static $pb.PbList<StrokeMessage> createRepeated() => $pb.PbList<StrokeMessage>();
  @$core.pragma('dart2js:noInline')
  static StrokeMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StrokeMessage>(create);
  static StrokeMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get color => $_getIZ(1);
  @$pb.TagNumber(2)
  set color($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearColor() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get width => $_getIZ(2);
  @$pb.TagNumber(3)
  set width($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get temporary => $_getBF(4);
  @$pb.TagNumber(5)
  set temporary($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTemporary() => $_has(4);
  @$pb.TagNumber(5)
  void clearTemporary() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<StrokePointMessage> get points => $_getList(5);
}

class StrokePointMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StrokePointMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  StrokePointMessage._() : super();
  factory StrokePointMessage({
    $core.double x,
    $core.double y,
  }) {
    final _result = create();
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory StrokePointMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StrokePointMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StrokePointMessage clone() => StrokePointMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StrokePointMessage copyWith(void Function(StrokePointMessage) updates) => super.copyWith((message) => updates(message as StrokePointMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StrokePointMessage create() => StrokePointMessage._();
  StrokePointMessage createEmptyInstance() => create();
  static $pb.PbList<StrokePointMessage> createRepeated() => $pb.PbList<StrokePointMessage>();
  @$core.pragma('dart2js:noInline')
  static StrokePointMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StrokePointMessage>(create);
  static StrokePointMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class GridState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GridState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..pc<TokenMessage>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokens', $pb.PbFieldType.PM, subBuilder: TokenMessage.create)
    ..pc<StrokeMessage>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'strokes', $pb.PbFieldType.PM, subBuilder: StrokeMessage.create)
    ..hasRequiredFields = false
  ;

  GridState._() : super();
  factory GridState({
    $core.String name,
    $core.int width,
    $core.int height,
    $core.String id,
    $core.Iterable<TokenMessage> tokens,
    $core.Iterable<StrokeMessage> strokes,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (id != null) {
      _result.id = id;
    }
    if (tokens != null) {
      _result.tokens.addAll(tokens);
    }
    if (strokes != null) {
      _result.strokes.addAll(strokes);
    }
    return _result;
  }
  factory GridState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GridState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GridState clone() => GridState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GridState copyWith(void Function(GridState) updates) => super.copyWith((message) => updates(message as GridState)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GridState create() => GridState._();
  GridState createEmptyInstance() => create();
  static $pb.PbList<GridState> createRepeated() => $pb.PbList<GridState>();
  @$core.pragma('dart2js:noInline')
  static GridState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GridState>(create);
  static GridState _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get width => $_getIZ(1);
  @$pb.TagNumber(2)
  set width($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get height => $_getIZ(2);
  @$pb.TagNumber(3)
  set height($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get id => $_getSZ(3);
  @$pb.TagNumber(4)
  set id($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<TokenMessage> get tokens => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<StrokeMessage> get strokes => $_getList(5);
}

class GridUpdateMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GridUpdateMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GridUpdateMessage._() : super();
  factory GridUpdateMessage() => create();
  factory GridUpdateMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GridUpdateMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GridUpdateMessage clone() => GridUpdateMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GridUpdateMessage copyWith(void Function(GridUpdateMessage) updates) => super.copyWith((message) => updates(message as GridUpdateMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GridUpdateMessage create() => GridUpdateMessage._();
  GridUpdateMessage createEmptyInstance() => create();
  static $pb.PbList<GridUpdateMessage> createRepeated() => $pb.PbList<GridUpdateMessage>();
  @$core.pragma('dart2js:noInline')
  static GridUpdateMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GridUpdateMessage>(create);
  static GridUpdateMessage _defaultInstance;
}

class MultipleStrokesMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MultipleStrokesMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..pc<StrokeMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'strokes', $pb.PbFieldType.PM, subBuilder: StrokeMessage.create)
    ..hasRequiredFields = false
  ;

  MultipleStrokesMessage._() : super();
  factory MultipleStrokesMessage({
    $core.Iterable<StrokeMessage> strokes,
  }) {
    final _result = create();
    if (strokes != null) {
      _result.strokes.addAll(strokes);
    }
    return _result;
  }
  factory MultipleStrokesMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MultipleStrokesMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MultipleStrokesMessage clone() => MultipleStrokesMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MultipleStrokesMessage copyWith(void Function(MultipleStrokesMessage) updates) => super.copyWith((message) => updates(message as MultipleStrokesMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MultipleStrokesMessage create() => MultipleStrokesMessage._();
  MultipleStrokesMessage createEmptyInstance() => create();
  static $pb.PbList<MultipleStrokesMessage> createRepeated() => $pb.PbList<MultipleStrokesMessage>();
  @$core.pragma('dart2js:noInline')
  static MultipleStrokesMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MultipleStrokesMessage>(create);
  static MultipleStrokesMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<StrokeMessage> get strokes => $_getList(0);
}

class MultipleTokensMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MultipleTokensMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xsbg'), createEmptyInstance: create)
    ..pc<TokenMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tokens', $pb.PbFieldType.PM, subBuilder: TokenMessage.create)
    ..hasRequiredFields = false
  ;

  MultipleTokensMessage._() : super();
  factory MultipleTokensMessage({
    $core.Iterable<TokenMessage> tokens,
  }) {
    final _result = create();
    if (tokens != null) {
      _result.tokens.addAll(tokens);
    }
    return _result;
  }
  factory MultipleTokensMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MultipleTokensMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MultipleTokensMessage clone() => MultipleTokensMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MultipleTokensMessage copyWith(void Function(MultipleTokensMessage) updates) => super.copyWith((message) => updates(message as MultipleTokensMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MultipleTokensMessage create() => MultipleTokensMessage._();
  MultipleTokensMessage createEmptyInstance() => create();
  static $pb.PbList<MultipleTokensMessage> createRepeated() => $pb.PbList<MultipleTokensMessage>();
  @$core.pragma('dart2js:noInline')
  static MultipleTokensMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MultipleTokensMessage>(create);
  static MultipleTokensMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TokenMessage> get tokens => $_getList(0);
}

