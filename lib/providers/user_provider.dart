import 'package:eventlyapp/Model/users.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  //data
  //function
  MyUser? currentUser;

  void upDateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
