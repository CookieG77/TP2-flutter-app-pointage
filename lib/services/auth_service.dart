import '../models/user.dart';

List<User> Users = [
  const User(
    username: 'admin',
    password: '1234',
    fullName: 'Admin User',
    role: 0,
  ),
  const User(
    username: 'john_doe',
    password: '1234',
    fullName: 'John Doe',
    role: 1,
  ),
  const User(
    username: 'jane_smith',
    password: '1234',
    fullName: 'Jane Smith',
    role: 1,
  ),
  const User(
    username: 'bob_johnson',
    password: '1234',
    fullName: 'Bob Johnson',
    role: 1,
  )
];

class AuthService {

  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static bool get isAuthenticated => _currentUser != null;

  static bool get isAdmin => _currentUser?.role == 0;

  static bool login(String username, String password) {
    try {
      final User user = Users.firstWhere(
              (u) => u.username == username && u.password == password
      );
      _currentUser = user;
      return true; // No error
        } catch (e) {
      // Needs to catch the error when no user is found, but we can ignore it since we return false anyway
    }
    return false;
  }

  static void logout() {
    _currentUser = null;
  }
}