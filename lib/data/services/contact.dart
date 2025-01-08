import 'package:contact/data/models/contact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactService {
  final contactLink =
      "https://contact-app-f1ae3-default-rtdb.asia-southeast1.firebasedatabase.app/contactlist";
  User? user = FirebaseAuth.instance.currentUser;

  // fetch contacts
  Future<List<Contact>> fetchContacts() async {
    if (user == null) {
      throw Exception("User not logged in.");
    }

    try {
      final response = await http.get(
        Uri.parse('$contactLink/${user!.uid}.json'),
      );

      if (response.statusCode >= 400) {
        throw Exception("Failed to fetch contacts.");
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List<Contact> contacts = [];

      if (data.isEmpty) {
        return [];
      }

      data.forEach((key, value) {
        contacts.add(Contact(
          key: key,
          name: value['name'],
          phone: value['phone'],
        ));
      });

      return contacts;
    } catch (e) {
      if (e is Exception) {
        Get.snackbar("Error", e.toString());
      }
      // Get.snackbar("Error", e.toString());
      return [];
    }
  }

  // post contact
  Future<void> postContact(Contact contact) async {
    if (user == null) {
      throw Exception("User not logged in.");
    }

    try {
      final data = {
        'name': contact.name,
        'phone': contact.phone,
      };

      final response = await http.post(
          Uri.parse('$contactLink/${user!.uid}.json'),
          body: json.encode(data),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode >= 400) {
        throw Exception("Failed to post contact.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // edit contact
  Future<void> editContact(Contact contact) async {
    if (user == null) {
      throw Exception("User not logged in.");
    }

    try {
      final data = {
        'name': contact.name,
        'phone': contact.phone,
      };

      final response = await http.put(
          Uri.parse('$contactLink/${user!.uid}/${contact.key}.json'),
          body: json.encode(data),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode >= 400) {
        throw Exception("Failed to edit contact.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // delete contact
  Future<void> deleteContact(
    String key,
  ) async {
    if (user == null) {
      throw Exception("User not logged in.");
    }

    try {
      final response = await http.delete(
        Uri.parse('$contactLink/${user!.uid}/$key.json'),
      );

      if (response.statusCode >= 400) {
        throw Exception("Failed to delete contact.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
