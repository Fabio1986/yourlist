import 'dart:convert';

class Item {
  final String name;
  bool isDone;
  final String categoryId;

  Item({required this.name, this.isDone = false, required this.categoryId});

  void toggleDone() {
    isDone = !isDone;
  }

  static Map<String, dynamic> toMap(Item item) =>
      {'categoryId': item.categoryId, 'name': item.name, 'isDone': item.isDone};

  factory Item.fromJson(Map<String, dynamic> jsonData) {
    return Item(
      categoryId: jsonData['categoryId'],
      name: jsonData['name'],
      isDone: jsonData['isDone'],
    );
  }
  static String encode(List<Item> items) => json.encode(
        items.map<Map<String, dynamic>>((item) => Item.toMap(item)).toList(),
      );

  static List<Item> decode(String items) =>
      (json.decode(items) as List<dynamic>)
          .map<Item>((item) => Item.fromJson(item))
          .toList();
}
