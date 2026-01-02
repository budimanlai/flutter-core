class SubDistrict {
  final int subDisId;
  final String subDisName;
  final int disId;

  SubDistrict({
    required this.subDisId,
    required this.subDisName,
    required this.disId,
  });

  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      subDisId: json['subdis_id'] as int,
      subDisName: json['subdis_name'] as String,
      disId: json['dis_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subdis_id': subDisId,
      'subdis_name': subDisName,
      'dis_id': disId,
    };
  }
}
