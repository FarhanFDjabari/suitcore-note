import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suitcore_note/data/local/hive/hive_helper.dart';
import 'package:suitcore_note/data/remote/api_services.dart';
import 'package:suitcore_note/data/remote/base/base_list_controller.dart';
import 'package:suitcore_note/data/remote/errorhandler/error_handler.dart';
import 'package:suitcore_note/model/note.dart';

class NetworkNoteController extends BaseListController<Note> {
  var hiveHelper = HiveHelper<Note>();

  @override
  void onInit() async {
    await getAllNotes();
    super.onInit();
  }

  Future<void> getAllNotes() async {
    loadingState();
    await client.then(
      (value) => value.getAllNotes().validateResponse().then((data) {
        dataList.clear();
        finishLoadData(list: data.data != null ? data.data! : []);
      }).handleError((onError) {
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
      }),
    );
  }

  void saveNote(Note note) async {
    try {
      hiveHelper.saveObject(note.id, note);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Saved',
          message: 'Note successfully saved to database',
        ),
      );
      Get.back(closeOverlays: true);
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Database Error',
          message: 'Failed to save note',
        ),
      );
    }
  }

  @override
  void loadNextPage() {
    // TODO: implement loadNextPage
  }

  @override
  void refreshPage() {
    getAllNotes();
  }
}
