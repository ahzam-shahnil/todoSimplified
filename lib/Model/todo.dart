
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

class Todo {
  final String id;
  final String description;
  final bool completed;

  Todo({
    required this.description,
    this.completed = false,
    String? id,
  }) : id = id ?? _uuid.v4();

  @override
  String toString() =>
      'Todo( description: $description, completed: $completed)';
}
