import 'package:get/get.dart';
import 'package:suitcore_note/feature/note/note_detail_controller.dart';

class NoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteDetailController());
  }
}
