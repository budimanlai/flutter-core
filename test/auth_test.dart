import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/auth.dart';
import 'package:flutter_pkg/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:io';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null; // Allow real network calls

  // Mock Secure Storage
  FlutterSecureStorage.setMockInitialValues({});

  group('Auth Service Test', () {
    late ApiBase api;
    late AuthService authService;
    late SessionManager<UserProfile> sessionManager;

    setUp(() {
      api = ApiBase(debug: true);
      api.setBaseUrl("http://127.0.0.1:8081/api/v1");
      
      // Basic Auth for the Login endpoint itself?
      // User request said: * Auth: BasicAuth
      var auth = BasicAuth();
      auth.setUsername("5awzaHszTjyb6OnrbrHkmrLoBZuJs3RM");
      auth.setPassword("dk7RjMLdLb3NEazmbcJNepXK8SLpK5aPf4eihI2utCsXx3rQ5YsPV1H9ajaclTwc");
      api.setAuth(auth);

      sessionManager = SessionManager<UserProfile>(
        fromJson: (json) => UserProfile.fromJson(json),
      );
      authService = AuthService(api, sessionManager);
    });

    test('Login Success', () async {
      print('Attempting login...');
      final response = await authService.login(
        username: "6281381382525",
        password: "qwe123asd",
      );

      print('Login Message: ${response.meta.message}');
      
      if (response.meta.isSuccess) {
        final profile = response.data;
        expect(profile, isNotNull);
        print('Logged in as: ${profile?.fullname}');
        print('Token: ${profile?.token?.accessToken.substring(0, 10)}...');
        
        // Verify session storage
        final storedProfile = await sessionManager.getSession();
        expect(storedProfile, isNotNull);
        expect(storedProfile?.email, profile?.email);
        print('Session stored successfully.');
      } else {
        fail('Login failed: ${response.meta.message}');
      }
    });
  });
}
