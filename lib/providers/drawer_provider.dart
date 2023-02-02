import 'package:flutter/material.dart';
import 'package:messenger/enums/drawer_enum.dart';

class DrawerProvider extends ChangeNotifier {
  DrawerEnum get selectedPage => _selectedPage;
  DrawerEnum _selectedPage = DrawerEnum.home;

  void changePage(DrawerEnum newPage) {
    _selectedPage = newPage;
    notifyListeners();
  }
}
