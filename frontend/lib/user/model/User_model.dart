class User {
  final String firstName;
  final String lastName;
  final String? password;
  // final String userName;
  final String id;
  // final String kebele;
  final String email;
   final String role;
  // ignore: non_constant_identifier_names
 

  User({
    required this.firstName,
    required this.lastName,
    this.password,
    // required this.userName,
    required this.id,
    // required this.kebele,
    required this.email,
    required this.role,
    // ignore: non_constant_identifier_names
    
  });




  factory User.fromJson(Map<String, dynamic> json) {
    print("here in user");
    // json = json["payload"];
  
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['hash'],
      email: json['email'],
      // kebele: json['kebele'],
  
      // userName: json['userName'],
      role: json['role'],
      id: json['id'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName':firstName,
  'lastName':lastName,
  'password':password,

  'id':id,
 
  'email':email,
   'role':role
    };
  }
}

