import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageServiceMig {
  Future<void> writeUsername(String username) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('plain_username', username);
  }

  Future<String?> readUsername() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString('plain_username');
  }

  Future<void> deleteUsername() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove('plain_username');
  }

  // Save access token to secure storage
  Future<void> saveAccessToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('access_token',  token);
  }

  // getString access token from secure storage
  Future<String?> readAccessToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString('access_token');
  }

  // Remove access token from secure storage
  Future<void> removeAccessToken() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove('access_token');
  }

  // Save refresh token to secure storage
  Future<void> saveRefreshToken(String token) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('refresh_token',  token);
  }

  // getString refresh token from secure storage
  Future<String?> readRefreshToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString('refresh_token');
  }

  // Remove refresh token from secure storage
  Future<void> removeRefreshToken() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove('refresh_token');
  }

  // Save isAuthenticated flag to secure storage
  Future<void> setIsAuthenticated(bool isAuthenticated) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(
      'is_authenticated',
       isAuthenticated.toString(),
    );
  }

  // getString isAuthenticated flag from secure storage
  Future<bool> getIsAuthenticated() async {
    var pref = await SharedPreferences.getInstance();
    final value = pref.getString('is_authenticated');
    return value == 'true';
  }

  // Remove isAuthenticated flag from secure storage
  Future<void> removeIsAuthenticated() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove('is_authenticated');
  }
}
