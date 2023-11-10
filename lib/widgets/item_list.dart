import 'package:flutter/material.dart';
import 'package:yourlist/model/item_data.dart';
import 'package:yourlist/widgets/item_tile.dart';
import 'package:provider/provider.dart';
import 'package:yourlist/constant.dart';

class ItemList extends StatefulWidget {
  ItemList({required this.categoryId});
  final String categoryId;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemData>(
      // consumer widget listen for changes
      builder: (context, itemData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final color = index.isEven
                ? Theme.of(context).colorScheme.background.withOpacity(1)
                : Theme.of(context).colorScheme.primary.withOpacity(0.4);
            final item = widget.categoryId == 'all'
                ? itemData.items[index]
                : itemData.itemsByCategory(widget.categoryId)[index];
            //Provider.of<TaskData>(context) -> become -> taskData
            return Card(
              child: Dismissible(
                background: const DismissibleBackground(
                  mainAxisAlignmentSetting: MainAxisAlignment.start,
                ),
                secondaryBackground: const DismissibleBackground(
                  mainAxisAlignmentSetting: MainAxisAlignment.end,
                ),
                onDismissed: (direction) {
                  setState(() {
                    itemData.deleteItem(item);
                  });
                },
                key: UniqueKey(),
                child: ItemTile(
                  color: color!,
                  isChecked: item.isDone,
                  taskTitle: item.name,
                  index: index,
                  categoryId: widget.categoryId,
                  categoryItem: item.categoryId,
                  checkBoxCallback: (bool checkBoxState) {
                    itemData.updateItem(item);
                  },
                  longPressCallback: () {
                    setState(() {
                      itemData.deleteItem(item);
                    });
                  },
                ),
              ),
            );
          },
          itemCount: widget.categoryId == 'all'
              ? itemData.itemsCount
              : itemData.countItemsByCategory(widget.categoryId),
        );
      },
    );
  }
}
