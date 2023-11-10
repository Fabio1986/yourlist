import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourlist/model/category_market_data.dart';
import 'package:yourlist/model/color_mode.dart';
import 'package:yourlist/model/item_data.dart';
import 'package:yourlist/screens/home.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // locking device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<CategoryData>(create: (_) => CategoryData()),
        ListenableProvider<ItemData>(create: (_) => ItemData()),
        ListenableProvider<ColorMode>(create: (_) => ColorMode()),
      ],
      child: Consumer<ColorMode>(
        builder: (context, colorMode, child) {
          return MaterialApp(
            darkTheme: ThemeData.dark().copyWith(
              useMaterial3: true,
              colorScheme: kDarkColorScheme,
              cardTheme: const CardTheme().copyWith(
                color: kDarkColorScheme.primaryContainer,
                margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  //set border radius more than 50% of height and width to make circle
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer,
                ),
              ),
              textTheme: ThemeData().textTheme.copyWith(
                    titleLarge: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kColorScheme.secondaryContainer,
                        fontSize: 25.0),
                  ),
            ),
            theme: ThemeData().copyWith(
              useMaterial3: true,
              colorScheme: kColorScheme,
              appBarTheme: const AppBarTheme().copyWith(
                  backgroundColor: kColorScheme.onPrimaryContainer,
                  foregroundColor: kColorScheme.primaryContainer),
              cardTheme: const CardTheme().copyWith(
                color: kColorScheme.primaryContainer,
                margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  //set border radius more than 50% of height and width to make circle
                ),
              ),
              floatingActionButtonTheme:
                  const FloatingActionButtonThemeData().copyWith(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(7)),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.primaryContainer,
                ),
              ),
              textTheme: ThemeData().textTheme.copyWith(
                    titleLarge: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kColorScheme.primary,
                        fontSize: 25.0),
                    labelLarge: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kColorScheme.secondaryContainer,
                        fontSize: 30.0),
                    bodyLarge: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kColorScheme.secondaryContainer,
                        fontSize: 25.0),
                  ),
            ),
            themeMode:
                Provider.of<ColorMode>(context, listen: false).isLightMode
                    ? ThemeMode.light
                    : ThemeMode.dark,
            home: AnimatedSplashScreen.withScreenFunction(
              splash: "images/logo.png",
              splashIconSize: double.infinity,
              backgroundColor: Colors.indigo,
              screenFunction: () async {
                return const HomeScreen();
              },
              splashTransition: SplashTransition.slideTransition,
              pageTransitionType: PageTransitionType.leftToRight,
            ),
          );
        },
      ),
    );
  }
}
