import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/flutter/pages/register/register_page_presenter.dart';
import 'package:flutter_clean_todo/getx/presenters/stream_subscription_manager.dart';
import 'package:get/get.dart';

class GetxRegisterPresenter extends GetxController
    with StreamSubscriptionManager
    implements RegisterPagePresenter {
  final RxBool _isRegistering = RxBool(false);
  final Rx<String?> _errorRx = Rx(null);

  final AuthService _authService;

  GetxRegisterPresenter(this._authService) {
    addStreamList([_isRegistering.stream]);
  }

  @override
  bool get isRegistering => _isRegistering.value;

  @override
  Future<void> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      _isRegistering.value = true;
      _errorRx.value = null;
      await _authService.registerWithEmailAndPassword(
          name: name, email: email, password: password);
    } on FirebaseAuthException catch (e, s) {
      _errorRx.value = e.message;
    } catch (e, s) {
      print(e);
      print(s);
      _errorRx.value =
          "Something went wrong when trying to register with email and password";
    } finally {
      _isRegistering.value = false;
    }
  }

  @override
  Stream<String?> get errorStream => _errorRx.stream;

  @override
  void navigateToLoginScreen() {
    Get.offAllNamed("/login");
  }

  @override
  void dispose() {
    clearSubscriptions();
    super.dispose();
  }
}
