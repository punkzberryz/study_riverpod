import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_riverpod/models/todo.dart';

class TodoPage extends StatelessWidget {
  static String id = 'Todo Page';
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TO DO PAGE'),
        ),
        body: const TodoListView(),
      ),
    );
  }
}

class TodoListView extends HookConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    dynamic textFieldController = TextEditingController();

    return ListView(
      children: [
        newTaskTextField(
          textOnChanged: (String taskText) {},
          buttonOnPressed: (() {
            if (textFieldController.text != '') {
              ref
                  .read(todoProvider.notifier)
                  .addNewTask(textFieldController.text ?? '');
            }
            FocusManager.instance.primaryFocus
                ?.unfocus(); //dismiss keyboard after add a new task
          }),
          textFieldController: textFieldController,
          clearAction: textFieldController.clear,
        ),
        for (Todo todo in todos)
          TextButton(
            onPressed: (() {}),
            onLongPress: () {
              ref.read(todoProvider.notifier).removeTask(todo);
            },
            child: CheckboxListTile(
              value: todo.isCompleted,
              onChanged: (value) {
                ref.read(todoProvider.notifier).toggleComplete(todo);
              },
              title: Text(todo.description),
            ),
          )
      ],
    );
  }
}

Widget newTaskTextField({
  required Function(String) textOnChanged,
  required VoidCallback buttonOnPressed,
  required dynamic textFieldController,
  required VoidCallback clearAction,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Add new Task:',
          style: TextStyle(fontSize: 20),
        ),
        TextField(
          controller: textFieldController,
          onChanged: textOnChanged,
          decoration: InputDecoration(
            hintText: 'Enter a new task',
            suffixIcon: IconButton(
              onPressed: clearAction,
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
        TextButton(
          onPressed: buttonOnPressed,
          child: const Text('Add'),
        ),
      ],
    );
