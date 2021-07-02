import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/providers/todoFilterProvider.dart';
import 'package:todos/providers/todoListProvider.dart';
import 'package:todos/widgets/title.dart';
import 'package:todos/widgets/todo_item.dart';
import 'package:todos/widgets/toolbar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final newTodoCcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        context.read(todoListSearch).state = '';
      },
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              children: [
                TitleRow(),
                TextField(
                  controller: newTodoCcontroller,
                  decoration: const InputDecoration(
                    labelText: 'What needs to be done?',
                  ),
                  onSubmitted: (value) {
                    context.read(todoListProvider.notifier).add(value);
                    newTodoCcontroller.clear();
                  },
                ),
                const SizedBox(
                  height: 42,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ToolBar(),
                    Consumer(
                      builder: (context, watch, child) {
                        final todos = watch(filteredTodos);

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: todos.length,
                          itemBuilder: (context, index) => TodoItem(
                            todos: todos[index],
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
