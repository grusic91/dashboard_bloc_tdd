import 'package:dashboard_bloc_tdd/core/res/colors.dart';
import 'package:dashboard_bloc_tdd/core/res/fonts.dart';
import 'package:dashboard_bloc_tdd/core/services/router.dart';
import 'package:dashboard_bloc_tdd/src/on_boarding/presentation/on_boarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard TDD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        fontFamily: Fonts.poppins,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
