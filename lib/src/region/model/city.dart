class City {
  final int cityId;
  final String cityName;
  final int provId;

  City({
    required this.cityId,
    required this.cityName,
    required this.provId,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['city_id'] as int,
      cityName: json['city_name'] as String,
      provId: json['prov_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city_id': cityId,
      'city_name': cityName,
      'prov_id': provId,
    };
  }
}
