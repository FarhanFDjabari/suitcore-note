import 'package:suitcore_note/data/remote/wrapper/model_factory.dart';

class AddNoteResponse implements ModelFactory {
  AddNoteResponse({required this.noteId});

  String noteId;

  factory AddNoteResponse.fromJson(Map<String, dynamic> json) =>
      AddNoteResponse(
        noteId: json['noteId'],
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
      };
}
