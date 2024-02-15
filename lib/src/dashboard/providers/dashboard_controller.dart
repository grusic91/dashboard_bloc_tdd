import 'package:dashboard_bloc_tdd/core/common/app/providers/tab_navigator.dart';
import 'package:dashboard_bloc_tdd/core/common/views/persistent_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNaviagator(
        TabItem(
          child: const Placeholder(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  // index of profile page
  int _currentIndex = 3;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
