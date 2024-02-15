import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNaviagator extends ChangeNotifier {
  TabNaviagator(this._initalPage) {
    _navigationStack.add(_initalPage);
  }

  final TabItem _initalPage;
  final List<TabItem> _navigationStack = [];

  TabItem get currentPage => _navigationStack.last;

  void push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }

  void pop() {
    if (_navigationStack.length > 1) _navigationStack.removeLast();
    notifyListeners();
  }

  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initalPage);

    notifyListeners();
  }

  void popTo(TabItem page) {
    _navigationStack.remove(page);
    notifyListeners();
  }

  void popUntil(TabItem? page) {
    if (page == null) return popToRoot();
    if (_navigationStack.length > 1) {
      _navigationStack.removeRange(1, _navigationStack.indexOf(page) + 1);
      notifyListeners();
    }
  }

  void pushAndRemoveUntil(TabItem page) {
    _navigationStack
      ..clear()
      ..add(page);
    notifyListeners();
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNaviagator> {
  const TabNavigatorProvider({
    required this.naviagator,
    required super.child,
    super.key,
  }) : super(notifier: naviagator);

  final TabNaviagator naviagator;

  static TabNaviagator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.naviagator;
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<dynamic> get props => [id];
}
