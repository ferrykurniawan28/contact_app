import 'package:contact/data/models/contact.dart';
import 'package:contact/presentations/home/controllers/home.dart';
import 'package:contact/routes/routename.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchContactDelegate(controller.contacts),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => controller.addContact(),
          ),
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Obx(
        () => (controller.isLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (controller.contacts.isEmpty)
                ? const Center(
                    child: Text('No contacts yet!'),
                  )
                : ListView.builder(
                    itemCount: controller.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = controller.contacts[index];
                      return InkWell(
                        onTap: () =>
                            Get.toNamed(RoutesName.detail, arguments: contact),
                        child: ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.phone),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class SearchContactDelegate extends SearchDelegate {
  final List<Contact> contacts;

  SearchContactDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contacts.where((contact) {
      return contact.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results[index];
        return InkWell(
          onTap: () => Get.toNamed(RoutesName.detail, arguments: contact),
          child: ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = contacts.where((contact) {
      return contact.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results[index];
        return InkWell(
          onTap: () => Get.toNamed(RoutesName.detail, arguments: contact),
          child: ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
          ),
        );
      },
    );
  }
}
