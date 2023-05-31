class Admin {
  final String fristName;
  final String lastName;
  final String password;
  // final String userName;
  final String id;
  final String kebele;
  final String email;
  final int phoneNumber;
  final int accountNumber;
  // ignore: non_constant_identifier_names
  final String role;
  

  Admin({
    required this.fristName,
    required this.lastName,
    required this.password,
    // required this.userName,
    required this.id,
    required this.kebele,
    required this.email,
    required this.phoneNumber,
    required this.accountNumber,
    // ignore: non_constant_identifier_names
    required this.role,
    
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    json = json["payload"];
    print(json);
    return Admin(
      fristName: json['fristName'],
      lastName: json['lastName'],
      password: "",
      email: json['email'],
      kebele: json['kebele'],
      phoneNumber: json['phoneNumber'],
      accountNumber: json['accountNumber'],
      // userName: json['userName'],
      role: json['role'],
      id: json['id'],
      
    );
  }
}
