class Credential {
  final int createdDate;
  final String type;
  final String? deviceName;
  final String? deviceModel;
  final String? alg;
  // Add other fields if you want

  Credential({
    required this.createdDate,
    required this.type,
    this.deviceName,
    this.deviceModel,
    this.alg,
  });

  factory Credential.fromJson(Map<String, dynamic> json) {
    return Credential(
      createdDate: json['createdDate'] ?? 0,
      type: json['type'] ?? '',
      deviceName: json['deviceName'],
      deviceModel: json['deviceModel'],
      alg: json['alg'],
    );
  }
}


class UserProfile {
  final String sub;
  final bool emailVerified;
  final List<Credential> credentials;
  final String name;
  final String preferredUsername;
  final String givenName;
  final String familyName;
  final String email;

  UserProfile({
    required this.sub,
    required this.emailVerified,
    required this.credentials,
    required this.name,
    required this.preferredUsername,
    required this.givenName,
    required this.familyName,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var credsJson = json['credentials'] as List<dynamic>? ?? [];
    List<Credential> creds = credsJson.map((e) => Credential.fromJson(e)).toList();

    return UserProfile(
      sub: json['sub'],
      emailVerified: json['email_verified'],
      credentials: creds,
      name: json['name'],
      preferredUsername: json['preferred_username'],
      givenName: json['given_name'],
      familyName: json['family_name'],
      email: json['email'],
    );
  }
}
