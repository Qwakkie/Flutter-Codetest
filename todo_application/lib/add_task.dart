import 'package:flutter/material.dart';
import 'package:todo_application/add_task_bloc.dart';
import 'package:todo_application/task.dart';

class AddTask extends StatefulWidget {
  final AddTaskBloc? addTaskBloc;

  const AddTask(this.addTaskBloc, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Task task = Task(description: "", date: DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(children: [
          Column(
            children: [
              TextFormField(
                onSaved: (val) => {
                  if (val != null) {task.description = val}
                },
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  icon: Icon(Icons.account_circle),
                ),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    onSaved: (val) {
                      task.date = selectedDate;
                    },
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: "Date",
                      icon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a date for your task";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _addTask();
                    }
                  },
                  child: const Text("Submit"))
            ],
          )
        ]));
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
    }
  }

  _addTask() {
    widget.addTaskBloc?.taskAddSink.add(task);
  }
}
