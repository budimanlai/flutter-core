import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'model/user_profile.dart';

class SessionManager<T> {
  static const _keyProfile = 'user_profile';
  
  final FlutterSecureStorage _storage;
  final T Function(Map<String, dynamic>)? fromJson;

  SessionManager({
    this.fromJson,
    FlutterSecureStorage? storage
  }) : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  Future<void> saveSession(T profile) async {
    final jsonString = jsonEncode(profile);
    await _storage.write(key: _keyProfile, value: jsonString);
  }

  Future<T?> getSession() async {
    final jsonString = await _storage.read(key: _keyProfile);
    if (jsonString != null && fromJson != null) {
      try {
        return fromJson!(jsonDecode(jsonString));
      } catch (e) {
        // Handle corruption or format change
        return null;
      }
    }
    return null;
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _keyProfile);
  }
}
