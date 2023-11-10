import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 21, 56, 129),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 21, 56, 129),
);

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground(
      {super.key, required this.mainAxisAlignmentSetting});
  final MainAxisAlignment mainAxisAlignmentSetting;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: mainAxisAlignmentSetting,
          children: const <Widget>[
            Icon(Icons.delete, color: Colors.white),
            Text('Move to trash', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

var kGradientBackground = BoxDecoration(
// Box decoration takes a gradient
  gradient: LinearGradient(
// Where the linear gradient begins and ends
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
// Add one stop for each color. Stops should increase from 0 to 1
    stops: const [0.1, 0.5, 0.7, 0.9],
    colors: [
// Colors are easy thanks to Flutter's Colors class.
      Colors.indigo[800]!,
      Colors.indigo[700]!,
      Colors.indigo[600]!,
      Colors.indigo[400]!,
    ],
  ),
);
