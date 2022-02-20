import 'package:get/get.dart';
import 'package:suitcore_note/feature/saved_note/saved_note_controller.dart';

class SavedNoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedNoteController());
  }
}
