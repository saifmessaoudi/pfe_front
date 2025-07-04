import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  Future<void> writeUsername(String username) async {
    await _storage.write(key: 'plain_username', value: username);
  }

  Future<String?> readUsername() async {
    return await _storage.read(key: 'plain_username');
  }

  Future<void> deleteUsername() async {
    await _storage.delete(key: 'plain_username');
  }

  // Save access token to secure storage
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  // Read access token from secure storage
  Future<String?> readAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Remove access token from secure storage
  Future<void> removeAccessToken() async {
    await _storage.delete(key: 'access_token');
  }

  // Save refresh token to secure storage
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  // Read refresh token from secure storage
  Future<String?> readRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  // Remove refresh token from secure storage
  Future<void> removeRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }

  // Save isAuthenticated flag to secure storage
  Future<void> setIsAuthenticated(bool isAuthenticated) async {
    await _storage.write(key: 'is_authenticated', value: isAuthenticated.toString());
  }

  // Read isAuthenticated flag from secure storage
  Future<bool> getIsAuthenticated() async {
    final value = await _storage.read(key:  'is_authenticated');
    return value == 'true';
  }

  // Remove isAuthenticated flag from secure storage
  Future<void> removeIsAuthenticated() async {
    await _storage.delete(key: 'is_authenticated');
  }
}