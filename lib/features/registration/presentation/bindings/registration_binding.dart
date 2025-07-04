import 'package:get/get.dart';
import '../../data/ds/registration_remote_ds.dart';
import '../../data/repositories/registration_repository_impl.dart';
import '../../domain/repositories/registration_repository.dart';
import '../../domain/usecases/initiate_registration_usecase.dart';
import '../controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<RegistrationRemoteDataSource>(
          () => RegistrationRemoteDataSourceImpl(),
    );

    // Repositories
    Get.lazyPut<RegistrationRepository>(
          () => RegistrationRepositoryImpl(),
    );

    // Use cases
    Get.lazyPut(
          () => InitiateRegistrationUseCase(Get.find<RegistrationRepository>()),
    );

    // Controllers
    Get.lazyPut(
          () => RegistrationController(
        initiateRegistrationUseCase: Get.find(),
      ),
    );
  }
}
