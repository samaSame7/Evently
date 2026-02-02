class UserDm {
  static UserDm? currentUser;
  static const String collectionName = "Users";
  String id;
  String name;
  String phoneNumber;
  String email;
  List<String> favouriteEvents;

  UserDm({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.favouriteEvents = const [],
  });

  static UserDm fromJson(Map<String, dynamic> json) {
    List<dynamic> favorites = json["favouriteEvents"];

    UserDm user = UserDm(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      favouriteEvents: favorites.map((id) => id.toString()).toList(),
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'favouriteEvents': favouriteEvents,
    };
  }
}
