class User {
  final String username;
  final String password;
  final String fullName;
  final int    role; // 0: admin, 1: user

  const User({
    required this.username,
    required this.password,
    required this.fullName,
    required this.role,
  });
}