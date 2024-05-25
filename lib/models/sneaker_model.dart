
import 'dart:convert';

List<Sneakers> snekersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));


class Sneakers {
  String id;
  String name;
  String category;
  List<String> imageUrl;
  String oldPrice;
  List<dynamic> sizes;
  String price;
  String description;
  String title;

  Sneakers({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
  });

  factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
    oldPrice: json["oldPrice"],
    sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
    price: json["price"],
    description: json["description"],
    title: json["title"],
  );


}