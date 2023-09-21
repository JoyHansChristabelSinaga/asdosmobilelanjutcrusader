import 'package:flutter/material.dart';

import 'models.dart';

class ProfileManager extends ChangeNotifier {
  User get getUser => User(
        Name: 'Joy Hans Christabel Sinaga',
        jurusan: 'Ilmu Komputer',
        profileImageUrl: 'assets/blah.jpg',
        NPM: '2017051050',
        darkMode: _darkMode,
      );

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnlink => _tapOnlink;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _tapOnlink = false;
  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnRaywenderlich(bool selected) {
    _tapOnlink = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
