import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/Model/todoFilter.dart';
import 'package:todos/providers/todoFilterProvider.dart';

class ToolBar extends ConsumerWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final filter = ref(todoListFilter);
    final search = ref(todoListSearch);
    final searchController = TextEditingController(text: search.state);
    Color? textColorFor(TodoListFilter value) {
      return filter.state == value ? Colors.blue : null;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Consumer(builder: (context, watch, child) {
              return Text(
                '${watch(uncompletedTodosCount).toString()} items left',
                overflow: TextOverflow.ellipsis,
              );
            }),
          ),
          Expanded(
            child: TextField(
              onEditingComplete: () {
                searchController.text.trim().isEmpty
                    ? search.state = ''
                    : search.state = searchController.text;
                searchController..text = search.state;
              },
              // onChanged: (value) => search.state = value.trim(),
              // onEditingComplete: () => search.state = searchController.text,
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          Tooltip(
            message: 'All todos',
            // ignore: deprecated_member_use, TextButton is not available in stable yet
            child: FlatButton(
              onPressed: () => filter.state = TodoListFilter.all,
              visualDensity: VisualDensity.compact,
              textColor: textColorFor(TodoListFilter.all),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            message: 'Only uncompleted todos',
            // ignore: deprecated_member_use, TextButton is not available in stable yet
            child: FlatButton(
              onPressed: () => filter.state = TodoListFilter.active,
              visualDensity: VisualDensity.compact,
              textColor: textColorFor(TodoListFilter.active),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            message: 'Only completed todos',
            // ignore: deprecated_member_use, TextButton is not available in stable yet
            child: FlatButton(
              onPressed: () => filter.state = TodoListFilter.completed,
              visualDensity: VisualDensity.compact,
              textColor: textColorFor(TodoListFilter.completed),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}
