class District {
  final int disId;
  final String disName;
  final int cityId;

  District({
    required this.disId,
    required this.disName,
    required this.cityId,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      disId: json['dis_id'] as int,
      disName: json['dis_name'] as String,
      cityId: json['city_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dis_id': disId,
      'dis_name': disName,
      'city_id': cityId,
    };
  }
}
