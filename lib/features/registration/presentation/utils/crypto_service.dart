import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/signers/rsa_signer.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/pointycastle.dart';


class KeyPair {
  final String publicKeyPem;
  final String privateKeyPem;

  KeyPair({required this.publicKeyPem, required this.privateKeyPem});
}

class CryptoService {
  /// Generate RSA key pair in PEM format
  Future<KeyPair> generatePemKeyPair({int bitLength = 2048}) async {
    final secureRandom = _createSecureRandom();

    final keyGen = RSAKeyGenerator()
      ..init(
        ParametersWithRandom(
          RSAKeyGeneratorParameters(BigInt.from(65537), bitLength, 12),
          secureRandom,
        ),
      );

    final keyPair = keyGen.generateKeyPair();
    final publicKey = keyPair.publicKey as RSAPublicKey;
    final privateKey = keyPair.privateKey as RSAPrivateKey;

    return KeyPair(
      publicKeyPem: _encodePublicKeyToPem(publicKey),
      privateKeyPem: _encodePrivateKeyToPem(privateKey),
    );
  }

  /// Sign a message with a private key in PEM format (Base64-encoded output)
  String signWithPem(String message, String privateKeyPem) {
    final privateKey = _parsePrivateKeyFromPem(privateKeyPem);

    final signer = RSASigner(SHA256Digest(), '0609608648016503040201')
      ..init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    final messageBytes = utf8.encode(message);
    final signature = signer.generateSignature(Uint8List.fromList(messageBytes));

    final base64Signature = base64Encode(signature.bytes);

    final doubleEncodedSignature = base64Encode(utf8.encode(base64Signature));

    return doubleEncodedSignature;
  }


  /// Parses private key PEM into RSAPrivateKey object
  RSAPrivateKey _parsePrivateKeyFromPem(String pem) {
    final bytes = _pemToBytes(pem, 'RSA PRIVATE KEY');
    final parser = ASN1Parser(bytes);
    final sequence = parser.nextObject() as ASN1Sequence;

    return RSAPrivateKey(
      (sequence.elements![1] as ASN1Integer).integer!,
      (sequence.elements![3] as ASN1Integer).integer!,
      (sequence.elements![4] as ASN1Integer).integer!,
      (sequence.elements![5] as ASN1Integer).integer!,
    );
  }

  /// Encodes RSAPublicKey to PEM
  String _encodePublicKeyToPem(RSAPublicKey publicKey) {
    final publicKeySequence = ASN1Sequence()
      ..add(ASN1Integer(publicKey.modulus!))
      ..add(ASN1Integer(publicKey.exponent!));
    final bitString = ASN1BitString(stringValues: publicKeySequence.encode());
    final algorithmIdentifier = ASN1Sequence()
      ..add(ASN1ObjectIdentifier.fromName('rsaEncryption'))
      ..add(ASN1Null());

    final topLevelSequence = ASN1Sequence()
      ..add(algorithmIdentifier)
      ..add(bitString);

    final base64Data = base64Encode(topLevelSequence.encode());
    return _wrapPem('PUBLIC KEY', base64Data);
  }

  /// Encodes RSAPrivateKey to PEM
  String _encodePrivateKeyToPem(RSAPrivateKey privateKey) {
    final asn1 = ASN1Sequence()
      ..add(ASN1Integer(BigInt.zero)) // Version
      ..add(ASN1Integer(privateKey.modulus!))
      ..add(ASN1Integer(privateKey.publicExponent!))
      ..add(ASN1Integer(privateKey.privateExponent!))
      ..add(ASN1Integer(privateKey.p!))
      ..add(ASN1Integer(privateKey.q!))
      ..add(ASN1Integer(privateKey.privateExponent! % (privateKey.p! - BigInt.one)))
      ..add(ASN1Integer(privateKey.privateExponent! % (privateKey.q! - BigInt.one)))
      ..add(ASN1Integer(privateKey.q!.modInverse(privateKey.p!)));

    final base64Data = base64Encode(asn1.encode());
    return _wrapPem('RSA PRIVATE KEY', base64Data);
  }

  /// Utility to wrap base64 with PEM headers
  String _wrapPem(String label, String base64Data) {
    return '-----BEGIN $label-----$base64Data-----END $label-----';
  }


  /// Converts PEM to bytes by stripping headers
  Uint8List _pemToBytes(String pem, String label) {
    final cleaned = pem
        .replaceAll('-----BEGIN $label-----', '')
        .replaceAll('-----END $label-----', '')
        .trim(); // no line breaks to remove anymore
    return base64Decode(cleaned);
  }


  /// Creates a secure FortunaRandom
  FortunaRandom _createSecureRandom() {
    final secureRandom = FortunaRandom();
    final seed = List<int>.generate(32, (_) => Random.secure().nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seed)));
    return secureRandom;
  }
}
