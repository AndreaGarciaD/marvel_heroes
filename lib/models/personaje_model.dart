// To parse this JSON data, do
//
//     final personaje = personajeFromJson(jsonString);

import 'dart:convert';

Personaje personajeFromJson(String str) => Personaje.fromJson(json.decode(str));

String personajeToJson(Personaje data) => json.encode(data.toJson());

class Personaje {
  int? id;
  String name;
  String heroName;
  String description;
  int age;
  double height;
  double weight;
  String planet;
  int strength;
  int intelligence;
  int agility;
  int resistance;
  int speed;
  String image;
  String category;
  List<String> movieList = [];

  Personaje({
    required this.id,
    required this.name,
    required this.heroName,
    required this.description,
    required this.age,
    required this.height,
    required this.weight,
    required this.planet,
    required this.strength,
    required this.intelligence,
    required this.agility,
    required this.resistance,
    required this.speed,
    required this.image,
    required this.category,
    required this.movieList,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
        id: json["id"],
        name: json["name"],
        heroName: json["hero_name"],
        description: json["description"],
        age: json["age"],
        height: json["height"]?.toDouble(),
        weight: json["weight"]?.toDouble(),
        planet: json["planet"],
        strength: json["strength"],
        intelligence: json["intelligence"],
        agility: json["agility"],
        resistance: json["resistance"],
        speed: json["speed"],
        image: json["image"],
        category: json["category"],
        movieList: List<String>.from(jsonDecode(json["movieList"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hero_name": heroName,
        "description": description,
        "age": age,
        "height": height,
        "weight": weight,
        "planet": planet,
        "strength": strength,
        "intelligence": intelligence,
        "agility": agility,
        "resistance": resistance,
        "speed": speed,
        "image": image,
        "category": category,
        "movieList": jsonEncode(movieList),
      };
}
