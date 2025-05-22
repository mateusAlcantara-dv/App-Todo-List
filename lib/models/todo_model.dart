class TodoModel {
  final String id;
  final String title;
  final bool isDone;

  TodoModel({required this.id, 
  required this.title, 
  required this.isDone});

  TodoModel toggleDone() {
    return TodoModel(id: id, title: title, isDone: !isDone);
  }

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}