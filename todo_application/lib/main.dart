import 'package:flutter/material.dart';
import 'package:todo_application/add_task_bloc.dart';

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
  pushToScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome to Flutter")),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                  bottom: const TabBar(tabs: [
            Tab(text: "Day"),
            Tab(text: "Week"),
            Tab(text: "Month")
          ]))),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => pushToScreen(context),
          child: const Icon(Icons.add),
        ));
  }
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add a Task")),
        body: const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Enter Task Description"),
        ));
  }
}
