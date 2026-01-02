import 'package:flutter_pkg/http.dart';
import 'model/user_profile.dart';
import 'session_manager.dart';

class AuthService {
  final ApiBase _api;
  final SessionManager<UserProfile> _sessionManager;

  AuthService(this._api, this._sessionManager);

  Future<ApiResponse<UserProfile>> login({
    required String username,
    required String password,
  }) async {
    final response = await _api.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    ) as ApiResponse;

    if (response.meta.isSuccess && response.data != null) {
      final userProfile = UserProfile.fromJson(response.data as Map<String, dynamic>);
      await _sessionManager.saveSession(userProfile);
      return ApiResponse<UserProfile>(
        meta: response.meta,
        data: userProfile,
      );
    } else {
      return ApiResponse<UserProfile>(
        meta: response.meta,
        data: null,
      );
    }
  }

  Future<void> logout() async {
    await _sessionManager.clearSession();
  }

  Future<UserProfile?> getCurrentUser() {
    return _sessionManager.getSession();
  }
  
  Future<String?> getAccessToken() async {
    final session = await _sessionManager.getSession();
    return session?.token?.accessToken;
  }
}
