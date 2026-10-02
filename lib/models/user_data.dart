class UserData {
  static String name = '';
  static String email = '';
  static String password = '';
  static String phone = '';
  static String city = '';

  static void setUser({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) {
    name = userName;
    email = userEmail;
    password = userPassword;
  }
}