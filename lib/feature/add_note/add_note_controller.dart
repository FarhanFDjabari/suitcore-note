import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_note/data/remote/api_services.dart';
import 'package:suitcore_note/data/remote/base/base_object_controller.dart';
import 'package:suitcore_note/data/remote/errorhandler/error_handler.dart';

import 'package:suitcore_note/model/note.dart';

class AddNoteController extends BaseObjectController<Note> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  late TextEditingController tagController;
  var tags = <String>[];
  var isNoteUploaded = false;

  @override
  void onInit() async {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    tagController = TextEditingController();
    super.onInit();
  }

  void removeTag(String value) {
    tags.remove(value);
    update();
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.clear();
      update();
    }
  }

  void addNewNote() async {
    loadingState();
    final newNote = Note(
      id: 'dummy',
      title: titleController.text,
      tags: tags,
      body: bodyController.text,
      createdAt: '0',
      updatedAt: '0',
    );

    await client.then(
      (value) => value.addNewNote(newNote).validateStatus().then((data) {
        isNoteUploaded = true;
        finishLoadData();
        Get.back(result: true);
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 2),
            message: data.message,
          ),
        );
      }).handleError((onError) {
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
      }),
    );
  }
}
