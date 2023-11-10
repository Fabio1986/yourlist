import 'package:flutter/material.dart';
import 'package:yourlist/model/category_market.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:yourlist/model/color_mode.dart';
import 'package:yourlist/model/item.dart';
import 'package:yourlist/model/item_data.dart';
import 'add_category_screen.dart';
import 'package:yourlist/widgets/categories-list.dart';
import 'package:provider/provider.dart';
import 'package:yourlist/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourlist/services.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen>
    with TickerProviderStateMixin {
  SharedPreferences? sharedPreferences;
  late AnimationController controller;
  bool showLoadingSpin = true;
  List<CategoryMarket> listOfCategories = [];

  @override
  void initState() {
    loadSharedPreferences();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadDataCategories(sharedPreferences!, context).then((value) => {
          listOfCategories = value,
          Provider.of<CategoryData>(context, listen: false)
              .setCategories(listOfCategories),
          setState(() {
            showLoadingSpin = false;
          })
        });
    List<Item> listOfItems = await loadItems(sharedPreferences!);
    if (listOfItems != null) {
      Provider.of<ItemData>(context, listen: false).setItems(listOfItems);
    } else {
      Provider.of<ItemData>(context, listen: false).setItems([]);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          showLoadingSpin = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    bool isLightMode =
        Provider.of<ColorMode>(context, listen: false).isLightMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      floatingActionButton: !showLoadingSpin
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    heroTag: 'btn1',
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    child: Icon(
                      isLightMode ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        Provider.of<ColorMode>(context, listen: false)
                            .updateMode(!isLightMode);
                      });
                    },
                  ),
                ),*/
                FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
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
                        child: const AddCategoryScreen(),
                      )),
                    );
                  },
                )
              ],
            )
          : null,
      body: showLoadingSpin
          ? Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CircularProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Circular progress indicator',
                strokeWidth: 8,
                color: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              Text(
                "LOADING",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ])
          : Container(
              // Add box decoration
              decoration: kGradientBackground,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 2.0,
                  ),
                  Expanded(
                    child: CategoriesList(),
                  ),
                ],
              ),
            ),
    );
  }
}
