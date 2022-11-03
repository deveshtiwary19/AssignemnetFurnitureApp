import 'package:assignment/model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebServices with ChangeNotifier {
  static Future<Products> getProducts() async {
    try {
      var response = await http.get(
        Uri.parse(
          'https://mocki.io/v1/3ba44b5d-f4d1-4acf-892c-a7164202c92c',
        ),
      );
      var results = productsFromJson(response.body);

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
