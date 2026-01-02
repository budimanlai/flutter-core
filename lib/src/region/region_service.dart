import 'package:flutter_pkg/http.dart';
import 'model/province.dart';
import 'model/city.dart';
import 'model/district.dart';
import 'model/sub_district.dart';

class RegionService {
  final ApiBase _api;

  RegionService(this._api);

  Future<ApiResponse<List<Province>>> getProvinces({int limit = 50}) async {
    final response = await _api.get(
      '/region/provinces',
      queryParameters: {'limit': limit},
    ) as ApiResponse;

    final List<dynamic> list = response.data ?? [];
    final provinces = list.map((e) => Province.fromJson(e as Map<String, dynamic>)).toList();

    return ApiResponse<List<Province>>(
      meta: response.meta,
      data: provinces,
    );
  }

  Future<ApiResponse<List<City>>> getCities({required int provinceId, int limit = 50}) async {
    final response = await _api.get(
      '/region/citys',
      queryParameters: {
        'province_id': provinceId,
        'limit': limit,
      },
    ) as ApiResponse;

    final List<dynamic> list = response.data ?? [];
    final cities = list.map((e) => City.fromJson(e as Map<String, dynamic>)).toList();

    return ApiResponse<List<City>>(
      meta: response.meta,
      data: cities,
    );
  }

  Future<ApiResponse<List<District>>> getDistricts({required int cityId, int limit = 20}) async {
    final response = await _api.get(
      '/region/districts',
      queryParameters: {
        'city_id': cityId,
        'limit': limit,
      },
    ) as ApiResponse;

    final List<dynamic> list = response.data ?? [];
    final districts = list.map((e) => District.fromJson(e as Map<String, dynamic>)).toList();

    return ApiResponse<List<District>>(
      meta: response.meta,
      data: districts,
    );
  }

  Future<ApiResponse<List<SubDistrict>>> getSubDistricts({required int districtId, int limit = 20}) async {
    final response = await _api.get(
      '/region/subdistricts',
      queryParameters: {
        'district_id': districtId,
        'limit': limit,
      },
    ) as ApiResponse;

    final List<dynamic> list = response.data ?? [];
    final subDistricts = list.map((e) => SubDistrict.fromJson(e as Map<String, dynamic>)).toList();

    return ApiResponse<List<SubDistrict>>(
      meta: response.meta,
      data: subDistricts,
    );
  }
}
