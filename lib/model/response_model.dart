// To parse this JSON data, do
//
//     final Products = ProductsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    required this.status,
    required this.response,
  });

  String status;
  List<Response> response;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        status: json["status"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    required this.id,
    required this.name,
    required this.about,
    required this.price,
    required this.cat,
    required this.variants,
  });

  String id;
  String name;
  String about;
  String price;
  String cat;
  List<Variant> variants;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        about: json["about"],
        price: json["price"],
        cat: json["cat"],
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "about": about,
        "price": price,
        "cat": cat,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
      };
}

class Variant {
  Variant({
    required this.color,
    required this.url,
  });

  String color;
  String url;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        color: json["color"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "url": url,
      };
}
