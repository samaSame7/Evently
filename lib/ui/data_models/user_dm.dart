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
}
