import 'package:contact/data/models/contact.dart';
import 'package:contact/data/services/contact.dart';
import 'package:contact/presentations/home/controllers/home.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ContactDetailController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Rx<Contact> contact = Rx<Contact>(Get.arguments as Contact);
  RxBool isEdit = false.obs;
  final contactService = ContactService();
  final homeController = Get.find<HomeController>();

  @override
  void onInit() {
    nameController.text = contact.value.name;
    phoneController.text = contact.value.phone;
    super.onInit();
  }

  void editContact() {
    isEdit.value = !isEdit.value;

    // if isEdit is false, reset the text field and update the contact
    if (!isEdit.value) {
      updateContact();
    }
  }

  void deleteContact() async {
    await contactService.deleteContact(contact.value.key!);
    homeController.getContacts();
    Get.back();
  }

  void updateContact() async {
    if (nameController.text != contact.value.name ||
        phoneController.text != contact.value.phone) {
      final updateContact = Contact(
        name: nameController.text,
        phone: phoneController.text,
        key: contact.value.key,
      );
      await contactService.editContact(updateContact);
      contact.value = updateContact;
      homeController.getContacts();
    }
    // Get.back();
  }
}
