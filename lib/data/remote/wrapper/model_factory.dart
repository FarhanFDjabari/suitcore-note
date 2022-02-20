import 'package:suitcore_note/model/add_note_response.dart';
import 'package:suitcore_note/model/note.dart';
import 'package:suitcore_note/model/user.dart';

abstract class ModelFactory {
  factory ModelFactory.fromJson(Type type, Map<String, dynamic> json) {
    var strType = type.toString().replaceAll("?", "");
    if (strType == (User).toString()) {
      return User.fromJson(json);
    } else if (strType == (Note).toString()) {
      return Note.fromJson(json);
    } else if (strType == (AddNoteResponse).toString()) {
      return AddNoteResponse.fromJson(json);
    } else {
      throw UnimplementedError('`$type` factory unimplemented.');
    }
  }
}
