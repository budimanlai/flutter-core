# flutter_core

This package contains the core business logic, services, and models for the application. It is built on top of `flutter_pkg`.

## Modules

The package consists of several key modules:

### 1. Authentication
Handles user login, session management, and secure storage of credentials.

- **Classes**: `AuthService`, `SessionManager<T>`, `UserProfile`, `AuthToken`
- **Documentation**: [docs/auth_module.md](docs/auth_module.md)

### 2. Region
Provides access to regional data including Provinces, Cities, Districts, and SubDistricts.

- **Classes**: `RegionService`, `Province`, `City`, `District`, `SubDistrict`
- **Documentation**: [docs/region_module.md](docs/region_module.md)

## Installation

Add the dependency to your project's `pubspec.yaml`:

```yaml
dependencies:
  flutter_core:
    path: /path/to/flutter-core
```

## Quick Usage

### Authentication
```dart
import 'package:flutter_core/auth.dart';
import 'package:flutter_pkg/http.dart';

void main() async {
  var api = ApiBase();
  // ... configure api ...
  
  var session = SessionManager<UserProfile>(
    fromJson: (json) => UserProfile.fromJson(json),
  );
  var auth = AuthService(api, session);
  
  await auth.login(username: "user", password: "pw");
}
```

### Region
```dart
import 'package:flutter_core/region.dart';
import 'package:flutter_pkg/http.dart';

void main() async {
  var api = ApiBase();
  var region = RegionService(api);
  
  var provinces = await region.getProvinces();
}
```

## Testing

Integration tests are available to verify connectivity with the backend API.

```bash
flutter test test/auth_test.dart
flutter test test/region_api_test.dart
```
