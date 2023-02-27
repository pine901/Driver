class Driver {
  String id;
  String phone;
  String email;
  String name;

  Driver(
      {required this.id,
      required this.phone,
      required this.email,
      required this.name});

  factory Driver.fromMap(Map<String, dynamic>? data) {
    return Driver(
      id: data!['id'],
      phone: data['phone'],
      email: data['email'],
      name: data['name'],
    );
  }
}
