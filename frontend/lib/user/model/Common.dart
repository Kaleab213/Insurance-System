abstract class AppUser {
  final String firstName;
  final String lastName;
  final String? password;
  final String id;
  final String email;
  final String role;

  AppUser({
    required this.firstName,
    required this.lastName,
    this.password,
    required this.id,
    required this.email,
    required this.role,
  });
}