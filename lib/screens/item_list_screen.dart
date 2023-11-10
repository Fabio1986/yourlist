import 'package:flutter/material.dart';
import 'package:yourlist/model/category_market.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:yourlist/widgets/item_list.dart';
import 'add_item_screen.dart';
import 'package:provider/provider.dart';
import 'package:yourlist/constant.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({required this.categoryId});

  final String categoryId;

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  String _provideCategoryTitle() {
    final CategoryMarket category = Provider.of<CategoryData>(context)
        .categories
        .where((element) => element.id == widget.categoryId)
        .first;
    return category.name;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) => SingleChildScrollView(
              // visualizzare keyboard sotto tutto
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddItemScreen(categoryId: widget.categoryId),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text('${_provideCategoryTitle()}'),
        /*actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],*/
      ),
      body: Container(
        decoration: kGradientBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ItemList(
                categoryId: widget.categoryId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
