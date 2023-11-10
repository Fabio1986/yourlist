import 'package:yourlist/model/category_market.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:yourlist/model/item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<List<CategoryMarket>> loadDataCategories(
    SharedPreferences sharedPreferences, context) async {
  final String? categories =
      await sharedPreferences?.getString('categories_key');
  if (categories != null) {
    return await CategoryMarket.decode(categories!);
  } else {
    Provider.of<CategoryData>(context, listen: false).addCategory("ALL");
    return await CategoryMarket.decode(categories!);
  }
}

Future<List<Item>> loadItems(SharedPreferences sharedPreferences) async {
  final String? items = await sharedPreferences?.getString('items_key');
  if (items != null) {
    return await Item.decode(items!);
  } else {
    return await [];
  }
}
