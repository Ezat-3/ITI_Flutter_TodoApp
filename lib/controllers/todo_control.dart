import 'package:todo_list/models/todo_model.dart';

class TodoController {
  List<TodoModel> todoList = [];

  void addTodo(TodoModel todo) {
    todoList.add(todo);
  }

  void updateTodo(TodoModel todo) {
    int index = todoList.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todoList[index] = todo;
    }
  }

  void deleteTodo(TodoModel todo) {
    todoList.removeWhere((t) => t.id == todo.id);
  }

  void toggleComplete(TodoModel todo) {
    todo.isDone = !todo.isDone;
  }
}
