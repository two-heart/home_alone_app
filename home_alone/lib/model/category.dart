import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(nullable: false)
class Category {
  Category({
    this.id,
    this.name,
  });
  final String id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  static List<Category> fromJsonList(List<dynamic> json) =>
      json.map((item) => _$CategoryFromJson(item)).toList();

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  bool operator ==(other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
