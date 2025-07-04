class LoginChallengeRequestModel {
  final String username;


  LoginChallengeRequestModel({
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }


  factory LoginChallengeRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginChallengeRequestModel(
      username: json['username'],
    );
  }

}