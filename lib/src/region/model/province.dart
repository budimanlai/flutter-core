class Province {
  final int provId;
  final String provName;
  final int locationId;
  final int status;

  Province({
    required this.provId,
    required this.provName,
    required this.locationId,
    required this.status,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provId: json['prov_id'] as int,
      provName: json['prov_name'] as String,
      locationId: json['locationid'] as int,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prov_id': provId,
      'prov_name': provName,
      'locationid': locationId,
      'status': status,
    };
  }
}
