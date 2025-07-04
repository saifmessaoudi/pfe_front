import '../../domain/entities/device_info.dart';

class PasskeyRequestModel {
  final String jwtChallenge;
  final String signedJwtChallenge;
  final String publicKey;
  final DeviceInfoModel deviceInfo;

  PasskeyRequestModel({
    required this.jwtChallenge,
    required this.signedJwtChallenge,
    required this.publicKey,
    required this.deviceInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'jwtChallenge': jwtChallenge,
      'signedJwtChallenge': signedJwtChallenge,
      'publicKey': publicKey,
      'deviceInfo': deviceInfo.toJson(),
    };
  }

  factory PasskeyRequestModel.fromJson(Map<String, dynamic> json) {
    return PasskeyRequestModel(
      jwtChallenge: json['jwtChallenge'],
      signedJwtChallenge: json['signedJwtChallenge'],
      publicKey: json['publicKey'],
      deviceInfo: DeviceInfoModel.fromJson(json['deviceInfo']),
    );
  }
}




