class Auth {
  final String? email;
  final String? password;
  final String? token;

  Auth({
  this.email,
    this.password,
    this.token,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(token: json['access_token']);
      
    
  }
}
// class Auth {
//   final String email;
//   final String password;
//   final String token;

//   Auth({
//     required this.email,
//     required this.password,
//     required this.token,
//   });

//   factory Auth.fromJson(Map<String, dynamic> json) {
//     return Auth(
//       email: json['email'],
//       password: json['userID'],
//       token: json['access_token'],
//     );
//   }
// }
