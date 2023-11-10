import 'package:flutter/material.dart';
import 'package:yourlist/model/item_data.dart';
import 'package:provider/provider.dart';
import 'package:yourlist/widgets/dropdown-button.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final itemController = TextEditingController();
  String newItemTitle = "";
  String? categorySelected = "all";

  @override
  Widget build(BuildContext context) {
    void _addNewItem() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Provider.of<ItemData>(context, listen: false).addItem(newItemTitle!,
            widget.categoryId == 'all' ? categorySelected! : widget.categoryId);
        setState(() {
          newItemTitle = '';
          itemController.text = "";
        });
      }
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Item',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: itemController,
              autofocus: true,
              textAlign: TextAlign.center,
              maxLength: 30,
              style: Theme.of(context).textTheme.titleLarge,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 30) {
                  return 'Must be between 1 and 30 characters';
                }
                return null;
              },
              onSaved: (value) {
                newItemTitle = value!;
              },
            ),
          ),
          if (widget.categoryId == 'all')
            DropdownButtonCategory(callback: (valueSelected) {
              categorySelected = valueSelected;
            }),
          ElevatedButton(
            onPressed: _addNewItem,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // <-- Radius
              ),
            ),
            child: Text(
              'Add',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
