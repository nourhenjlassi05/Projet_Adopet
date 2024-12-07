<<<<<<< HEAD
class Dog {
  final String id;
=======
import 'Owner.dart';

class Dog {
  final int id;
>>>>>>> ad01098a80d56158c533a7ac903acf92f63da13e
  final String name;
  final double age;
  final String gender;
  final String color;
  final double weight;
  final String location;
<<<<<<< HEAD
  final String about;
  final String image;
=======
  final String image;
  final String about;
  final Owner owner;
>>>>>>> ad01098a80d56158c533a7ac903acf92f63da13e

  Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.location,
<<<<<<< HEAD
    required this.about,
    required this.image,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      color: json['color'],
      weight: json['weight'],
      location: json['location'],
      about: json['about'],
      image: json['image'],
    );
  }
}
=======
    required this.image,
    required this.about,
    required this.owner,
  });
}
>>>>>>> ad01098a80d56158c533a7ac903acf92f63da13e
