import 'package:dashboard_bloc_tdd/core/res/colors.dart';
import 'package:flutter/material.dart';

class CoreUitls {
  const CoreUitls._();

  static void showSnackBar(BuildContext context, String messsage) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            messsage,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.primaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }
}
