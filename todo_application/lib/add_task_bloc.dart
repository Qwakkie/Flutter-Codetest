import 'dart:async';

// ignore: implementation_imports
import 'package:todo_application/task.dart';

class AddTaskBloc {
  AddTaskBloc() {
    taskAddStream.listen((task) {
      _addTask(task);
    });
  }
  //StreamController to handle task list stream
  final _taskAddController = StreamController<Task>();
  Stream<Task> get taskAddStream => _taskAddController.stream;
  Sink<Task> get taskAddSink => _taskAddController.sink;

  final _taskListController = StreamController<List<Task>>.broadcast();
  Stream<List<Task>> get taskListStream => _taskListController.stream;
  Sink<List<Task>> get taskListSink => _taskListController.sink;

  final List<Task> _tasks = [];
  _addTask(Task task) => {_tasks.add(task), taskListSink.add(_tasks)};

  void dispose() {
    _taskAddController.close();
    _taskListController.close();
  }
}
