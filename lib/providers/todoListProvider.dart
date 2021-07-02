import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/Model/todo.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    Todo(description: 'Hi', id: 'todi-0'),
    Todo(description: 'Hello', id: 'todi-1'),
    Todo(description: 'Bonjour', id: 'todi-2'),
  ]);
});

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);
  void add(String descripton) {
    state = [...state, Todo(description: descripton)];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            description: todo.description,
            completed: !todo.completed,
            id: todo.id,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((element) => element.id != target.id).toList();
  }
}
