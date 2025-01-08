import 'package:contact/presentations/detail/controllers/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetail extends GetView<ContactDetailController> {
  const ContactDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: const Text('Contact Detail'),
          actions: [
            IconButton(
              icon: Obx(
                () => (!controller.isEdit.value)
                    ? const Icon(Icons.edit)
                    : const Icon(Icons.save),
              ),
              onPressed: controller.editContact,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(controller.contact.value.name[0]),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => (controller.isEdit.value)
                              ? TextFormField(
                                  controller: controller.nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                  ),
                                )
                              : Text(
                                  controller.contact.value.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                        Obx(() => (controller.isEdit.value)
                            ? TextFormField(
                                controller: controller.phoneController,
                                decoration: const InputDecoration(
                                  labelText: 'Phone',
                                ),
                              )
                            : Text(
                                controller.contact.value.phone,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: controller.deleteContact,
                child: const Text("Delete Contact"),
              ),
            ],
          ),
        ));
  }
}
