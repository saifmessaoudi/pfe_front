import 'package:mobile_authenticator_fido/core/utils/logger/logger.dart';
import 'package:mobile_authenticator_fido/core/config/http/exceptions/api_exception.dart';
import 'package:biometric_storage/biometric_storage.dart';

class ErrorHandlerService {
  String handleError(Object error) {
    // Handle different error types
    if (error is ApiException) {
      return _handleApiError(error);
    } else if (error is AuthException) {
      return _handleAuthException(error);
    } else if (error is Exception) {
      return _handleGeneralException(error);
    } else {
      return 'Une erreur inattendue est survenue.';
    }
  }

  String _handleApiError(ApiException error) {
    LoggerService.e('API Error: ${error.message}');
    LoggerService.e('API Status Code: ${error.statusCode}');
    // Handle specific status codes, including 401 for JWT expiration
    switch (error.statusCode) {
      case 400:
        return 'Requête incorrecte, veuillez vérifier les informations.';
      case 401:
        return 'Votre session a expiré. Veuillez vous reconnecter.';  // Custom message for JWT expiration
      case 500:
        return 'Erreur serveur interne. Veuillez réessayer plus tard.';
      default:
        return error.message ?? 'Une erreur API est survenue.';
    }
  }

  String _handleAuthException(AuthException error) {
    if (error.code == AuthExceptionCode.userCanceled) {
      return 'Vous avez annulé l\'authentification biométrique.';
    }
    return 'Erreur d\'authentification biométrique.';
  }

  String _handleGeneralException(Exception error) {
    LoggerService.e('General Error: $error');
    return 'Une erreur inattendue est survenue.';
  }
}
