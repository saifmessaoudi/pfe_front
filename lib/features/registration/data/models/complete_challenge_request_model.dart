
class CompleteChallengeRequestModel {
  final String challenge;
  final String signedChallenge;


  CompleteChallengeRequestModel({
    required this.challenge,
    required this.signedChallenge,
  });

  Map<String, dynamic> toJson() {
    return {
      'challenge': challenge,
      'signedChallenge': signedChallenge,
    };
  }

  factory CompleteChallengeRequestModel.fromJson(Map<String, dynamic> json) {
    return CompleteChallengeRequestModel(
      challenge: json['challenge'],
      signedChallenge: json['signedChallenge'],
    );
  }
}




