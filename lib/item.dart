import 'package:flutter/material.dart';
import 'package:symposium_todo/task.dart';

class Item extends StatelessWidget {
  final Task task;

  Item({this.task, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 6,
      margin: EdgeInsets.all(16.0),
      child: Material(
        color: task.color,
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(task.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text(
                task.note,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
