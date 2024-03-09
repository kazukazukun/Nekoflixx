import 'package:flutter/material.dart';
import 'package:nekoflixx/constants.dart';

class NekoflixxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NekoflixxAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: SafeArea(
        child: Image.asset(
          Constants.appBarImagePath,
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
