class PasskeyResponseModel {
  final int? statusCode;
  final String? message;
  final UserRepresentationModel? response;

  PasskeyResponseModel({
    this.statusCode,
    this.message,
    this.response,
  });

  factory PasskeyResponseModel.fromJson(Map<String, dynamic> json) {
    return PasskeyResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      response: json['response'] != null
          ? UserRepresentationModel.fromJson(json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (statusCode != null) 'statusCode': statusCode,
      if (message != null) 'message': message,
      if (response != null) 'response': response!.toJson(),
    };
  }
}
class UserRepresentationModel {
  final String? id;
  final String? username;
  final bool? enabled;
  final bool? emailVerified;
  final String? firstName;
  final String? lastName;
  final String? email;

  UserRepresentationModel({
    this.id,
    this.username,
    this.enabled,
    this.emailVerified,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory UserRepresentationModel.fromJson(Map<String, dynamic> json) {
    return UserRepresentationModel(
      id: json['id'],
      username: json['username'],
      enabled: json['enabled'],
      emailVerified: json['emailVerified'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (enabled != null) 'enabled': enabled,
      if (emailVerified != null) 'emailVerified': emailVerified,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (email != null) 'email': email,
    };
  }
}
