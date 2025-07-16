import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/core/utils/manager/SessionManager.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/usecases/complete_login_usecase.dart';

import '../../../../core/utils/exception/ErrorHandler.dart';
import '../../../../core/utils/logger/logger.dart';
import '../../data/models/complete_challenge_request_model.dart';
import '../../data/models/login_challenge_request_model.dart';
import '../../domain/usecases/initiate_login_usecase.dart';
import '../utils/biometric_service.dart';
import '../utils/crypto_service.dart';
import '../utils/secure_storage_mig.dart';

class LoginChallengeController extends GetxController {
  final InitiateLoginChallengeUseCase _initiateUseCase;
  final CompleteLoginChallengeUseCase _completeUseCase;
  final CryptoService _cryptoService;
  final BiometricService _biometricService;
  final SecureStorageServiceMig _secureStorageService = Get.find();
  final ErrorHandlerService _errorHandlerService =
      Get.find(); // Inject the error handler service

  LoginChallengeController({
    required InitiateLoginChallengeUseCase initiateUseCase,
    required CompleteLoginChallengeUseCase completeUseCase,
    required CryptoService cryptoService,
    required BiometricService biometricService,
  }) : _completeUseCase = completeUseCase,
       _initiateUseCase = initiateUseCase,
       _cryptoService = cryptoService,
       _biometricService = biometricService;

  final RxBool isLoading = false.obs;
  String? username;
  final RxString errorMessage = ''.obs;
  final RxBool shouldGenerateKey = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      // Initialize username and shouldGenerateKey from arguments
      username = await _secureStorageService.readUsername();

      shouldGenerateKey.value = Get.arguments?['shouldGenerateKey'] ?? false;

      // Vérifier si la biométrie est disponible
      if (await _biometricService.canAuthenticate() == false) {
        errorMessage.value =
            'L\'authentification biométrique n\'est pas disponible sur cet appareil.';
        LoggerService.e(errorMessage.value);
        return;
      }

      // Vérifier si le nom d'utilisateur est chargé
      if (username == null || username!.isEmpty) {
        errorMessage.value =
            'Aucune identité trouvée. Veuillez vous enregistrer.';
        LoggerService.e(errorMessage.value);
        return;
      }

      // Initialiser le défi de connexion
      await initiateLoginChallenge();
    } catch (e) {
      // Use centralized error handler
      errorMessage.value = _errorHandlerService.handleError(e);
      LoggerService.e(errorMessage.value);
    }
  }


  Future<void> initiateLoginChallenge() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final request = LoginChallengeRequestModel(username: username!);
      final response = await _initiateUseCase.call(request);

      LoggerService.d('Login Challenge Initiated: ${response.response}');

      if (response.statusCode == 200) {

        final challenge = response.response.challenge;
        String? privateKey;
        String signedChallenge;
        try {
          privateKey = await _biometricService.readPrivateKey(username!);
          if (privateKey == null && shouldGenerateKey.value) {
            // Generate new key pair if none exists and we're allowed to
            final keyPair = await _cryptoService.generatePemKeyPair();
            privateKey = keyPair.privateKeyPem;

            // Store the new key
            await _biometricService.writePrivateKey(username!, privateKey);
            await _secureStorageService.writeUsername(username!);
          }
          if (privateKey == null) {
            throw Exception('No private key available');
          }
          signedChallenge = _cryptoService.signWithPem(challenge, privateKey);

          final completeRequest = CompleteChallengeRequestModel(
            challenge: challenge,
            signedChallenge: signedChallenge,
          );
          final completeResponse = await _completeUseCase.call(completeRequest);

          if (completeResponse.statusCode == 200) {
            LoggerService.d(
              'Challenge signed successfully: ${completeResponse.response}',
            );
            await SessionManager().saveAccessToken(
              completeResponse.response['access_token'],
            );
            navigateToHome();
          } else {
            // Handle error response
            errorMessage.value =
                'Erreur lors de la signature du défi de connexion';
            LoggerService.e(errorMessage.value);
          }
        } catch (e) {
          errorMessage.value = _errorHandlerService.handleError(e);
          LoggerService.e(errorMessage.value);
        }
      } else {
        // Handle error response
        errorMessage.value = 'Erreur processus de connexion annulée';
        LoggerService.e(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = _errorHandlerService.handleError(e);
      Get.snackbar('Erreur de connexion', errorMessage.value);
      LoggerService.e(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToHome() {
    Get.offAllNamed('root');
  }
}
