import 'package:assignment/model/response_model.dart';
import 'package:flutter/cupertino.dart';

class ProductDetailsViewModel with ChangeNotifier {
  String _curentImage = "";

  //Getters
  String get currentImage => _curentImage;

  void init(Response response) {
    _curentImage = response.variants[0].url;
  }

  void changeImageToShow(String url) {
    if (url != _curentImage) {
      _curentImage = url;
      notifyListeners();
    }
  }
}
