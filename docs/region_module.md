# Region Module Documentation

This module provides functionality to fetch region data (Provinces, Cities, Districts, SubDistricts) using the `RegionService`. It relies on the `ApiBase` class from `flutter_pkg`.

## Installation

Ensure `flutter_core` is added to your project's dependencies. This module comes built-in with `flutter_core`.

```yaml
dependencies:
  flutter_core:
    path: /path/to/flutter-core
```

## Usage

### 1. Import the Library

```dart
import 'package:flutter_pkg/http.dart';
import 'package:flutter_core/region.dart';
```

### 2. Initialize ApiBase and RegionService

You need to provide an instance of `ApiBase` (configured with your Base URL and Auth) to `RegionService`.

```dart
void main() async {
  // 1. Setup API Base
  var api = ApiBase();
  api.setBaseUrl("https://api.example.com");
  
  // Optional: Set Authentication
  // var auth = BasicAuth();
  // auth.setUsername("user");
  // auth.setPassword("pass");
  // api.setAuth(auth);

  // 2. Initialize RegionService
  var regionService = RegionService(api);

  // 3. Fetch Data
  await fetchProvinces(regionService);
}
```

### 3. API Methods

#### Get Provinces
Fetch a list of provinces.

**Parameters:**
- `limit` (int, default: 50): Number of records to fetch.

```dart
Future<void> fetchProvinces(RegionService service) async {
  try {
    var response = await service.getProvinces(limit: 100);
    
    if (response.meta.isSuccess) {
      List<Province> provinces = response.data!;
      for (var province in provinces) {
        print("ID: ${province.provId}, Name: ${province.provName}");
      }
    } else {
      print("Error: ${response.meta.message}");
    }
  } catch (e) {
    print("Exception: $e");
  }
}
```

#### Get Cities
Fetch cities based on a Province ID.

**Parameters:**
- `provinceId` (required, int): The ID of the province.
- `limit` (int, default: 50).

```dart
var response = await service.getCities(provinceId: 11);
```

#### Get Districts
Fetch districts based on a City ID.

**Parameters:**
- `cityId` (required, int): The ID of the city.
- `limit` (int, default: 20).

```dart
var response = await service.getDistricts(cityId: 152);
```

#### Get SubDistricts
Fetch sub-districts based on a District ID.

**Parameters:**
- `districtId` (required, int): The ID of the district.
- `limit` (int, default: 20).

```dart
var response = await service.getSubDistricts(districtId: 1934);
```

## Data Models

The module includes the following models:

- **Province**: `provId`, `provName`, `locationId`, `status`
- **City**: `cityId`, `cityName`, `provId`
- **District**: `disId`, `disName`, `cityId`
- **SubDistrict**: `subDisId`, `subDisName`, `disId`
