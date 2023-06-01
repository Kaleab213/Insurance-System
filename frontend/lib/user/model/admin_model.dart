class Admin {
  final String firstName;
  final String lastName;
  final String? password;
  // final String userName;
  final String id;
  final String email;
  // ignore: non_constant_identifier_names
  final String role;

  Admin({
    required this.firstName,
    required this.lastName,
    this.password,
    // required this.userName,
    required this.id,
    required this.email,
    required this.role,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    print("here in Admin");
    // json = json["payload"];
    // print(json);
    return Admin(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['hash'],
      email: json['email'],
      // userName: json['userName'],
      role: json['role'],
      id: json['id'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'id': id,
      'email': email,
      'role': role
    };
  }
}
