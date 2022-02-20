import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_note/data/remote/api_services.dart';
import 'package:suitcore_note/data/remote/base/base_object_controller.dart';
import 'package:suitcore_note/data/remote/errorhandler/error_handler.dart';
import 'package:suitcore_note/model/note.dart';

class NoteDetailController extends BaseObjectController<Note> {
  late TextEditingController titleController;
  late TextEditingController tagController;
  late TextEditingController bodyController;
  var tags = <String>[];
  var isNoteUpdated = false;
  late Note note;

  @override
  void onInit() async {
    titleController = TextEditingController();
    tagController = TextEditingController();
    bodyController = TextEditingController();
    note = Note(
      id: 'test',
      tags: [],
      title: '',
      body: '',
      createdAt: '',
      updatedAt: '',
    );
    await fetchNoteData(Get.parameters['id'] ?? '0');
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

  Future<void> fetchNoteData(String id) async {
    loadingState();
    await client.then(
      (value) => value.getNoteById(id).validateResponse().then((data) {
        note = data.result!;
        titleController.text = note.title;
        bodyController.text = note.body;
        tags = note.tags;
        finishLoadData();
      }).handleError((onError) {
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
      }),
    );
  }

  void updateNote(String id) async {
    note
      ..id = id
      ..title = titleController.text
      ..tags = tags
      ..body = bodyController.text;

    await client.then(
      (value) => value.editNote(id, note).validateStatus().then((data) {
        isNoteUpdated = true;
        Get.showSnackbar(
          GetSnackBar(
            duration: const Duration(seconds: 2),
            message: data.message,
          ),
        );
        finishLoadData();
      }).handleError((onError) {
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
      }),
    );
  }

  void deleteNote(Note note) async {
    loadingState();

    await client.then(
      (value) => value.deleteNote(note.id).validateStatus().then((data) {
        isNoteUpdated = true;
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 2),
            message: data.message,
          ),
        );
        finishLoadData();
        Get.back(closeOverlays: true, result: isNoteUpdated);
      }).handleError((onError) {
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
      }),
    );
  }
}
