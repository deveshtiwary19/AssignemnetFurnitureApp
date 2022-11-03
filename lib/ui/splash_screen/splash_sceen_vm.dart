// ViewModel
import 'package:assignment/config/size_config.dart';
import 'package:assignment/ui/home_screen/home_view.dart';
import 'package:assignment/web_services/web_services.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  //Init method, for the splash screen view
  void init(BuildContext context) {
    SizeConfig.init(context);
    proceedHomePage(context);
  }

  void proceedHomePage(BuildContext context) {
    //Takes to home screen after 3 seconds on Home Screen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false);
    });
  }
}
