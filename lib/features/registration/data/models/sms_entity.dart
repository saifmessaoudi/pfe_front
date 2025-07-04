// entities/sms_entity.dart

class SmsEntity {
  final String phoneNumber;

  SmsEntity({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
    };
  }
}
