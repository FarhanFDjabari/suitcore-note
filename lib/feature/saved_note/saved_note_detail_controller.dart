import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_note/data/local/hive/hive_constants.dart';
import 'package:suitcore_note/data/local/hive/hive_helper.dart';
import 'package:suitcore_note/data/remote/base/base_object_controller.dart';
import 'package:suitcore_note/model/note.dart';

class SavedNoteDetailController extends BaseObjectController<Note> {
  var hiveHelper = HiveHelper<Note>();
  late TextEditingController titleController;
  late TextEditingController tagController;
  late TextEditingController bodyController;
  var tags = <String>[];
  late Note note;

  @override
  void onInit() async {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    tagController = TextEditingController();
    note = Note(
      id: 'test',
      tags: tags,
      title: '',
      body: '',
      createdAt: '',
      updatedAt: '',
    );

    await fetchNoteData(Get.parameters['id'] ?? '0');

    super.onInit();
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.clear();
      update();
    }
  }

  void removeTag(String value) {
    tags.remove(value);
    update();
  }

  Future<void> fetchNoteData(String id) async {
    loadingState();
    try {
      note = hiveHelper.box.get(id);
      titleController.text = note.title;
      bodyController.text = note.body;
      tags = note.tags;
      finishLoadData();
    } catch (error) {
      finishLoadData(errorMessage: error.toString());
      debugPrint("error : " + error.toString());
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to fetch note from database',
        ),
      );
    }
  }

  void updateNote(String id) async {
    note
      ..id = id
      ..title = titleController.text
      ..tags = tags
      ..body = bodyController.text
      ..updatedAt = DateTime.now().toIso8601String();

    try {
      hiveHelper.saveObject(id, note);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Successfully update note',
        ),
      );
      finishLoadData();
    } catch (error) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to update note',
        ),
      );
      finishLoadData(errorMessage: error.toString());
      debugPrint("error : " + error.toString());
    }
  }

  void deleteNote(Note note) async {
    try {
      hiveHelper.box.delete(note.id);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Successfully delete note',
        ),
      );
      finishLoadData();
      Get.back(closeOverlays: true);
    } catch (error) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to fetch note from database',
        ),
      );
      finishLoadData(errorMessage: error.toString());
      debugPrint("error : " + error.toString());
    }
  }
}
