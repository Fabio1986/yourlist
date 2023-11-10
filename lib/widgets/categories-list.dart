import 'package:flutter/material.dart';
import 'package:yourlist/model/item_data.dart';
import 'package:yourlist/screens/item_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:yourlist/constant.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
  });

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    void _goToItem(index) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ItemListScreen(
              categoryId:
                  Provider.of<CategoryData>(context).categories[index].id),
        ),
      );
    }

    return Consumer<CategoryData>(
      // consumer widget listen for changes
      builder: (context, categoryData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = categoryData.categories[index];
            //Provider.of<TaskData>(context) -> become -> taskData
            return task.id != 'all'
                ? Card(
                    child: Dismissible(
                      background: const DismissibleBackground(
                        mainAxisAlignmentSetting: MainAxisAlignment.start,
                      ),
                      secondaryBackground: const DismissibleBackground(
                        mainAxisAlignmentSetting: MainAxisAlignment.end,
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          Provider.of<ItemData>(context, listen: false)
                              .deleteAllItemsByCategoryId(task.id);
                          Provider.of<CategoryData>(context, listen: false)
                              .deleteCategory(task);
                        });
                      },
                      key: Key(task.id),
                      child: CategoryItemScreen(
                        goToItem: _goToItem,
                        index: index,
                      ),
                    ),
                  )
                : Card(
                    child: CategoryItemScreen(
                      goToItem: _goToItem,
                      index: index,
                    ),
                  );
          },
          itemCount: categoryData.categoriesCount,
        );
      },
    );
  }
}

class CategoryItemScreen extends StatelessWidget {
  const CategoryItemScreen(
      {super.key, required this.goToItem, required this.index});
  final Function goToItem;
  final index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        goToItem(index);
      },
      title: Text(
        Provider.of<CategoryData>(context).categories[index].name,
        style: Theme.of(context).textTheme.titleLarge,
        maxLines: 2,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
