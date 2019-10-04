import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:symposium_todo/task.dart';

enum TextType { TITLE, NOTE }

class CreateTaskScreen extends StatefulWidget {
  final Function onCreate;

  CreateTaskScreen({@required this.onCreate});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String currentTitle = '';
  String currentNote = '';

  Color tempColor = Colors.teal;
  Color currentColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva tarea'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              widget.onCreate(Task(currentColor, currentNote, currentTitle));
              Navigator.of(context).pop();
            },
            child: Text('Guardar'),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.title),
            title: Text('Titulo'),
            subtitle: Text(currentTitle.isEmpty ? 'Vacio' : currentTitle),
            onTap: () {
              _openTextPicker(TextType.TITLE);
            },
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Nota'),
            subtitle: Text(currentNote.isEmpty ? 'Vacio' : currentNote),
            onTap: () {
              _openTextPicker(TextType.NOTE);
            },
          ),
          ListTile(
            leading: CircleColor(circleSize: 32.0, color: currentColor),
            title: Text('Color'),
            onTap: () {
              _openColorPicker();
            },
          ),
        ],
      ),
    );
  }

  void _openTextPicker(TextType type) {
    final textController = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(type == TextType.TITLE
                ? 'Escribe el titulo'
                : 'Escribe tu nota'),
            content: TextField(
                controller: textController,
                minLines: type == TextType.TITLE ? 1 : 2,
                maxLines: type == TextType.TITLE ? 1 : 4),
            actions: [
              FlatButton(
                child: Text('Cancelar'),
                onPressed: Navigator.of(context).pop,
              ),
              FlatButton(
                child: Text('Listo'),
                onPressed: () {
                  setState(() {
                    if (type == TextType.TITLE)
                      currentTitle = textController.text;
                    else
                      currentNote = textController.text;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _openColorPicker() async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text('Elije un color'),
          content: MaterialColorPicker(
            shrinkWrap: true,
            selectedColor: currentColor,
            onColorChange: (color) => setState(() => tempColor = color),
          ),
          actions: [
            FlatButton(
              child: Text('Cancelar'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('Listo'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentColor = tempColor;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
