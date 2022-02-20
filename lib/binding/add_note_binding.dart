import 'package:get/get.dart';
import 'package:suitcore_note/feature/add_note/add_note_controller.dart';

class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNoteController());
  }
}
