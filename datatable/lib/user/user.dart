import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? username;
  int? age;

  User({this.id, this.username, this.age});

  @override
  String toString() => 'User(id: $id, username: $username, age: $age)';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
