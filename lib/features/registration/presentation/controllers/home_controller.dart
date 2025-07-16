import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/core/config/http/dio_client.dart';
import 'package:mobile_authenticator_fido/core/utils/logger/logger.dart';

import '../../../../core/config/constants/api_constants.dart';
import '../../domain/entities/profile_info.dart';
import '../utils/secure_storage_mig.dart';

class HomeController extends GetxController {
  DioClient dioClient = DioClient();
  final RxString username = 'Saif'.obs;
  var userProfile = Rxn<UserProfile>();
  final SecureStorageServiceMig _secureStorageService = Get.find();

  @override
  void onInit() {
    super.onInit();
    // Fetch user profile when the controller is initialized
    LoggerService.i('HomeController initialized, fetching user profile...');
  }

  Future<void> fetchUserProfile() async {
    final token = await _secureStorageService.readAccessToken();

    final response = await dioClient.get(
      ApiConstants.getProfile,
      options: Options(
        headers: {
          ApiConstants.authorization: 'Bearer $token',
          ApiConstants.contentType: ApiConstants.applicationJson,
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      userProfile.value = UserProfile.fromJson(data);
      // Optionally, you can also set the username from the profile
      if (userProfile.value != null) {
        setUsername(userProfile.value!.preferredUsername);
      }
    } else {
      // handle error
      throw Exception('Failed to load user profile');
    }
  }

  void setUsername(String name) {
    username.value = name;
  }
}
