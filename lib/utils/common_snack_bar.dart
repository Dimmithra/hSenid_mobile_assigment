import 'package:country_app/widgets/common_lable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SnackBarUtils {
  static void showSnackBar(
    BuildContext context, {
    required String message,
    SnackBarStyle style = const SnackBarStyle(),
    Duration duration = const Duration(seconds: 5),
    SnackBarAction? action,
    final Widget? icon,
  }) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.white, width: 1),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            icon == null
                ? FaIcon(
                    FontAwesomeIcons.infoCircle,
                    color: Colors.white,
                    size: 20,
                  )
                : icon,
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: CommonLable(
                  labelName: message,
                  fontSize: 12,
                  enableNotoSerif: false,
                  color: style.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: style.backgroundColor,
      duration: duration,
      action: action,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class SnackBarStyle {
  final Color textColor;
  final Color backgroundColor;

  const SnackBarStyle({
    this.textColor = Colors.white,
    this.backgroundColor = Colors.black,
  });
}
