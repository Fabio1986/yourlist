import 'package:flutter/foundation.dart';
import 'package:yourlist/model/item.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

class ItemData extends ChangeNotifier {
  List<Item> _items = [];

  int get itemsCount {
    return _items.length;
  }

  void encodeItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Item.encode(_items);
    await prefs.setString('items_key', encodedData);
    print("itemssssssssssssssss$encodedData");
  }

  void setItems(List<Item> newItems) {
    _items = newItems;
  }

  int countItemsByCategory(String categoryId) {
    return _items.where((element) => element.categoryId == categoryId).length;
  }

  UnmodifiableListView<Item> get items {
    return UnmodifiableListView(_items);
  }

  UnmodifiableListView<Item> itemsByCategory(String categoryId) {
    print('$categoryId ciao');
    return UnmodifiableListView(
        _items.where((element) => element.categoryId == categoryId));
  }

  void addItem(String newItemTitle, String categoryId) {
    final item = Item(name: newItemTitle, categoryId: categoryId);
    _items.add(item);
    encodeItems();
    notifyListeners();
  }

  void updateItem(Item item) {
    item.toggleDone();
    encodeItems();
    notifyListeners();
  }

  void deleteItem(Item item) {
    _items.remove(item);
    encodeItems();
    notifyListeners();
  }

  void deleteAllItemsByCategoryId(String categoryId) {
    List<Item> removeThisItemsByCategory =
        _items.where((element) => element.categoryId == categoryId).toList();
    for (var item in removeThisItemsByCategory) {
      _items.remove(item);
    }
    encodeItems();
    notifyListeners();
  }
}
