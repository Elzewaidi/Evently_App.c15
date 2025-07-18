class MyUser {
  static const String collectionName = 'Users';

  String name;
  String id;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  // json -> object
  MyUser.fromFireStore(Map<String, dynamic> data)
    : id = data['id'] ?? '',
      name = data['name'] ?? '',
      email = data['email'] ?? '';

  // object -> json
  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}