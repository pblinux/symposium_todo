import 'package:flutter/material.dart';
import 'package:symposium_todo/create.dart';
import 'package:symposium_todo/item.dart';
import 'package:symposium_todo/task.dart';

class TodoHomeScreen extends StatefulWidget {
  @override
  _TodoHomeScreenState createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    tasks.add(Task(Colors.blueAccent, 'hola 1', 'hola 1'));
    tasks.add(Task(Colors.blueAccent, 'hola 2', 'hola 2'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.list),
            SizedBox(width: 8.0),
            Text('Todo')
          ],
        ),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for (var task in tasks)
            Dismissible(
              key: ValueKey(task.hashCode),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                setState(() {
                  tasks.remove(task);
                });
              },
              child: Item(
                key: ValueKey(task.title),
                task: task,
              ),
            )
        ],
        onReorder: this.onReorder,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                maintainState: true,
                builder: (context) =>
                    CreateTaskScreen(onCreate: this.onCreate)));
          },
          child: Icon(Icons.add)),
    );
  }

  void onCreate(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void onReorder(oldIndex, newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final task = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, task);
    });
  }
}
