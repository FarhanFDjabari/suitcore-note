import 'package:get/get.dart';
import 'package:suitcore_note/data/local/hive/hive_helper.dart';
import 'package:suitcore_note/data/remote/base/base_list_controller.dart';
import 'package:suitcore_note/model/note.dart';

class SavedNoteController extends BaseListController<Note> {
  var hiveHelper = HiveHelper<Note>();

  @override
  void onInit() {
    super.onInit();
  }

  void removeNote(Note note) async {
    try {
      hiveHelper.box.delete(note.id);
      Get.back();
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Database Error',
          message: 'Failed to remove note from database',
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
    // TODO: implement refreshPage
  }
}
