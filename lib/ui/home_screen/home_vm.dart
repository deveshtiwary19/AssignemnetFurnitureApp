import 'package:assignment/config/constants.dart';
import 'package:assignment/main.dart';
import 'package:assignment/model/response_model.dart';
import 'package:assignment/ui/product_details_screen/product_details_view.dart';
import 'package:assignment/web_services/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  List<Response> _productList = [];
  ViewState _state = ViewState.BUSY;

  List<String> options = [
    AppUtils.CATEGORY_ALL,
    AppUtils.CATEGORY_CHAIR,
    AppUtils.CATEGORY_TABLE,
  ];

  String _currentCategory = "";

  List<Response> _productsToShow = [];

  //Getters
  List<Response> get productsList => _productList;
  ViewState get viewState => _state;
  String get currentCategory => _currentCategory;
  List<Response> get productsToShow => _productsToShow;

  void init() {
    fetchProducts();
    _currentCategory =
        AppUtils.CATEGORY_ALL; //Setting the category to ALL by default
  }

  void fetchProducts() async {
    Products product = await WebServices.getProducts();
    _productList = product.response;
    _productsToShow = _productList; //Setting to SHOW ALL products by default
    _state = ViewState.IDLE;
    notifyListeners();
  }

  void changeCategory(String tappedCategory) {
    if (_currentCategory != tappedCategory) {
      _state = ViewState.BUSY;
      _productsToShow = [];
      notifyListeners();

      if (tappedCategory == AppUtils.CATEGORY_ALL) {
        _productsToShow = _productList;
      } else {
        for (Response r in _productList) {
          if (r.cat == tappedCategory) _productsToShow.add(r);
        }
      }

      _currentCategory = tappedCategory;
      notifyListeners();
    } else {
      final SnackBar snackBar = SnackBar(
          content: Text("You are already on $tappedCategory category"));
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }

  void navigateToDetailsPage(BuildContext context, Response response) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsView(response: response),
        ));
  }
}
