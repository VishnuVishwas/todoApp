import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';

import '../model/todo.dart';

class TodoItem extends StatefulWidget {
  final ToDo todo;
  final Function(String) onDeleteItem;
  const TodoItem({super.key, required this.todo, required this.onDeleteItem});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        onTap: () {
          setState(() {
            widget.todo.isDone = !widget.todo.isDone;
            // print(widget.todo.isDone);
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        tileColor: Colors.white,

        // check box
        leading: Icon(
            widget.todo.isDone
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: tdBlue),

        // todo content
        title: Text(
          widget.todo.todoText!,
          style: TextStyle(
              color: tdBlack,
              fontSize: 16,
              decoration:
                  widget.todo.isDone ? TextDecoration.lineThrough : null),
        ),

        // delete button
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 12.0),
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
            onPressed: () {
              widget.onDeleteItem(widget.todo.id!);
            },
          ),
        ),
      ),
    );
  }
}
