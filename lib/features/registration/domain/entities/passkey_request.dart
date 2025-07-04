import 'package:mobile_authenticator_fido/features/registration/domain/entities/device_info.dart';

class PasskeyRequest {
  final String jwtChallenge;
  final String signedJwtChallenge;
  final String publicKey;
   final DeviceInfoModel deviceInfo;

  PasskeyRequest({
    required this.jwtChallenge,
    required this.signedJwtChallenge,
    required this.publicKey,
    required this.deviceInfo,
  });
}
