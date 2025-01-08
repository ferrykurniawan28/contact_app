import 'package:contact/routes/routename.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        Get.offAllNamed(RoutesName.home);
      }).catchError((onError) {
        Get.snackbar('Error', onError.toString(),
            snackPosition: SnackPosition.BOTTOM);
      });
      isLoading.value = false;
    }
  }
}
