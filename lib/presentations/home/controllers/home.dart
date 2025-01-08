import 'package:contact/data/models/contact.dart';
import 'package:contact/data/services/contact.dart';
import 'package:contact/routes/routename.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Contact> contacts = <Contact>[].obs;
  final auth = FirebaseAuth.instance;
  final contactService = ContactService();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getContacts();
    super.onInit();
  }

  void getContacts() async {
    isLoading.value = true;
    contacts.value = await contactService.fetchContacts();
    isLoading.value = false;
  }

  void addContact() {
    //open dialog
    Get.defaultDialog(
      title: 'Add Contact',
      content: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(hintText: 'Phone'),
              validator: (value) {
                if (value!.isEmpty || !value.contains(RegExp(r'^[0-9]+$'))) {
                  return 'Invalid phone number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              Contact newContact = Contact(
                name: nameController.text,
                phone: phoneController.text,
              );
              await contactService.postContact(newContact);
              contacts.add(newContact);
              Get.back();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
    nameController.clear();
    phoneController.clear();
  }

  void logout() {
    auth.signOut();
    Get.offAllNamed(RoutesName.login);
  }
}
