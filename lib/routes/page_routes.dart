import 'package:get/get.dart';
import 'package:suitcore_note/binding/add_note_binding.dart';
import 'package:suitcore_note/binding/home_binding.dart';
import 'package:suitcore_note/binding/note_detail_binding.dart';
import 'package:suitcore_note/binding/saved_note_detail_binding.dart';
import 'package:suitcore_note/feature/add_note/add_note_page.dart';
import 'package:suitcore_note/feature/home/home_page.dart';
import 'package:suitcore_note/feature/loader/loading_page.dart';
import 'package:suitcore_note/feature/note/network_note_page.dart';
import 'package:suitcore_note/feature/note/note_detail_page.dart';
import 'package:suitcore_note/feature/saved_note/saved_note_detail_page.dart';
import 'package:suitcore_note/feature/saved_note/saved_note_page.dart';

import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.LOADER,
      page: () => LoadingPage(),
    ),
    GetPage(
      name: PageName.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: PageName.NOTE,
      page: () => const NetworkNotePage(),
    ),
    GetPage(
      name: PageName.SAVEDNOTE,
      page: () => const SavedNotePage(),
    ),
    GetPage(
      name: PageName.NOTEDETAIL,
      page: () => const NoteDetailPage(),
      binding: NoteDetailBinding(),
    ),
    GetPage(
      name: PageName.SAVEDNOTEDETAIL,
      page: () => const SavedNoteDetailPage(),
      binding: SavedNoteDetailBinding(),
    ),
    GetPage(
      name: PageName.ADDNEWNOTE,
      page: () => const AddNotePage(),
      binding: AddNoteBinding(),
    ),
  ];
}
