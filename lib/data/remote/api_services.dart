import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suitcore_note/model/add_note_response.dart';
import 'package:suitcore_note/model/note.dart';
import 'environment.dart';
import 'interceptor/dio.dart';
import 'wrapper/api_response.dart';

part 'api_services.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<RestClient> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    return RestClient(
      await AppDio().getDIO(
          headers: headers,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @GET('notes')
  Future<ApiResponses<Note>> getAllNotes();

  @GET('notes/{id}')
  Future<ApiResponse<Note>> getNoteById(@Path("id") String id);

  @POST('notes')
  Future<ApiResponse<AddNoteResponse>> addNewNote(@Body() Note note);

  @PUT('notes/{id}')
  Future<ApiResponse> editNote(@Path("id") String id, @Body() Note note);

  @DELETE('notes/{id}')
  Future<ApiResponse> deleteNote(@Path("id") String id);
}

final client = RestClient.create();
