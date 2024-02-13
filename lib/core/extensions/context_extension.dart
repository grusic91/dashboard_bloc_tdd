import 'package:dashboard_bloc_tdd/core/common/app/providers/user_provider.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextExt on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // get size
  Size get size => mediaQuery.size;

  // get widths
  double get width => size.width;

  // get height
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  LocalUser? get currentUser => userProvider.user;
}
