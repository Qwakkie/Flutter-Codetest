import 'dart:async';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_application/task.dart';

enum AddTaskEvent {
  addTask,
}

class AddTaskBloc {
  //StreamController to handle task list stream
  final _taskListController = StreamController<Task>.broadcast();
  Stream<Task> get taskListStream => _taskListController.stream;
  Sink<Task> get taskListSink => _taskListController.sink;

  void dispose() {
    _taskListController.close();
  }

  static of(BuildContext context) {}
}
