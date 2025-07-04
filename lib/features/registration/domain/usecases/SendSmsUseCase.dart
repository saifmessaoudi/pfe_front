// usecases/send_sms_usecase.dart


import '../../data/models/sms_entity.dart';
import '../../data/repositories/sms_repository.dart';

class SendSmsUseCase {
  final SmsRepository smsRepository;

  SendSmsUseCase(this.smsRepository);

  Future<bool> execute(SmsEntity smsEntity) {
    return smsRepository.sendSms(smsEntity);
  }
}
