import 'package:country_app/provider/auth_provider.dart';
import 'package:country_app/utils/color_const.dart';
import 'package:country_app/utils/main_body.dart';
import 'package:country_app/widgets/common_lable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).navigateToNextScreenAfterDelay(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        appBarBacgroundColor: kAppBarBackgroundColor,
        backgroundColor: kBackgroundColor,
        body: Center(
          child: CommonLable(
            labelName: "Welcome",
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
