import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/todo.dart';

part 'todo_api.g.dart';

@RestApi(baseUrl: "https://repkow.up.railway.app/api/")
abstract class TodoApi {
  factory TodoApi(Dio dio, {String baseUrl}) = _TodoApi;

  @GET("/todos")
  Future<List<Todo>> getTodos();

  @GET("/todos/{id}")
  Future<Todo> getTodo(@Path("id") String id);

  @POST("/todos")
  Future<Todo> createTodo(@Body() Todo todo);

  @PUT("/todos/{id}")
  Future<Todo> updateTodo(@Path("id") String id, @Body() Todo todo);

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(@Path("id") String id);
}
