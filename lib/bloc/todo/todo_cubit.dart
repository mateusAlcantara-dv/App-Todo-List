import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/todo/todo_state.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState.initial());

  final uuid = Uuid();

  void addTodo(String title) {
    final newTodo = TodoModel(id: uuid.v4(), title: title, isDone: false);

    final updatedList = [...state.taskList, newTodo];
    emit(state.copyWith(taskList: updatedList));
  }

  void toggleTodo(String id) {
    final updatedList = state.taskList.map((todo){
      if (todo.id == id) {
        return todo.toggleDone();
      }
      return todo;
    }).toList();

    emit(state.copyWith(taskList: updatedList));
  }

  void deleteTodo(String id) {
    final updatedList =
        state.taskList.where((todo) => todo.id != id).toList();
    emit(state.copyWith(taskList: updatedList));
  }

  void editTodo(String id, String newTitle) {
    final updatedList = state.taskList.map((todo){
      if (todo.id == id) {
        return todo.copyWith(title: newTitle);
      }
      return todo;
    }).toList();

    emit(state.copyWith(taskList: updatedList));
  }
}