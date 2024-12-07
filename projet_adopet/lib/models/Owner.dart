
class Owner {
  final String name;
  final String bio;
  final String image;

  Owner({
    required this.name,
    required this.bio,
    required this.image,
  });
<<<<<<< HEAD

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'],
      bio: json['bio'],
      image: json['image'],
    );
  }
=======
>>>>>>> ad01098a80d56158c533a7ac903acf92f63da13e
}
