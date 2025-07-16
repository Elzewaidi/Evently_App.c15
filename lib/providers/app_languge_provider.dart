import 'package:flutter/cupertino.dart';

class AppLangugeProvider extends ChangeNotifier {
  //data
  String appLanguage = 'en';

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
