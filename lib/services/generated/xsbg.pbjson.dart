///
//  Generated code. Do not modify.
//  source: xsbg.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const TokenMessage$json = const {
  '1': 'TokenMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'x', '3': 2, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 5, '10': 'y'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'icon', '3': 5, '4': 1, '5': 5, '10': 'icon'},
    const {'1': 'hexColor', '3': 6, '4': 1, '5': 9, '10': 'hexColor'},
    const {'1': 'attributes', '3': 7, '4': 3, '5': 11, '6': '.xsbg.TokenAttributeMessage', '10': 'attributes'},
  ],
};

const TokenAttributeMessage$json = const {
  '1': 'TokenAttributeMessage',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

const StrokeMessage$json = const {
  '1': 'StrokeMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'color', '3': 2, '4': 1, '5': 5, '10': 'color'},
    const {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'temporary', '3': 5, '4': 1, '5': 8, '10': 'temporary'},
    const {'1': 'points', '3': 6, '4': 3, '5': 11, '6': '.xsbg.StrokePointMessage', '10': 'points'},
  ],
};

const StrokePointMessage$json = const {
  '1': 'StrokePointMessage',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
  ],
};

const GridState$json = const {
  '1': 'GridState',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'width', '3': 2, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 3, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'id', '3': 4, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'tokens', '3': 5, '4': 3, '5': 11, '6': '.xsbg.TokenMessage', '10': 'tokens'},
    const {'1': 'strokes', '3': 6, '4': 3, '5': 11, '6': '.xsbg.StrokeMessage', '10': 'strokes'},
  ],
};

const GridUpdateMessage$json = const {
  '1': 'GridUpdateMessage',
};

const MultipleStrokesMessage$json = const {
  '1': 'MultipleStrokesMessage',
  '2': const [
    const {'1': 'strokes', '3': 1, '4': 3, '5': 11, '6': '.xsbg.StrokeMessage', '10': 'strokes'},
  ],
};

const MultipleTokensMessage$json = const {
  '1': 'MultipleTokensMessage',
  '2': const [
    const {'1': 'tokens', '3': 1, '4': 3, '5': 11, '6': '.xsbg.TokenMessage', '10': 'tokens'},
  ],
};

