import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:yourlist/model/category_market.dart';
import 'package:provider/provider.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownButtonCategory extends StatefulWidget {
  const DropdownButtonCategory({required this.callback});

  final Function callback;

  @override
  State<DropdownButtonCategory> createState() => _DropdownButtonCategoryState();
}

class _DropdownButtonCategoryState extends State<DropdownButtonCategory> {
  late UnmodifiableListView<CategoryMarket> list;

  String? selectedValue = 'all';

  final List<String> items = [];

  @override
  Widget build(BuildContext context) {
    list = Provider.of<CategoryData>(context, listen: false).categories;

    List<DropdownMenuItem<String>> _addItems() {
      final List<DropdownMenuItem<String>> menuItems = [];
      for (final item in list) {
        menuItems.addAll(
          [
            DropdownMenuItem<String>(
              value: item.id,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.name,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }
      return menuItems;
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        items: _addItems(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.callback(selectedValue);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          width: 10,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).colorScheme.primary,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            thickness: MaterialStateProperty.all(10),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 5, right: 14),
        ),
      ),
    );
  }
}
