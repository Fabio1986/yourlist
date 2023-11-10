import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'category_market.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryData extends ChangeNotifier {
  //extends ChangeNotifier {
  List<CategoryMarket> _categories = [];

  void encodeCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = CategoryMarket.encode(_categories);
    await prefs.setString('categories_key', encodedData);
  }

  int get categoriesCount {
    return _categories.length;
  }

  String getCategoriesName(String categoryId) {
    return categories.where((element) => element.id == categoryId).first.name;
  }

  UnmodifiableListView<CategoryMarket> get categories {
    return UnmodifiableListView(_categories);
  }

  void setCategories(List<CategoryMarket> newCategories) {
    _categories = newCategories;
  }

  void addCategory(String newCategoryTitle) {
    final category = CategoryMarket(name: newCategoryTitle);
    _categories.add(category);
    encodeCategories();
    notifyListeners();
  }

  void deleteCategory(CategoryMarket category) {
    _categories.remove(category);
    encodeCategories();
    notifyListeners();
  }
}
