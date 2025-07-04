
class OtpEntity {
  final String phone;
  final String otp;

  OtpEntity({
    required this.phone,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }
}
