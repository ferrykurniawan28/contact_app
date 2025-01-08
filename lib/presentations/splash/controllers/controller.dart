import 'package:contact/routes/routename.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        // print(user!.uid);
        Get.offAllNamed(RoutesName.home);
      } else {
        Get.offAllNamed(RoutesName.login);
      }
    });
    super.onInit();
  }
}
