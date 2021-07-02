import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/Model/todo.dart';
import 'package:todos/providers/todoListProvider.dart';

class TodoItem extends HookWidget {
  TodoItem({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final Todo todos;

  @override
  Widget build(BuildContext context) {
    final itemFocusNode = useFocusNode();
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Dismissible(
        key: ValueKey(todos.id),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          context.read(todoListProvider.notifier).remove(todos);
          // Then show a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${todos.id} dismissed'),
            ),
          );
        },
        child: Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focused) {
            if (focused) {
              textEditingController.text = todos.description;
            } else {
              
              // Commits Changes only when text field is Submitted
              context
                  .read(todoListProvider.notifier)
                  .edit(id: todos.id, description: textEditingController.text);
            }
          },
          child: ListTile(
            tileColor: Colors.lightBlue.withOpacity(0.1),
            hoverColor: Colors.blue[100],
            dense: true,
            focusColor: Colors.redAccent,
            shape: StadiumBorder(),
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            leading: Checkbox(
              value: todos.completed,
              onChanged: (value) =>
                  context.read(todoListProvider.notifier).toggle(todos.id),
            ),
            title: isFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text(todos.description),
          ),
        ),
      ),
    );
  }
}
