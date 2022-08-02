import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_application/add_task.dart';
import 'package:todo_application/add_task_bloc.dart';
import 'package:todo_application/task.dart';

void main() {
  // initial default method which is first executed
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final AddTaskBloc _addTaskBloc = AddTaskBloc();
  StreamSubscription? subscription;

  pushToScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen(_addTaskBloc)),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Stream stream = AddTaskBloc.of(context).someStream;
    subscription?.cancel();
    subscription = stream.listen((value) {
      // do something
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(
                      title: const Text("Flutter TO-DO App"),
                      bottom: const TabBar(tabs: [
                        Tab(text: "Day"),
                        Tab(text: "Week"),
                        Tab(text: "Month")
                      ])),
                  body: TabBarView(
                    children: [
                      TabDay(_addTaskBloc),
                      TabWeek(_addTaskBloc),
                      TabMonth(_addTaskBloc)
                    ],
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => pushToScreen(context),
              child: const Icon(Icons.add),
            )));
  }
}

class TabMonth extends StatefulWidget {
  const TabMonth(this.addTaskBloc, {Key? key}) : super(key: key);
  final AddTaskBloc addTaskBloc;

  @override
  State<StatefulWidget> createState() => TabMonthState();
}

class TabMonthState extends State<TabMonth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.addTaskBloc.taskListStream,
        builder: (BuildContext context, AsyncSnapshot<Task> snapshot) {
          return snapshot.hasData
              ? Text(snapshot.data.toString())
              : const Text('No tasks left for this month');
        });
  }

  @override
  void dispose() {
    widget.addTaskBloc.dispose();
    super.dispose();
  }
}

class TabWeek extends StatefulWidget {
  const TabWeek(this.addTaskBloc, {Key? key}) : super(key: key);
  final AddTaskBloc addTaskBloc;

  @override
  State<StatefulWidget> createState() => TabWeekState();
}

class TabWeekState extends State<TabWeek> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.addTaskBloc.taskListStream,
        builder: (BuildContext context, AsyncSnapshot<Task> snapshot) {
          return snapshot.hasData
              ? Text(snapshot.data.toString())
              : const Text('No tasks left for this week');
        });
  }

  @override
  void dispose() {
    widget.addTaskBloc.dispose();
    super.dispose();
  }
}

class TabDay extends StatefulWidget {
  const TabDay(this.addTaskBloc, {Key? key}) : super(key: key);
  final AddTaskBloc addTaskBloc;

  @override
  State<StatefulWidget> createState() => TabDayState();
}

class TabDayState extends State<TabDay> {
  List<Task?> tasks = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.addTaskBloc.taskListStream,
        builder: (BuildContext context, AsyncSnapshot<Task> snapshot) {
          return snapshot.hasData
              ? Text(snapshot.data.toString())
              : const Text('No tasks left for this week');
        });
  }

  @override
  void dispose() {
    widget.addTaskBloc.dispose();
    super.dispose();
  }
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen(this.addTaskBloc, {Key? key}) : super(key: key);

  final AddTaskBloc? addTaskBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add a Task")),
        body: AddTask(addTaskBloc));
  }
}
