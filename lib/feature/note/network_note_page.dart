import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitcore_note/feature/note/network_note_controller.dart';
import 'package:suitcore_note/routes/page_names.dart';

class NetworkNotePage extends GetView<NetworkNoteController> {
  const NetworkNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<NetworkNoteController>(
          init: NetworkNoteController(),
          builder: (_) {
            if (!controller.isLoading) {
              if (!controller.isEmptyData) {
                return SmartRefresher(
                  enablePullDown: true,
                  controller: controller.refreshController,
                  onRefresh: controller.getAllNotes,
                  child: MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    mainAxisSpacing: 5,
                    itemCount: controller.dataList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => Get.toNamed(PageName.NOTE +
                                '/${controller.dataList[index].id}')!
                            .then((value) {
                          if (value == true) {
                            controller.getAllNotes();
                          }
                        }),
                        onLongPress: () {
                          Get.defaultDialog(
                            title: 'Save Note',
                            radius: 10,
                            content: const Text(
                              'This action will save selected note to database',
                            ),
                            confirm: TextButton(
                              onPressed: () => controller
                                  .saveNote(controller.dataList[index]),
                              child: const Text('Save'),
                            ),
                            cancel: TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Cancel'),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.grey.shade100,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.dataList[index].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  DateFormat('dd MMM yyyy HH:mm').format(
                                    DateTime.parse(controller
                                            .dataList[index].updatedAt)
                                        .toLocal(),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Text(
                                  controller.dataList[index].body,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(height: 15),
                                Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: List.generate(
                                    controller.dataList[index].tags.length,
                                    (tagIndex) => Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Text(
                                        '#${controller.dataList[index].tags[tagIndex]}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return SmartRefresher(
                enablePullDown: true,
                controller: controller.refreshController,
                onRefresh: controller.getAllNotes,
                child: const Center(
                  key: ValueKey('empty_note'),
                  child: Text(
                    'Empty Notes',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(PageName.ADDNEWNOTE)!.then((value) {
          if (value == true) {
            controller.getAllNotes();
          }
        }),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
