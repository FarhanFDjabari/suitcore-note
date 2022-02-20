import 'package:hive/hive.dart';
import 'package:suitcore_note/model/note.dart';
import 'package:suitcore_note/model/user.dart';

class HiveAdapters {
  void registerAdapter() {
    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<Note>(NoteAdapter());
  }
}
