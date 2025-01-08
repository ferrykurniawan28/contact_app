import 'package:contact/presentations/detail/controllers/detail.dart';
import 'package:get/get.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactDetailController());
  }
}
