class TodoModel {
  String id;
  String description;
  bool isDone;
  TodoModel({
    required this.id,
    this.isDone = false,
    this.description = '',
  });
}
