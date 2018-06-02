// Copyright (c) 2018, the Dart project authors.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map json) {
  return $checkedNew('Account', json, () {
    var val = new Account(
        priv: $checkedConvert(json, 'priv', (v) => v as String),
        pub: $checkedConvert(json, 'pub', (v) => v as String));
    return val;
  });
}

abstract class _$AccountSerializerMixin {
  String get priv;
  String get pub;
  Map<String, dynamic> toJson() => new _$AccountJsonMapWrapper(this);
}

class _$AccountJsonMapWrapper extends $JsonMapWrapper {
  final _$AccountSerializerMixin _v;
  _$AccountJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const ['priv', 'pub'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'priv':
          return _v.priv;
        case 'pub':
          return _v.pub;
      }
    }
    return null;
  }
}
