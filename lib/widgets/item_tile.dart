import 'package:flutter/material.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  bool isChecked = false;
  final String taskTitle;
  final Function checkBoxCallback;
  final Color color;
  final int index;
  final String categoryId;
  final String categoryItem;
  final VoidCallback? longPressCallback;

  ItemTile(
      {required this.isChecked,
      required this.taskTitle,
      required this.checkBoxCallback,
      required this.color,
      required this.index,
      this.longPressCallback,
      required this.categoryId,
      required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: categoryId == 'all'
          ? Text(
              Provider.of<CategoryData>(context, listen: false)
                  .getCategoriesName(categoryItem),
            )
          : null,
      tileColor: color,
      onTap: () {
        checkBoxCallback(!isChecked);
      },
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            decorationThickness: 3,
            decorationColor: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Theme.of(context).colorScheme.secondary),
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (newValue) {
          checkBoxCallback(newValue);
        },
        //onChanged: (checkBoxState) => toogleCheckboxState(checkBoxState),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
