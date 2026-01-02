# Authentication Module Documentation

This module provides functionality for User Authentication (Login) and Secure Session Management.

## Installation

Ensure `flutter_core` and `flutter_secure_storage` dependencies are configured.
Note: For Android, make sure to follow `flutter_secure_storage` setup (minSdkVersion 18, etc.).

## Usage

### 1. Import the Library

```dart
import 'package:flutter_pkg/http.dart';
import 'package:flutter_core/auth.dart';
```

### 2. Setup Components

The module uses Dependency Injection style setup. You need to configure `ApiBase` and `SessionManager` before creating `AuthService`.

#### Session Manager
`SessionManager` is a generic class `SessionManager<T>`. You must provide a `fromJson` factory method to deserialize your User Profile object.

```dart
// Initialize Session Manager for UserProfile
var sessionManager = SessionManager<UserProfile>(
  fromJson: (json) => UserProfile.fromJson(json),
);
```

#### Auth Service
Pass the API instance and the Session Manager to `AuthService`.

```dart
var api = ApiBase();
api.setBaseUrl("https://api.example.com");

var authService = AuthService(api, sessionManager);
```

### 3. Login

```dart
try {
  var response = await authService.login(
    username: "testuser",
    password: "password123",
  );

  if (response.meta.isSuccess) {
    UserProfile user = response.data!;
    print("Welcome ${user.fullname}");
  } else {
    print("Login Failed: ${response.meta.message}");
  }
} catch (e) {
  print("Error: $e");
}
```

### 4. Session Management

The `AuthService` (and `SessionManager`) handles storing the session securely using `flutter_secure_storage`.

#### Get Current User
```dart
UserProfile? currentUser = await authService.getCurrentUser();
if (currentUser != null) {
  print("Logged in as: ${currentUser.email}");
}
```

#### Get Access Token
```dart
String? token = await authService.getAccessToken();
```

#### Logout
Clears the secure storage.
```dart
await authService.logout();
```

## Custom User Profile

If you have a different User Profile structure in another project, you can reuse `SessionManager` with your own model.

```dart
class MyCustomModel {
  final String id;
  MyCustomModel({required this.id});
  
  factory MyCustomModel.fromJson(Map<String, dynamic> json) {
    return MyCustomModel(id: json['id']);
  }
  
  Map<String, dynamic> toJson() => {'id': id};
}

// Setup
var customSession = SessionManager<MyCustomModel>(
  fromJson: (json) => MyCustomModel.fromJson(json),
);

// Save manually if needed, or create a custom service wrapping this
await customSession.saveSession(myModel);
```
