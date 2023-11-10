import 'package:flutter/material.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newCategoryTitle = "";

    void _addNewCategory() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Provider.of<CategoryData>(context, listen: false)
            .addCategory(newCategoryTitle!);
        setState(() {
          newCategoryTitle = "";
          categoryController.text = "";
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
            'Add Category',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: categoryController,
              autofocus: true,
              textAlign: TextAlign.center,
              maxLength: 30,
              style: Theme.of(context).textTheme.titleLarge,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 30) {
                  return 'Must be between 1 and 20 characters';
                }
                return null;
              },
              onSaved: (value) {
                newCategoryTitle = value!;
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addNewCategory,
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
          )
        ],
      ),
    );
  }
}
