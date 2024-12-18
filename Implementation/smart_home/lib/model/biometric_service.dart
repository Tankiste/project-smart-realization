import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isBiometricSupported() async {
    return await _localAuth.isDeviceSupported();
  }

  Future<bool> canCheckBiometrics() async {
    return await _localAuth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch (e) {
      print('Error during authentication : ${e.message}');
    }
    return authenticated;
  }
}
