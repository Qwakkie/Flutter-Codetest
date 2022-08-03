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

  @override
  void dispose() {
    _addTaskBloc.dispose();
    super.dispose();
  }
}

class TabMonth extends StatefulWidget {
  const TabMonth(this.addTaskBloc, {Key? key}) : super(key: key);
  final AddTaskBloc addTaskBloc;

  @override
  State<StatefulWidget> createState() => TabMonthState();
}

class TabMonthState extends State<TabMonth> {
  List<Task>? _tasks = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: widget.addTaskBloc.taskListStream,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            _tasks = snapshot.data;
          }
          return _tasks!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(
                          snapshot.data![index].description,
                          style: const TextStyle(),
                        ),
                        trailing: const Icon(Icons.access_time));
                  })
              : const Text('No tasks left for this month');
        });
  }
}

class TabWeek extends StatefulWidget {
  const TabWeek(this.addTaskBloc, {Key? key}) : super(key: key);
  final AddTaskBloc addTaskBloc;

  @override
  State<StatefulWidget> createState() => TabWeekState();
}

class TabWeekState extends State<TabWeek> {
  List<Task>? _tasks = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.addTaskBloc.taskListStream,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _tasks = snapshot.data;
          }
          return _tasks!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(
                          snapshot.data![index].description,
                          style: const TextStyle(),
                        ),
                        trailing: const Icon(Icons.access_time));
                  })
              : const Text('No tasks left for this week');
        });
  }
}

class TabDay extends StatefulWidget {
  const TabDay(this.addTaskBloc, {Key? key}) : super(key: key);
  final AddTaskBloc addTaskBloc;

  @override
  State<StatefulWidget> createState() => TabDayState();
}

class TabDayState extends State<TabDay> {
  List<Task>? _tasks = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.addTaskBloc.taskListStream,
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            _tasks = snapshot.data;
          }
          return _tasks!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(
                          snapshot.data![index].description,
                          style: const TextStyle(),
                        ),
                        trailing: const Icon(Icons.access_time));
                  })
              : const Text('No tasks left for this day');
        });
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
