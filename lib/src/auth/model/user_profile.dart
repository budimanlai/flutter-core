import 'auth_token.dart';

class UserProfile {
  final int userId;
  final String email;
  final String handphone;
  final String fullname;
  final AuthToken? token;

  UserProfile({
    required this.userId,
    required this.email,
    required this.handphone,
    required this.fullname,
    this.token,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id'].toString()) ?? 0,
      email: json['email'] as String,
      handphone: json['handphone'] as String,
      fullname: json['fullname'] as String,
      token: json['token'] != null 
          ? AuthToken.fromJson(json['token'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'handphone': handphone,
      'fullname': fullname,
      if (token != null) 'token': token!.toJson(),
    };
  }
}
