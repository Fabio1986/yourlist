import 'package:flutter/foundation.dart';

class ColorMode extends ChangeNotifier {
  //extends ChangeNotifier {
  bool _isLightMode = true;

  bool get isLightMode {
    return _isLightMode;
  }

  void updateMode(bool newMode) {
    _isLightMode = newMode;
    notifyListeners();
  }
}
