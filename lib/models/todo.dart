import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// @immutable
class Todo {
  const Todo({required this.description, required this.isCompleted});
  final String description;
  final bool isCompleted;
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier()
      : super([
          const Todo(description: 'item1', isCompleted: false),
          const Todo(description: 'item2', isCompleted: true),
          const Todo(description: 'item3', isCompleted: false),
        ]);

  void addNewTask(String newItem) {
    state = [...state, Todo(description: newItem, isCompleted: false)];
  }

  void removeTask(Todo todoRemoved) {
    state = [
      for (final todo in state)
        if (todo != todoRemoved) todo,
    ];
  }

  void toggleComplete(Todo todoToggled) {
    state = [
      for (final todo in state)
        if (todo == todoToggled)
          Todo(description: todo.description, isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});
