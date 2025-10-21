import 'package:country_app/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // navigate to homepage
  Future<void> navigateToNextScreenAfterDelay(context) async {
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomeScreen()),
    //   );
    // });
  }
}
