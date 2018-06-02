import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account extends Object with _$AccountSerializerMixin {
  final String priv;
  final String pub;

  Account({this.priv, this.pub});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
