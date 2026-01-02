import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pkg/http.dart';
import 'package:flutter_core/region.dart';

void main() {
  test('RegionService instantiation', () {
    final api = ApiBase();
    final service = RegionService(api);
    expect(service, isNotNull);
  });

  test('Models instantiation', () {
    final prov = Province(provId: 1, provName: 'A', locationId: 1, status: 1);
    expect(prov.provName, 'A');
    
    final city = City(cityId: 1, cityName: 'B', provId: 1);
    expect(city.cityName, 'B');
  });
}
