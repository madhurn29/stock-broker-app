enum LoginStatus { success, invalid, error }

class MockApiService {
  static Future<LoginStatus> login(
    String broker,
    String user,
    String pass,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (user == "demo" && pass == "123") return LoginStatus.success;
    if (user.isEmpty || pass.isEmpty || user.length < 3)
      return LoginStatus.invalid;

    return LoginStatus.error; // simulate server error randomly
  }
}
