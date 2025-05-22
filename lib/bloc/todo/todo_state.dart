import 'package:flutter_todo_app/models/todo_model.dart';

class TodoState {
  final List<TodoModel> taskList;

  TodoState({required this.taskList});

  factory TodoState.initial() {
    return TodoState(taskList: []);
  }

  TodoState copyWith({List<TodoModel>? taskList}) {
    return TodoState(taskList: taskList ?? this.taskList);
  }

}