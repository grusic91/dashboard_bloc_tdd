import 'dart:async';

import 'package:dashboard_bloc_tdd/core/common/widgets/popup_item.dart';
import 'package:dashboard_bloc_tdd/core/extensions/context_extension.dart';
import 'package:dashboard_bloc_tdd/core/res/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: const Icon(Icons.more_horiz),
          surfaceTintColor: Colors.white,
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: const PopupItem(
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colours.neutralTextColour,
                ),
                title: 'Edit Profile',
              ),
              onTap: () => context.push(const Placeholder()),
            ),
            PopupMenuItem<void>(
              child: const PopupItem(
                icon: Icon(
                  IconlyLight.notification,
                  color: Colours.neutralTextColour,
                ),
                title: 'Notification',
              ),
              onTap: () => context.push(const Placeholder()),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
                indent: 16,
                endIndent: 16,
              ),
            ),
            PopupMenuItem<void>(
              child: const PopupItem(
                icon: Icon(
                  Icons.help_outline,
                  color: Colours.neutralTextColour,
                ),
                title: 'Help',
              ),
              onTap: () => context.push(const Placeholder()),
            ),
            PopupMenuItem<void>(
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();

                unawaited(
                  navigator.pushNamedAndRemoveUntil('/', (route) => false),
                );
              },
              child: const PopupItem(
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
                title: 'Log out',
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
