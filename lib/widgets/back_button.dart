import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context); // Get the current theme
    Color backgroundColor = theme.scaffoldBackgroundColor;
    Brightness brightness =
        ThemeData.estimateBrightnessForColor(backgroundColor);

    Color iconColor =
        brightness == Brightness.dark ? Colors.white : Colors.black;

    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsetsDirectional.only(top: 8, start: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_rounded, color: iconColor),
      ),
    );
  }
}
