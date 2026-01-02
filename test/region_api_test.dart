import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pkg/http.dart';
import 'package:flutter_core/region.dart';

void main() {
  // Use a group to organize tests
  group('Region API Integration Test', () {
    late ApiBase api;
    late RegionService regionService;

    setUp(() {
      api = ApiBase();
      api.setBaseUrl("http://127.0.0.1:8081/api/v1");

      // Set Authentication
      var auth = BasicAuth();
      auth.setUsername("5awzaHszTjyb6OnrbrHkmrLoBZuJs3RM");
      auth.setPassword("dk7RjMLdLb3NEazmbcJNepXK8SLpK5aPf4eihI2utCsXx3rQ5YsPV1H9ajaclTwc");
      api.setAuth(auth);

      regionService = RegionService(api);
    });

    test('Fetch Provinces', () async {
      print('Fetching provinces...');
      try {
        final response = await regionService.getProvinces(limit: 5);
        print('Response Status: ${response.meta.message}');
        
        if (response.meta.isSuccess) {
          expect(response.data, isNotEmpty);
          print('Found ${response.data!.length} provinces.');
          for (var p in response.data!) {
            print(' - [${p.provId}] ${p.provName}');
          }
        } else {
          fail('API returned error: ${response.meta.message}');
        }
      } catch (e) {
        fail('Exception caught: $e');
      }
    });

    test('Fetch Cities from First Province', () async {
       try {
        // 1. Get Provinces first
        final provResponse = await regionService.getProvinces(limit: 1);
        if (!provResponse.meta.isSuccess || provResponse.data!.isEmpty) {
          fail('Could not fetch provinces to test cities.');
        }

        final province = provResponse.data!.first;
        print('\nFetching cities for Province: ${province.provName} (ID: ${province.provId})...');

        // 2. Get Cities
        final cityResponse = await regionService.getCities(provinceId: province.provId);
        
        if (cityResponse.meta.isSuccess) {
           // It's possible a province has no cities in some data sets, but usually it does.
           print('Found ${cityResponse.data?.length ?? 0} cities.');
           if (cityResponse.data != null && cityResponse.data!.isNotEmpty) {
             for (var c in cityResponse.data!.take(3)) {
               print(' - [${c.cityId}] ${c.cityName}');
             }
           }
        } else {
           fail('API returned error: ${cityResponse.meta.message}');
        }

       } catch (e) {
        fail('Exception caught: $e');
       }
    });
  });
}
