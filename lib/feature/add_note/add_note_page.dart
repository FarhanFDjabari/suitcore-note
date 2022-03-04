import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suitcore_note/feature/add_note/add_note_controller.dart';

class AddNotePage extends GetView<AddNoteController> {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(result: controller.isNoteUploaded),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<AddNoteController>(
        init: AddNoteController(),
        initState: (_) {},
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: !controller.isLoading
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller.titleController,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Note Title',
                            hintStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy HH:mm').format(
                            DateTime.parse(DateTime.now().toIso8601String())
                                .toLocal(),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: 1),
                        TextField(
                          controller: controller.bodyController,
                          textInputAction: TextInputAction.newline,
                          textCapitalization: TextCapitalization.sentences,
                          autofocus: false,
                          minLines: 10,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.all(0),
                            hintText: '....',
                            hintStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        GetBuilder<AddNoteController>(
                          init: AddNoteController(),
                          initState: (_) {},
                          builder: (_) {
                            return Wrap(
                              direction: Axis.horizontal,
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                controller.tags.length,
                                (tagIndex) => InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () => controller
                                      .removeTag(controller.tags[tagIndex]),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Text(
                                      '#${controller.tags[tagIndex]} \t X',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              width: 70,
                              child: TextField(
                                controller: controller.tagController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  prefixText: '# ',
                                  hintText: 'New tag',
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (value) {
                                  controller.addTag();
                                },
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.addTag(),
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.add_rounded),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => controller.addNewNote(),
                              style: TextButton.styleFrom(
                                primary: Colors.black38,
                              ),
                              child: const Text(
                                'Add New Note',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
