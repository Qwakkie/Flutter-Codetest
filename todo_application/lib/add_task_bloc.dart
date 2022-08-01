import 'dart:async';

import 'package:todo_application/todo_item.dart';

enum AddTaskEvent {
  addTask,
}

class AddTaskBloc {
  //StreamController to handle event stream
  final _eventController = StreamController<AddTaskEvent>();
  Stream<AddTaskEvent> get eventStream => _eventController.stream;
  Sink<AddTaskEvent> get eventSink => _eventController.sink;

  //StreamController to handle task list stream
  final _taskListController = StreamController<Task>();
  Stream<Task> get taskListStream => _taskListController.stream;
  Sink<Task> get taskListSink => _taskListController.sink;

  //manage tasklist

  AddTaskBloc() {
    eventStream.listen((AddTaskEvent event) {
      if (event == AddTaskEvent.addTask) {
        //add button got pressed
      }
    });
  }

  void dispose() {
    _eventController.close();
    _taskListController.close();
  }
}
