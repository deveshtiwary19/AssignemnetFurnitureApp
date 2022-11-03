import 'package:assignment/config/size_config.dart';
import 'package:assignment/config/ui_constants.dart';
import 'package:assignment/ui/splash_screen/splash_sceen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional ViewModel
    // binding which will execute the builder again when notifyListeners is called.
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (viewModel) => viewModel.init(context),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Assignment Furnitures",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: SizeConfig.title5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.padding20,
              ),
              SpinKitWave(
                color: Colors.blue,
                size: SizeConfig.padding28,
              )
            ],
          ),
        );
      },
    );
  }
}
