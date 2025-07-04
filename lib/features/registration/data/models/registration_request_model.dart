class RegistrationRequestModel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  RegistrationRequestModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    return RegistrationRequestModel(
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
