import 'package:get/get.dart';
import 'package:suitcore_note/feature/home/home_controller.dart';
import 'package:suitcore_note/feature/note/network_note_controller.dart';
import 'package:suitcore_note/feature/saved_note/saved_note_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SavedNoteController());
    Get.lazyPut(() => NetworkNoteController());
  }
}
