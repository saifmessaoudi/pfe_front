package com.example.mobile_authenticator_fido

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.biometric.BiometricManager

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "biometric_info_android"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getBiometricTypes") {
                val types = getAvailableBiometricTypes()
                result.success(types)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAvailableBiometricTypes(): List<String> {
        val features = mutableListOf<String>()

        val hasFingerprint = packageManager.hasSystemFeature(PackageManager.FEATURE_FINGERPRINT)
        if (hasFingerprint) features.add("Fingerprint")

        val hasFace = packageManager.hasSystemFeature(PackageManager.FEATURE_FACE) ||
                packageManager.hasSystemFeature("android.hardware.face")
        if (hasFace) features.add("Face")

        val hasIris = packageManager.hasSystemFeature("android.hardware.biometrics.iris") ||
                packageManager.hasSystemFeature("android.hardware.iris")
        if (hasIris) features.add("Iris")

        return features
    }
}
