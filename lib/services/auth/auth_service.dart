import 'dart:convert';
import 'dart:developer' as console;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/providers/auth_provider.dart';
import 'package:web3auth_flutter/enums.dart' as web3_auth_enums;
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class AuthService {
  final WidgetRef ref;

  AuthService(this.ref);

  Future<Web3AuthResponse> loginWithGoogle() async {
    return _performWeb3AuthLogin(
      LoginParams(
        loginProvider: web3_auth_enums.Provider.google,
        mfaLevel: web3_auth_enums.MFALevel.OPTIONAL,
        curve: web3_auth_enums.Curve.secp256k1,
      ),
      "loginWithGoogle",
    );
  }

  Future<Web3AuthResponse> loginWithApple() async {
    return _performWeb3AuthLogin(
      LoginParams(
        loginProvider: web3_auth_enums.Provider.apple,
        mfaLevel: web3_auth_enums.MFALevel.OPTIONAL,
        curve: web3_auth_enums.Curve.secp256k1,
      ),
      "loginWithApple",
    );
  }

  Future<Web3AuthResponse> loginWithFacebook() async {
    return _performWeb3AuthLogin(
      LoginParams(
        loginProvider: web3_auth_enums.Provider.facebook,
        mfaLevel: web3_auth_enums.MFALevel.OPTIONAL,
        curve: web3_auth_enums.Curve.secp256k1,
      ),
      "loginWithFacebook",
    );
  }

  Future<Web3AuthResponse> loginWithTwitter() async {
    return _performWeb3AuthLogin(
      LoginParams(
        loginProvider: web3_auth_enums.Provider.twitter,
        mfaLevel: web3_auth_enums.MFALevel.OPTIONAL,
        curve: web3_auth_enums.Curve.secp256k1,
      ),
      "loginWithTwitter",
    );
  }

  Future<Web3AuthResponse> loginWithEmailPasswordless(String userEmail) async {
    return _performWeb3AuthLogin(
      LoginParams(
        loginProvider: web3_auth_enums.Provider.email_passwordless,
        extraLoginOptions: ExtraLoginOptions(login_hint: userEmail),
        mfaLevel: web3_auth_enums.MFALevel.OPTIONAL,
        curve: web3_auth_enums.Curve.secp256k1,
      ),
      "loginWithEmailPasswordless",
    );
  }

  Future<Web3AuthResponse> _performWeb3AuthLogin(
    LoginParams loginParams,
    String methodName,
  ) async {
    try {
      ref.read(authProvider.notifier).setLoading();
      final Web3AuthResponse response = await Web3AuthFlutter.login(
        loginParams,
      );
      String jsResp = JsonEncoder.withIndent('').convert(response);
      console.log("AuthService: $methodName - Response: $jsResp");
      ref.read(logoutVisibleProvider.notifier).state = true;
      ref.read(authProvider.notifier).setAuthenticated();
      return response;
    } catch (e) {
      console.log(
        "AuthService: $methodName - Error during Web3AuthFlutter.login: $e",
      );
      ref.read(authProvider.notifier).setUnauthenticated();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await Web3AuthFlutter.logout();
      console.log("AuthService: Web3AuthFlutter.logout() successful.");
      ref.read(logoutVisibleProvider.notifier).state = false;
      ref.read(authProvider.notifier).setUnauthenticated();
    } on UserCancelledException {
      console.log("AuthService: User cancelled.");
    } on UnKnownException {
      console.log("AuthService: Unknown exception occurred");
    }
  }
}
