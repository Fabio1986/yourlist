import 'package:uuid/uuid.dart';
import 'dart:collection';
import 'dart:convert';

final uuid = Uuid();

class CategoryMarket {
  final String name;
  final String id;

  String get _name {
    return name;
  }

  CategoryMarket({required this.name}) : id = name == 'ALL' ? 'all' : uuid.v4();
  CategoryMarket.fromJsonData({required this.name, required this.id});

  static Map<String, dynamic> toMap(CategoryMarket categoryMarket) => {
        'id': categoryMarket.id,
        'name': categoryMarket.name,
      };

  factory CategoryMarket.fromJson(Map<String, dynamic> jsonData) {
    return CategoryMarket.fromJsonData(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
  static String encode(List<CategoryMarket> categories) => json.encode(
        categories
            .map<Map<String, dynamic>>(
                (categoryMarket) => CategoryMarket.toMap(categoryMarket))
            .toList(),
      );

  static List<CategoryMarket> decode(String categories) =>
      (json.decode(categories) as List<dynamic>)
          .map<CategoryMarket>((item) => CategoryMarket.fromJson(item))
          .toList();
}
