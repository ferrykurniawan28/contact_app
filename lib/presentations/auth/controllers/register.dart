import 'package:contact/routes/routename.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void register() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      auth
          .createUserWithEmailAndPassword(
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
