import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/Model/todo.dart';
import 'package:todos/Model/todoFilter.dart';
import 'package:todos/providers/todoListProvider.dart';

final todoListFilter = StateProvider<TodoListFilter>((_) => TodoListFilter.all);
final todoListSearch = StateProvider<String>((_) => '');

/// This too uses [Provider], to avoid recomputing the filtered list unless either
/// the filter of or the todo-list updates.
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final search = ref.watch(todoListSearch);
  final todos = ref.watch(todoListProvider);
  List<Todo> filteredTodo;
  switch (filter.state) {
    case TodoListFilter.completed:
      filteredTodo = todos.where((todo) => todo.completed).toList();
      break;
    case TodoListFilter.active:
      filteredTodo = todos.where((todo) => !todo.completed).toList();
      break;
    case TodoListFilter.all:
    default:
      filteredTodo = todos;
      break;
  }
  if (search.state.isEmpty) {
    return filteredTodo;
  } else {
    //? reg expression to check if the search matches with the todo description
    RegExp exp = new RegExp(
      "\\b" + search.state + "\\b",
      caseSensitive: false,
    );

    return filteredTodo
        .where((todo) => exp.hasMatch(todo.description))
        .toList();
  }
});

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
