class UserDm {
  static UserDm? currentUser;
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final List<String> favouriteEvents;

  const UserDm({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.favouriteEvents = const[],
  });

  static UserDm fromJson(Map<String,dynamic> json){
    UserDm user = UserDm(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
    return user;
  }

  Map<String,dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'favouriteEvents': favouriteEvents,
    };
  }
}
