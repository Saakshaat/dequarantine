import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class NavigationProvider with ChangeNotifier {
  int selectedPage = 1;

  void changePage(int index) {
    selectedPage = index;
    notifyListeners();
  }
}
